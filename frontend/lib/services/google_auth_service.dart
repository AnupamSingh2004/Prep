import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );

  static Future<Map<String, dynamic>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return {'success': false, 'message': 'Google sign in cancelled'};
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      if (googleAuth.accessToken == null) {
        return {'success': false, 'message': 'Failed to get Google access token'};
      }

      return {
        'success': true,
        'accessToken': googleAuth.accessToken,
        'user': {
          'email': googleUser.email,
          'displayName': googleUser.displayName,
          'photoUrl': googleUser.photoUrl,
        }
      };
    } catch (e) {
      return {'success': false, 'message': 'Google sign in error: $e'};
    }
  }

  static Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}