# Google Sign-In Error Code 10 Troubleshooting Guide

## Current Error
`DEVELOPER_ERROR (Code 10)` - Configuration mismatch

## Possible Causes & Solutions

### 1. OAuth Consent Screen Issues
**Problem**: Your app might be in "Testing" mode and your email isn't added as a test user.

**Solution**: 
1. Go to Google Cloud Console → APIs & Services → OAuth consent screen
2. Check if the app is in "Testing" mode
3. If yes, add your email (`accounfr4@gmail.com`) to the "Test users" list
4. OR publish the app to make it available to all users

### 2. Client ID Copy Error
**Problem**: The client IDs might have invisible characters or be incomplete.

**Solution**:
1. Go back to Google Cloud Console → APIs & Services → Credentials
2. Click on the Web client ID to view details
3. Copy the COMPLETE client ID again (it should be longer than what you currently have)
4. Make sure there are no extra spaces or hidden characters

### 3. SHA-1 Fingerprint Mismatch
**Problem**: The SHA-1 in Google Cloud Console doesn't match your current debug keystore.

**Solution**:
```bash
cd /home/anupam/code/FlutterProjects/Prep/frontend/android
./gradlew signingReport
```
Then update Google Cloud Console with the exact SHA-1 shown.

### 4. Package Name Mismatch
**Problem**: Package name in Google Cloud Console doesn't match exactly.

**Solution**: Verify package name is exactly `com.example.first_app` in Google Cloud Console.

### 5. API Not Enabled
**Problem**: Required APIs aren't enabled.

**Solution**: Enable these APIs in Google Cloud Console:
- Google Identity Services API
- Google+ API (legacy, but sometimes needed)

## Current Configuration Debug
Based on your .env file:
- Android Client: `266959479556-beq2mv0sh297pmmc65jqg207ju4dd2c5.apps.googleusercontent.com`
- Web Client: `266959479556-bt75fhegabut22bvvcce1sth113c3.apps.googleusercontent.com`

## Next Steps
1. Check OAuth consent screen settings first
2. Verify the complete web client ID from Google Cloud Console
3. Test without serverClientId (already done)
4. If still failing, try creating new OAuth credentials

## Test Command
The current debug output will show you the exact client IDs being used.
Compare them with what's shown in Google Cloud Console.
