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
      extendBody: true, // This removes the white space
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

class _MainLayoutControllerState extends State<MainLayoutController> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNavigationTap(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          _buildHomePage(),
          _buildSearchPage(),
          _buildSchedulePage(),
          _buildProfilePage(),
        ],
      ),
      bottomNavigationBar: ModernBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavigationTap,
        items: NavigationConfig.mainNavItems,
      ),
      extendBody: true,
    );
  }

  // Page builders for PageView
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
