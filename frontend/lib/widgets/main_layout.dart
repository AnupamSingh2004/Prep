import 'package:flutter/material.dart';
import '../widgets/dynamic_bottom_nav.dart';
import '../services/navigation_service.dart';
import '../models/user_model.dart';
import '../widgets/home_page_wrapper.dart';
import '../screens/search_page.dart';
import '../screens/schedule_page.dart';
import '../screens/profile_page.dart';
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
      _buildSearchPage(),
      _buildSchedulePage(),
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
      body: Stack(
        children: [
          // Main content area - Column layout
          Column(
            children: [
              // Main content area - takes remaining space
              Expanded(
                child: IndexedStack(
                  index: _currentIndex,
                  children: _pages,
                ),
              ),
              
              // Bottom Navigation Bar - fixed at bottom
              ModernBottomNavBar(
                currentIndex: _currentIndex,
                onTap: _onNavigationTap,
                items: NavigationConfig.mainNavItems,
              ),
            ],
          ),
          
          // Loading overlay - positioned above everything when needed
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
    );
  }

  // Page builders
  Widget _buildHomePage() {
    if (widget.user != null) {
      return HomePageWrapper(user: widget.user!);
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

  Widget _buildSearchPage() {
    return const SearchPage();
  }

  Widget _buildSchedulePage() {
    return const SchedulePage();
  }

  Widget _buildProfilePage() {
    return ProfilePage(user: widget.user);
  }
}