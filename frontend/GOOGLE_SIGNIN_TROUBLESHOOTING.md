# Google Sign-In Setup and Troubleshooting Guide

## Current Issue Analysis

You're getting error code 10 (`DEVELOPER_ERROR`) which typically means there's a configuration mismatch between your app and the Google Cloud Console setup.

## Current Configuration
- **Package Name**: `com.example.first_app`
- **SHA-1**: `03:BA:58:0D:5B:E6:F0:8B:95:59:AB:3C:CA:5D:1E:05:6E:2E:EA:49`
- **Android Client ID**: `266959479556-beq2mv0sh297pmmc65jqg207ju4dd2c5.apps.googleusercontent.com`
- **Web Client ID**: `266959479556-bt75fhegabut22bvvcce1sth113c3.apps.googleusercontent.com`

## ⚠️ Potential Issue Identified

The Web Client ID appears to be incomplete. Typical Google OAuth client IDs are longer. Please verify that your complete Web Client ID is correct.

## Steps to Fix

### 1. Verify Google Cloud Console Setup

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Select your project
3. Navigate to **APIs & Services** → **Credentials**

### 2. Check Your OAuth 2.0 Client IDs

#### Android Client ID:
- **Application type**: Android
- **Package name**: `com.example.first_app`
- **SHA-1 certificate fingerprint**: `03:BA:58:0D:5B:E6:F0:8B:95:59:AB:3C:CA:5D:1E:05:6E:2E:EA:49`

#### Web Client ID:
- **Application type**: Web application
- **Name**: Any name you prefer
- Copy the complete client ID (should be longer than what you currently have)

### 3. Enable Required APIs

Make sure these APIs are enabled in your Google Cloud project:
- **Google Identity Services API** (recommended)
- OR **Google+ API** (legacy)

### 4. Update Configuration

Once you have the correct client IDs, update `lib/config/google_auth_config.dart`:

```dart
class GoogleAuthConfig {
  // Replace with your actual client IDs from Google Cloud Console
  static const String androidClientId = 'YOUR_ANDROID_CLIENT_ID.apps.googleusercontent.com';
  static const String webClientId = 'YOUR_COMPLETE_WEB_CLIENT_ID.apps.googleusercontent.com';
  static const String serverClientId = webClientId;
  
  // Your current SHA-1 and package info (correct)
  // SHA-1: 03:BA:58:0D:5B:E6:F0:8B:95:59:AB:3C:CA:5D:1E:05:6E:2E:EA:49
  // Package name: com.example.first_app
}
```

### 5. Test the Configuration

I've created a test page for you. To use it:

1. Add this route to your main.dart or create a button to navigate to `TestGoogleAuth()` page
2. The test page will show you all the configuration details
3. It will help identify exactly what's wrong

### 6. Common Error Codes and Solutions

- **Error 10**: Configuration mismatch
  - Check SHA-1 fingerprint
  - Verify package name
  - Ensure client IDs are correct and complete
  
- **Error 12**: Network error
  - Check internet permission (already added)
  - Verify device connectivity

- **Error 8**: Internal error
  - Usually temporary, try again later

### 7. Quick Verification Checklist

- [ ] Google Cloud project exists and is selected
- [ ] Google Identity Services API is enabled
- [ ] Android OAuth client has correct package name
- [ ] Android OAuth client has correct SHA-1 fingerprint
- [ ] Web OAuth client is created
- [ ] Client IDs are copied correctly (especially web client ID)
- [ ] No extra spaces or characters in client IDs

### 8. Alternative Debugging Approach

If the issue persists, try creating a minimal GoogleSignIn instance without serverClientId first:

```dart
final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email', 'profile'],
  // Remove serverClientId temporarily to test basic functionality
);
```

This will help determine if the issue is with the basic setup or specifically with the serverClientId configuration.

## Next Steps

1. **Verify your Web Client ID is complete and correct**
2. **Use the test page to debug the configuration**
3. **Check Google Cloud Console for any error messages**
4. **Try the alternative debugging approach if needed**

Once you have the correct client IDs, the Google Sign-In should work properly.
