# Umbrella Listing - Flutter Application

A production-ready Flutter application following clean architecture principles, feature-first design pattern, and modern Flutter best practices.

## 📱 Project Overview

**Project Name**: Umbrella Listing
**Package Name**: com.nimblesl.umbrella.app
**Display Name**: Umbrella Listing
**Platforms**: iOS and Android
**Min SDK**:
- Android: 24 (Android 7.0)
- iOS: 13.0

## 🏗️ Architecture

This project follows **Clean Architecture** principles with a **feature-first** folder structure.

### Clean Architecture Layers

Each feature follows clean architecture with three layers:

1. **Presentation Layer** (BLoC for state management)
   - `bloc/` - Business logic components
   - `pages/` - UI pages
   - `widgets/` - Reusable widgets

2. **Domain Layer** (Business logic)
   - `entities/` - Business objects
   - `repositories/` - Repository interfaces
   - `usecases/` - Business use cases

3. **Data Layer** (Data management)
   - `datasources/` - Remote and local data sources
   - `models/` - Data models
   - `repositories/` - Repository implementations

## 🎨 Design System

The app uses **Material Design 3** with a comprehensive design system:

### Theme Support
- ✅ Light mode
- ✅ Dark mode
- ✅ System mode (follows device theme)

### Design Tokens
- **Spacing**: xs (4), sm (8), md (16), lg (24), xl (32), xxl (48)
- **Padding**: Screen, card, button padding
- **Border Radius**: Small (4), medium (8), large (12), xLarge (16), circular (100)
- **Typography**: Display, Headline, Title, Body, Label styles
- **Colors**: Primary, secondary, background, surface, error colors

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.5.1 or higher)
- Dart SDK (3.5.1 or higher)
- Android Studio / VS Code
- Xcode (for iOS development)

### Installation

1. **Clone the repository**
```bash
git clone <repository-url>
cd umbrella_listing_app
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Generate code** (after making changes to injectable/auto_route files)
```bash
dart run build_runner build --delete-conflicting-outputs
```

4. **Run the app**

For **Development** flavor:
```bash
flutter run --flavor dev -t lib/main_dev.dart
```

For **Staging** flavor:
```bash
flutter run --flavor staging -t lib/main_staging.dart
```

For **Production** flavor:
```bash
flutter run --flavor prod -t lib/main_prod.dart
```

## 🔧 Key Features

### ✅ Implemented

- ✅ **Clean Architecture** - Separation of concerns
- ✅ **Feature-First Structure** - Modular organization
- ✅ **Material Design 3** - Modern UI components
- ✅ **Dark/Light Themes** - Complete theme system
- ✅ **Design Constants** - Consistent spacing, padding, colors
- ✅ **Error Handling** - Comprehensive exception handling
- ✅ **Storage Services** - SecureStorage + Hive
- ✅ **Networking** - Centralized Dio client with interceptors
- ✅ **Dependency Injection** - GetIt + Injectable
- ✅ **Flavor Configuration** - Dev, Staging, Production
- ✅ **Routing** - AutoRoute with guards

### 🚧 To Be Implemented

- ⏳ Session management with timeout
- ⏳ Firebase integration (Messaging, Analytics)
- ⏳ Splash screen feature
- ⏳ Onboarding flow
- ⏳ Authentication (Login, Register, Guest)
- ⏳ Home screen with role-based UI
- ⏳ Reusable widget components
- ⏳ Deep linking support
- ⏳ Unit tests

## 📦 Dependencies

### Core Dependencies
- `flutter_bloc` - State management
- `equatable` - Value equality
- `get_it` & `injectable` - Dependency injection
- `auto_route` - Routing solution
- `dio` - HTTP client
- `connectivity_plus` - Network connectivity
- `flutter_secure_storage` - Secure storage
- `hive` & `hive_flutter` - Local database
- `dartz` - Functional programming
- `logger` - Logging

### UI Dependencies
- `cached_network_image` - Image caching
- `shimmer` - Loading effects
- `flutter_svg` - SVG support

## 🏃‍♂️ Development Workflow

### Code Generation

After modifying files with annotations (`@injectable`, `@RoutePage`, etc.), run:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## 🌍 Flavor Configuration

The app supports three flavors:

### Development
- Base URL: `https://api-dev.umbrella.com`
- App Name: "Umbrella Listing Dev"
- Logging: Enabled

### Staging
- Base URL: `https://api-staging.umbrella.com`
- App Name: "Umbrella Listing Staging"
- Logging: Enabled

### Production
- Base URL: `https://api.umbrella.com`
- App Name: "Umbrella Listing"
- Logging: Disabled

## 🔒 Security

- ✅ Sensitive data stored in FlutterSecureStorage
- ✅ JWT token authentication
- ✅ Request/response interceptors
- ⏳ SSL pinning (to be implemented)
- ⏳ Biometric authentication (to be implemented)

## 📄 More Documentation

See [SETUP.md](SETUP.md) for detailed setup instructions.

---

**Built with ❤️ using Flutter**
