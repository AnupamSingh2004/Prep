import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  
  static BuildContext? get currentContext => navigatorKey.currentContext;
  
  static void navigateTo(String routeName, {Object? arguments}) {
    navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }
  
  static void navigateAndReplace(String routeName, {Object? arguments}) {
    navigatorKey.currentState?.pushReplacementNamed(routeName, arguments: arguments);
  }
  
  static void navigateAndClearStack(String routeName, {Object? arguments}) {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      routeName, 
      (route) => false,
      arguments: arguments,
    );
  }
  
  static void goBack() {
    if (navigatorKey.currentState?.canPop() == true) {
      navigatorKey.currentState?.pop();
    }
  }
}

class AppRoutes {
  static const String home = '/home';
  static const String search = '/search';
  static const String schedule = '/schedule';
  static const String profile = '/profile';
  static const String chatbot = '/chatbot';
  static const String login = '/login';
  static const String register = '/register';
  static const String authWrapper = '/';
  
  // Add more routes as needed
  static const String settings = '/settings';
  static const String notifications = '/notifications';
  static const String appointments = '/appointments';
  static const String doctors = '/doctors';
  static const String health = '/health';
}

class BottomNavItem {
  final IconData icon;
  final IconData? activeIcon;
  final String label;
  final String route;
  final Color? activeColor;

  const BottomNavItem({
    required this.icon,
    required this.label,
    required this.route,
    this.activeIcon,
    this.activeColor,
  });
}

class NavigationConfig {
  static const List<BottomNavItem> mainNavItems = [
    BottomNavItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
      label: 'Home',
      route: AppRoutes.home,
      activeColor: Color(0xFF10B981), // Medical green
    ),
    BottomNavItem(
      icon: Icons.search_outlined,
      activeIcon: Icons.search_rounded,
      label: 'Search',
      route: AppRoutes.search,
      activeColor: Color(0xFF059669), // Darker green
    ),
    BottomNavItem(
      icon: Icons.smart_toy_outlined,
      activeIcon: Icons.smart_toy_rounded,
      label: 'Assistant',
      route: AppRoutes.chatbot,
      activeColor: Color(0xFF2E7D32), // Medical assistant green
    ),
    BottomNavItem(
      icon: Icons.calendar_today_outlined,
      activeIcon: Icons.calendar_today_rounded,
      label: 'Schedule',
      route: AppRoutes.schedule,
      activeColor: Color(0xFF047857), // Even darker green
    ),
    BottomNavItem(
      icon: Icons.person_outline_rounded,
      activeIcon: Icons.person_rounded,
      label: 'Profile',
      route: AppRoutes.profile,
      activeColor: Color(0xFF065F46), // Darkest green
    ),
  ];
  
  // Routes where bottom navigation should NOT appear
  static const List<String> excludedRoutes = [
    AppRoutes.login,
    AppRoutes.register,
    AppRoutes.authWrapper,
  ];
  
  static bool shouldShowBottomNav(String currentRoute) {
    return !excludedRoutes.contains(currentRoute);
  }
}
