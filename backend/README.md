# Spring Boot Backend - Setup Guide

## Prerequisites

- **Java 17** installed (required)
- **MySQL** server running
- **Google Cloud Console** OAuth credentials

## Database Setup

1. Ensure MySQL is running on `localhost:3306`
2. The application will auto-create database `esd_db` on first run
3. Update credentials in `src/main/resources/application.properties`:
   ```properties
   spring.datasource.username=your_mysql_username
   spring.datasource.password=your_mysql_password
   ```

## Google OAuth Setup

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select existing
3. Enable **Google+ API**
4. Navigate to **Credentials** → **Create Credentials** → **OAuth 2.0 Client ID**
5. Configure consent screen if prompted
6. Set **Authorized redirect URIs**:
   ```
   http://localhost:8080/login/oauth2/code/google
   ```
7. Copy **Client ID** and **Client Secret**
8. Update `src/main/resources/application.properties`:
   ```properties
   spring.security.oauth2.client.registration.google.client-id=YOUR_CLIENT_ID
   spring.security.oauth2.client.registration.google.client-secret=YOUR_CLIENT_SECRET
   ```

## Build & Run

### Using Maven Wrapper (Recommended)

```bash
# Build the project
./mvnw clean install --toolchains .mvn/toolchains.xml

# Run the application
./mvnw spring-boot:run --toolchains .mvn/toolchains.xml
```

### Alternative: Set JAVA_HOME to Java 17

```bash
export JAVA_HOME=/opt/homebrew/Cellar/openjdk@17/17.0.17/libexec/openjdk.jdk/Contents/Home
./mvnw clean install
./mvnw spring-boot:run
```

## Testing the Application

1. **Access home page**: http://localhost:8080
2. **Login with Google**: Click "Login with Google" button
3. **After authentication**: You'll be redirected to `/dashboard`
4. **API Endpoints**:
   - `GET /api/user/me` - Current user info (requires authentication)
   - `GET /api/users` - All users (requires authentication)

## Project Structure

```
backend/
├── src/main/java/com/mohit/end_project/
│   ├── config/
│   │   └── SecurityConfig.java          # Spring Security + OAuth configuration
│   ├── controller/
│   │   ├── HomeController.java          # Home and dashboard pages
│   │   └── UserController.java          # REST API endpoints
│   ├── entity/
│   │   └── User.java                    # User JPA entity
│   ├── repository/
│   │   └── UserRepository.java          # User database repository
│   ├── security/
│   │   └── OAuth2LoginSuccessHandler.java  # OAuth success handler
│   └── EndProjectApplication.java       # Main application class
├── src/main/resources/
│   └── application.properties           # Configuration file
├── .mvn/
│   └── toolchains.xml                   # Java 17 toolchain config
└── pom.xml                              # Maven dependencies
```

## Important Notes

- ⚠️ **Java Version**: This project MUST be built with Java 17 due to Spring Boot 3.2.0 compatibility
- ⚠️ **CSRF**: Currently disabled for development. Enable in production!
- ⚠️ **MySQL**: Database `esd_db` will be auto-created if it doesn't exist
- ⚠️ **Logging**: Debug logging is enabled for Spring Security and Web (configured in application.properties)

## Troubleshooting

### Build fails with Java version error
- Ensure Java 17 is installed: `/usr/libexec/java_home -V`
- Use the toolchains flag: `./mvnw clean install --toolchains .mvn/toolchains.xml`

### MySQL connection error
- Verify MySQL is running: `mysql --version`
- Check credentials in `application.properties`
- Ensure MySQL allows local connections

### OAuth redirect error
- Verify redirect URI matches exactly in Google Cloud Console
- Check Client ID and Client Secret are correctly set
- Clear browser cookies and try again
