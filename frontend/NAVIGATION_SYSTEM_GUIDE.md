# Dynamic Bottom Navigation System

This is a complete, independent, and dynamic bottom navigation system for your Flutter app that matches your application's theme.

## Features

- **Independent**: Works across multiple pages without being tied to specific screens
- **Dynamic**: Easy to add/remove navigation items
- **Theme-matching**: Uses your app's gradient colors and design language
- **Animated**: Smooth transitions and interactive animations
- **Route-aware**: Automatically excludes itself from login/signup pages
- **Extensible**: Easy to add new pages and navigation items

## File Structure

```
lib/
├── services/
│   └── navigation_service.dart      # Navigation service and route configuration
├── widgets/
│   ├── dynamic_bottom_nav.dart      # The reusable bottom navigation widget
│   ├── main_layout.dart            # Main layout wrapper with navigation
│   └── home_page_wrapper.dart      # Clean home page without bottom nav
├── screens/
│   ├── home_page.dart              # Updated to use new navigation system
│   ├── search_page.dart            # Search functionality page
│   ├── schedule_page.dart          # Appointments and scheduling
│   └── profile_page.dart           # User profile page
└── demo/
    └── navigation_demo.dart        # Demo app to test the navigation
```

## How to Use

### 1. Replace Your Existing HomePage

Your original `HomePage` has been simplified to use the new navigation system:

```dart
class HomePage extends StatelessWidget {
  final User user;

  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayoutController(user: user);
  }
}
```

### 2. Adding New Navigation Items

To add new navigation items, modify `NavigationConfig.mainNavItems` in `services/navigation_service.dart`:

```dart
static const List<BottomNavItem> mainNavItems = [
  // Existing items...
  BottomNavItem(
    icon: Icons.favorite_outline,
    activeIcon: Icons.favorite_rounded,
    label: 'Favorites',
    route: AppRoutes.favorites,  // Add route to AppRoutes class
    activeColor: Color(0xFFf06292),
  ),
];
```

### 3. Adding New Pages

1. **Create the page** in `lib/screens/`:
```dart
class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Your page content here
  }
}
```

2. **Add the route** to `AppRoutes` in `navigation_service.dart`:
```dart
class AppRoutes {
  // Existing routes...
  static const String favorites = '/favorites';
}
```

3. **Add the route handler** in `main_layout.dart`:
```dart
Route<dynamic>? _generateRoute(RouteSettings settings) {
  switch (settings.name) {
    // Existing cases...
    case AppRoutes.favorites:
      return _createRoute(
        _wrapWithLayout(
          FavoritesPage(),
          settings.name!,
        ),
      );
  }
}
```

### 4. Excluding Pages from Bottom Navigation

To exclude pages from showing the bottom navigation (like login/signup), add them to `excludedRoutes` in `navigation_service.dart`:

```dart
static const List<String> excludedRoutes = [
  AppRoutes.login,
  AppRoutes.register,
  AppRoutes.authWrapper,
  AppRoutes.onboarding,  // Add new pages here
];
```

### 5. Customizing the Theme

The navigation bar uses your app's gradient theme. To customize colors, modify the gradient in `dynamic_bottom_nav.dart`:

```dart
decoration: BoxDecoration(
  gradient: const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF667eea),  // Change these colors
      Color(0xFF764ba2),
      Color(0xFF2E7D8A),
    ],
    stops: [0.0, 0.5, 1.0],
  ),
  // ...
),
```

## Navigation Methods

Use the `NavigationService` for programmatic navigation:

```dart
// Navigate to a route
NavigationService.navigateTo(AppRoutes.search);

// Navigate and replace current route
NavigationService.navigateAndReplace(AppRoutes.profile);

// Navigate and clear navigation stack
NavigationService.navigateAndClearStack(AppRoutes.login);

// Go back
NavigationService.goBack();
```

## Integration with Your Existing App

To integrate this navigation system with your existing app:

1. **Replace your main MaterialApp** to use the navigation system:
```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService.navigatorKey,
      home: MainLayoutController(user: yourUser),
      // ... other properties
    );
  }
}
```

2. **Update your authentication flow** to use the new HomePage:
```dart
// In your auth wrapper or login success handler
Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => HomePage(user: user),  // This now uses the new system
  ),
);
```

## Testing the Navigation

You can test the navigation system using the demo:

```dart
// Run this to test the navigation
void main() {
  runApp(NavigationDemo());
}
```

## Benefits

1. **Consistency**: Same navigation experience across all app screens
2. **Maintainability**: Central configuration for all navigation items
3. **Scalability**: Easy to add new pages and navigation items
4. **User Experience**: Smooth animations and haptic feedback
5. **Theme Integration**: Matches your app's design language perfectly
6. **Route Management**: Proper route handling with page transitions

## Customization Options

- **Animation Speed**: Modify duration values in the animation controllers
- **Colors**: Change gradient colors and opacity values
- **Icons**: Use different icons for active/inactive states
- **Haptic Feedback**: Enable/disable vibration on tap
- **Page Transitions**: Customize slide animations and curves

This navigation system provides a solid foundation that can grow with your app while maintaining consistency and performance.
