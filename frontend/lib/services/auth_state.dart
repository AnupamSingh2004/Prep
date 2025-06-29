import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/user_model.dart';

class AuthState extends ChangeNotifier {
  bool _isAuthenticated = false;
  User? _user;
  bool _isLoading = true;

  bool get isAuthenticated => _isAuthenticated;
  User? get user => _user;
  bool get isLoading => _isLoading;

  // Initialize authentication state
  Future<void> initializeAuth() async {
    _isLoading = true;
    notifyListeners();

    try {
      final accessToken = await ApiService.getAccessToken();
      
      if (accessToken != null && accessToken.isNotEmpty) {
        final userProfileResult = await ApiService.getUserProfile();
        
        if (userProfileResult['status'] == 'success') {
          final userData = userProfileResult['data'];
          _user = User.fromJson(userData);
          _isAuthenticated = true;
        } else {
          // Try to refresh token
          final refreshSuccess = await ApiService.refreshToken();
          if (refreshSuccess) {
            final retryResult = await ApiService.getUserProfile();
            if (retryResult['status'] == 'success') {
              final userData = retryResult['data'];
              _user = User.fromJson(userData);
              _isAuthenticated = true;
            } else {
              await _clearAuthState();
            }
          } else {
            await _clearAuthState();
          }
        }
      } else {
        await _clearAuthState();
      }
    } catch (e) {
      print('Error initializing auth: $e');
      await _clearAuthState();
    }

    _isLoading = false;
    notifyListeners();
  }

  // Set authenticated user (called after successful login)
  Future<void> setAuthenticatedUser(User user) async {
    _user = user;
    _isAuthenticated = true;
    _isLoading = false;
    notifyListeners();
  }

  // Logout
  Future<void> logout() async {
    await ApiService.clearTokens();
    await _clearAuthState();
  }

  // Clear authentication state
  Future<void> _clearAuthState() async {
    _user = null;
    _isAuthenticated = false;
    await ApiService.clearTokens();
  }
}
