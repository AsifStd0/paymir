# Paymir App Architecture

## Overview
This application follows the **MVVM (Model-View-ViewModel)** architecture pattern with **Provider** for state management and **GetIt** for dependency injection.

## Folder Structure

```
lib/
├── core/                    # Core application setup
│   ├── locator.dart         # GetIt dependency injection setup
│   ├── providers_list.dart  # List of all providers
│   ├── storage/            # Storage services
│   │   └── Shared_pref.dart
│   └── theme/              # Theme configuration
│       └── app_theme.dart
│
├── models/                  # Data models
│   └── auth/
│       ├── login_model.dart
│       └── signup_model.dart
│
├── providers/               # State management (ViewModels)
│   └── auth/
│       ├── login_provider.dart
│       ├── signup_provider.dart
│       └── mobile_provider.dart
│
├── services/                # Business logic and API calls
│   └── auth_service.dart
│
├── views/                   # UI Screens
│   ├── auth/
│   │   ├── login_screen.dart
│   │   ├── signup_screen.dart
│   │   ├── mobile_verification_screen.dart
│   │   └── forgot_password_screen.dart
│   └── home/
│       └── home_screen.dart
│
├── utils/                   # Utilities and constants
│   ├── app_strings.dart     # Centralized string constants
│   └── constants.dart       # Re-export of Constants
│
├── widget/                  # Reusable widgets
│   └── custom/
│       ├── custom_button.dart
│       ├── custom_text.dart
│       └── custom_textfield.dart
│
└── main.dart                # App entry point
```

## Key Components

### 1. Models (`lib/models/`)
- **Purpose**: Data structures for API requests and responses
- **Location**: `lib/models/auth/`
- **Files**:
  - `login_model.dart`: LoginRequest, LoginResponse
  - `signup_model.dart`: SignupRequest, SignupResponse

### 2. Providers (`lib/providers/`)
- **Purpose**: State management and business logic coordination
- **Pattern**: Extends `ChangeNotifier` for Provider pattern
- **Location**: `lib/providers/auth/`
- **Files**:
  - `login_provider.dart`: Manages login state and logic
  - `signup_provider.dart`: Manages signup state and logic
  - `mobile_provider.dart`: Manages mobile verification state

### 3. Services (`lib/services/`)
- **Purpose**: API calls and external service interactions
- **Location**: `lib/services/`
- **Files**:
  - `auth_service.dart`: Authentication API calls

### 4. Views (`lib/views/`)
- **Purpose**: UI screens (Stateless/Stateful widgets)
- **Pattern**: Clean, simple screens that delegate logic to providers
- **Location**: `lib/views/auth/`, `lib/views/home/`
- **Files**:
  - `login_screen.dart`: User login interface
  - `signup_screen.dart`: User registration interface
  - `mobile_verification_screen.dart`: Mobile number collection
  - `forgot_password_screen.dart`: Password recovery

### 5. Utils (`lib/utils/`)
- **Purpose**: Shared utilities and constants
- **Files**:
  - `app_strings.dart`: **All UI text strings** - centralized for easy maintenance and localization
  - `constants.dart`: Re-export of existing Constants class

### 6. Core (`lib/core/`)
- **Purpose**: Application-wide configuration
- **Files**:
  - `locator.dart`: GetIt dependency injection setup
  - `providers_list.dart`: List of all ChangeNotifierProviders
  - `theme/app_theme.dart`: Theme configuration
  - `storage/Shared_pref.dart`: SharedPreferences wrapper

## String Management

**All UI text is centralized in `lib/utils/app_strings.dart`**

Example usage:
```dart
import '../../utils/app_strings.dart';

// Instead of hardcoded strings:
Text('Sign In')  // ❌ Don't do this

// Use AppStrings:
Text(AppStrings.signIn)  // ✅ Do this
```

Benefits:
- Easy to maintain
- Easy to localize (translate to other languages)
- Consistent text across the app
- Single source of truth

## State Management Flow

1. **User Action** → View (Screen)
2. **View** → Calls Provider method
3. **Provider** → Calls Service
4. **Service** → Makes API call
5. **Service** → Returns Model
6. **Provider** → Updates state and notifies listeners
7. **View** → Rebuilds with new state

## Dependency Injection

Services are registered in `lib/core/locator.dart` using GetIt:

```dart
locator.registerLazySingleton<AuthService>(() => AuthService());
```

Providers are registered in `lib/core/providers_list.dart`:

```dart
ChangeNotifierProvider(create: (_) => LoginProvider()),
```

## Theme Management

Theme is configured in `lib/core/theme/app_theme.dart`:
- Colors
- Text styles
- Spacing utilities
- ThemeData

## Best Practices

1. **Screens should be simple**: Delegate logic to providers
2. **Use AppStrings**: Never hardcode text strings
3. **One provider per feature**: Keep providers focused
4. **Models for data**: Use models for API requests/responses
5. **Services for API**: Keep API calls in services
6. **Custom widgets**: Reuse custom widgets for consistency

## Migration Notes

- Old paths in `lib/view/` are still available for backward compatibility
- New screens in `lib/views/` use the new structure
- Gradually migrate old screens to new structure
- Update imports when refactoring

## Naming Conventions

- **Models**: `*_model.dart` (e.g., `login_model.dart`)
- **Providers**: `*_provider.dart` (e.g., `login_provider.dart`)
- **Services**: `*_service.dart` (e.g., `auth_service.dart`)
- **Screens**: `*_screen.dart` (e.g., `login_screen.dart`)
- **Widgets**: `custom_*.dart` (e.g., `custom_button.dart`)
