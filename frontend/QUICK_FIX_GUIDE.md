# Simple Google Sign-In Fix Guide

## The Issue
You're getting error code 10 (DEVELOPER_ERROR) which means Google can't verify your app's identity.

## The Most Likely Fix

The web client ID in your config looks incomplete:
`266959479556-bt75fhegabut22bvvcce1sth113c3.apps.googleusercontent.com`

A complete Google OAuth client ID is usually much longer, like:
`266959479556-bt75fhegabut22bvvcce1sth113c3abc123def456.apps.googleusercontent.com`

## Steps to Fix:

### 1. Get the Correct Client IDs

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Select your project (or create one)
3. Go to **APIs & Services** → **Credentials**
4. Create or find your OAuth 2.0 Client IDs:

   **For Android:**
   - Application type: Android
   - Package name: `com.example.first_app`
   - SHA-1: `03:BA:58:0D:5B:E6:F0:8B:95:59:AB:3C:CA:5D:1E:05:6E:2E:EA:49`

   **For Web:**
   - Application type: Web application
   - Name: Any name you want

### 2. Copy the COMPLETE client IDs

Make sure you copy the entire client ID, not just a portion of it.

### 3. Update your config file

Replace the client IDs in `lib/config/google_auth_config.dart` with the complete ones from Google Cloud Console.

### 4. Test the basic configuration

I've temporarily removed the `serverClientId` from the GoogleSignIn configuration to test the basic Android OAuth setup first. If this works, we can add the serverClientId back.

## Quick Test

Try running your app now. The Google Sign-In should work with just the Android OAuth client if it's configured correctly.

## If it still doesn't work:

1. Double-check the SHA-1 fingerprint matches exactly
2. Verify the package name is exactly `com.example.first_app`
3. Make sure the Google Identity Services API is enabled in your Google Cloud project
4. Try creating new OAuth credentials from scratch

The most common cause of error 10 is an incomplete or incorrect client ID configuration.
