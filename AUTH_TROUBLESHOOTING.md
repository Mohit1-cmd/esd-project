# Authentication Troubleshooting Guide

## Issue: Redirect Loop on Login

### Problem
Clicking "Login with Google" redirects back to frontend without Google authentication screen.

### Root Causes

1. **Backend not restarted** - AuthController changes not loaded
2. **Missing Google OAuth credentials** - Environment variables not set
3. **Session cookie issues** - CORS/cookie configuration

## Solution Steps

### Step 1: Verify Google OAuth Credentials

Check your `.env` file has:
```env
GOOGLE_CLIENT_ID=your-client-id-here
GOOGLE_CLIENT_SECRET=your-secret-here
```

If missing, get them from: https://console.cloud.google.com/apis/credentials

**Authorized redirect URIs must include**:
- `http://localhost:8080/login/oauth2/code/google`

### Step 2: Restart Backend Server

The backend MUST be restarted to load new authentication configuration:

```bash
# Stop current backend (if running)
# Then restart:
cd /Users/mohitkhapekar/Documents/ESD/backend
./run.sh
```

### Step 3: Verify Backend is Running

Check console output for:
- No errors about missing environment variables
- "Started EndProjectApplication" message
- Spring Security OAuth2 configuration loaded

### Step 4: Test OAuth URL Directly

Try visiting in browser:
```
http://localhost:8080/oauth2/authorization/google
```

**Expected**: Should redirect to Google login page  
**If not**: Google credentials are not configured

### Step 5: Check Browser Console

Open DevTools (F12) and check:
- Network tab for failed requests
- Console tab for errors
- Look for CORS errors or 401 responses

## Common Issues

### Issue: "Missing client id or secret"
**Solution**: Add credentials to `.env` file and restart backend

### Issue: "Redirect URI mismatch"  
**Solution**: Add `http://localhost:8080/login/oauth2/code/google` to Google Console authorized redirects

### Issue: Immediate redirect without Google screen
**Solution**: Backend not restarted - restart the server

### Issue: CORS errors in console
**Solution**: Already configured in CorsConfig.java - should work once backend restarts

## Testing the Flow

1. **Backend running** on http://localhost:8080
2. **Frontend running** on http://localhost:5174
3. **Click login** → Should go to Google
4. **After Google auth** → Redirects back to frontend
5. **User shows in header** → Logged in successfully

## Quick Test

Run this in terminal to test OAuth endpoint:
```bash
curl -I http://localhost:8080/oauth2/authorization/google
```

Should return `302` redirect to Google with `Location:` header.

## Next Steps

1. ✅ Verify `.env` has Google credentials
2. ✅ Restart backend server
3. ✅ Test login flow
4. ✅ Check browser console for errors
