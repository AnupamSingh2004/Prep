import 'package:flutter_dotenv/flutter_dotenv.dart';

class GoogleAuthConfig {
  // Load OAuth client IDs from environment variables
  static String get androidClientId => 
    dotenv.env['GOOGLE_ANDROID_CLIENT_ID'] ?? _throwMissingEnvError('GOOGLE_ANDROID_CLIENT_ID');
  
  static String get webClientId => 
    dotenv.env['GOOGLE_WEB_CLIENT_ID'] ?? _throwMissingEnvError('GOOGLE_WEB_CLIENT_ID');
  
  // Server Client ID (use web client ID for server-side verification)
  static String get serverClientId => webClientId;
  
  // API Base URL
  static String get apiBaseUrl => 
    dotenv.env['API_BASE_URL'] ?? 'http://localhost:8000/api';
  
  // Helper method to throw descriptive error for missing environment variables
  static String _throwMissingEnvError(String key) {
    throw Exception(
      'Missing required environment variable: $key\n'
      'Please check your .env file and ensure it contains:\n'
      '$key=your_actual_value_here'
    );
  }
  
  // Configuration validation method
  static void validateConfig() {
    try {
      // This will throw if any required variables are missing
      androidClientId; // Access to validate
      webClientId; // Access to validate
      print('✅ Google Auth configuration loaded successfully');
    } catch (e) {
      print('❌ Google Auth configuration error: $e');
      rethrow;
    }
  }
  
  // For reference (these should match your .env values)
  // Package name: com.example.first_app
  // SHA-1: 03:BA:58:0D:5B:E6:F0:8B:95:59:AB:3C:CA:5D:1E:05:6E:2E:EA:49
}
