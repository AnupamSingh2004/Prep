import 'package:first_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/dynamic_bottom_nav.dart';
import '../services/navigation_service.dart';
import '../models/user_model.dart';
import '../screens/home_page.dart';
import '../screens/upload_prescription_screen.dart';
import '../screens/stores_screen.dart';
import '../screens/schemes_screen.dart';
import '../screens/chatbot_screen.dart';
import '../widgets/modern_bottom_nav.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final String currentRoute;
  final User? user;

  const MainLayout({
    Key? key,
    required this.child,
    required this.currentRoute,
    this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: DynamicBottomNavBar(
        currentRoute: currentRoute,
      ),
      extendBody: false,
    );
  }
}

class MainLayoutController extends StatefulWidget {
  final User? user;

  const MainLayoutController({
    Key? key,
    this.user,
  }) : super(key: key);

  @override
  State<MainLayoutController> createState() => _MainLayoutControllerState();
}

class _MainLayoutControllerState extends State<MainLayoutController>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  bool _isLoading = false;
  late AnimationController _loadingAnimationController;
  late Animation<double> _loadingAnimation;

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _initializePages();
  }

  void _setupAnimations() {
    _loadingAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _loadingAnimation = CurvedAnimation(
      parent: _loadingAnimationController,
      curve: Curves.easeInOut,
    );
  }

  void _initializePages() {
    _pages.addAll([
      _buildHomePage(),
      _buildScanPage(),
      _buildStoresPage(),
      _buildSchemesPage(),
      _buildChatbotPage(),
      _buildProfilePage(),
    ]);
  }

  @override
  void dispose() {
    _loadingAnimationController.dispose();
    super.dispose();
  }

  void _onNavigationTap(int index) async {
    if (index == _currentIndex || _isLoading) return;
    
    setState(() {
      _isLoading = true;
    });
    
    _loadingAnimationController.forward();
    
    // Simulate loading time
    await Future.delayed(const Duration(milliseconds: 300));
    
    setState(() {
      _currentIndex = index;
    });
    
    await Future.delayed(const Duration(milliseconds: 200));
    
    _loadingAnimationController.reverse();
    
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true, // Allow content to resize for keyboard
      extendBody: true, // Extend body behind the bottom nav
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: _pages,
          ),
          
          // Loading overlay when needed
          if (_isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.3),
                child: Center(
                  child: AnimatedBuilder(
                    animation: _loadingAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: 0.8 + (_loadingAnimation.value * 0.2),
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF10B981),
                              ),
                              strokeWidth: 3,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: ModernBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavigationTap,
        items: NavigationConfig.mainNavItems,
      ),
    );
  }

  // Page builders
  Widget _buildHomePage() {
    if (widget.user != null) {
      return HomePage(user: widget.user!);
    }
    
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF667eea),
            Color(0xFF764ba2),
            Color(0xFF2E7D8A),
          ],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Text(
            'Home Page\n(Please provide user data)',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScanPage() {
    return const UploadPrescriptionScreen();
  }

  Widget _buildStoresPage() {
    return const StoresScreen();
  }

  Widget _buildSchemesPage() {
    return const SchemesScreen();
  }

  Widget _buildChatbotPage() {
    return const ChatbotScreen();
  }

  Widget _buildProfilePage() {
    return const ProfileScreen(); // Now loads user data dynamically
  }
}