# Setup Instructions

This document provides detailed setup instructions for the Umbrella Listing project.

## Environment Setup

### 1. Install Flutter

Download and install Flutter SDK from [flutter.dev](https://flutter.dev/docs/get-started/install)

Verify installation:
```bash
flutter doctor
```

### 2. IDE Setup

#### Android Studio
1. Install Flutter and Dart plugins
2. Configure Flutter SDK path
3. Install Android SDK and emulators

#### VS Code
1. Install Flutter extension
2. Install Dart extension
3. Configure Flutter SDK path

## Project Setup

### 1. Clone Repository
```bash
git clone <repository-url>
cd umbrella_listing_app
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Generate Code

The project uses code generation for:
- Dependency Injection (Injectable)
- Routing (AutoRoute)
- Hive adapters (if needed)

Run code generation:
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 4. Configure Firebase (Optional)

1. Create Firebase projects for each flavor:
   - umbrella-listing-dev
   - umbrella-listing-staging
   - umbrella-listing-prod

2. Download `google-services.json` for Android:
   - Place in `android/app/src/dev/`
   - Place in `android/app/src/staging/`
   - Place in `android/app/src/prod/`

3. Download `GoogleService-Info.plist` for iOS:
   - Place in `ios/Runner/Dev/`
   - Place in `ios/Runner/Staging/`
   - Place in `ios/Runner/Prod/`

## Running the App

### Development Mode
```bash
flutter run --flavor dev -t lib/main_dev.dart
```

### Staging Mode
```bash
flutter run --flavor staging -t lib/main_staging.dart
```

### Production Mode
```bash
flutter run --flavor prod -t lib/main_prod.dart
```

### On Specific Device
```bash
# List devices
flutter devices

# Run on specific device
flutter run --flavor dev -t lib/main_dev.dart -d <device-id>
```

## Building Release

### Android APK
```bash
# Development
flutter build apk --flavor dev -t lib/main_dev.dart

# Staging
flutter build apk --flavor staging -t lib/main_staging.dart

# Production
flutter build apk --flavor prod -t lib/main_prod.dart --release
```

### Android App Bundle
```bash
flutter build appbundle --flavor prod -t lib/main_prod.dart --release
```

### iOS
```bash
# Development
flutter build ios --flavor dev -t lib/main_dev.dart

# Production
flutter build ios --flavor prod -t lib/main_prod.dart --release
```

## Common Issues

### Issue: Build runner fails
**Solution**:
```bash
flutter clean
flutter pub get
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs
```

### Issue: Hive not initialized
**Solution**: Ensure `HiveStorageService.init()` is called in `main_common.dart`

### Issue: Dependency injection fails
**Solution**: Run code generation to create `injection_container.config.dart`

### Issue: Routes not found
**Solution**: Run code generation to create `app_router.gr.dart`

## Code Generation Commands

### Watch Mode (Development)
```bash
dart run build_runner watch --delete-conflicting-outputs
```

### Build Once
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Clean Generated Files
```bash
dart run build_runner clean
```

## Testing

### Run All Tests
```bash
flutter test
```

### Run Tests with Coverage
```bash
flutter test --coverage
```

### Run Specific Test
```bash
flutter test test/features/auth/login_test.dart
```

## Debugging

### Enable Flutter Inspector
In VS Code or Android Studio, use the Flutter Inspector to debug UI issues.

### View Logs
```bash
flutter logs
```

### Clear App Data
```bash
# Android
adb shell pm clear com.nimblesl.umbrella.app

# iOS
# Uninstall and reinstall the app
```

## VS Code Launch Configuration

Create `.vscode/launch.json`:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Dev",
      "request": "launch",
      "type": "dart",
      "program": "lib/main_dev.dart",
      "args": ["--flavor", "dev"]
    },
    {
      "name": "Staging",
      "request": "launch",
      "type": "dart",
      "program": "lib/main_staging.dart",
      "args": ["--flavor", "staging"]
    },
    {
      "name": "Production",
      "request": "launch",
      "type": "dart",
      "program": "lib/main_prod.dart",
      "args": ["--flavor", "prod"]
    }
  ]
}
```

## Environment Variables

Create `.env` files for different environments:
- `.env.dev`
- `.env.staging`
- `.env.prod`

Example:
```
BASE_URL=https://api-dev.umbrella.com
API_KEY=your_api_key_here
```

## Next Steps

1. Configure Firebase for your project
2. Set up signing for Android (keystore)
3. Set up signing for iOS (certificates, provisioning profiles)
4. Configure CI/CD pipelines
5. Set up crash reporting (Firebase Crashlytics)
6. Configure analytics tracking

## Support

If you encounter any issues, please:
1. Check this setup guide
2. Review the README.md
3. Check existing issues in the repository
4. Create a new issue with detailed information

---

Happy coding! 🚀
