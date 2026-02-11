# 📱 Paymir App - Complete Flow Documentation

## 🚀 Application Flow Overview

This document explains the complete flow of the Paymir Flutter application from startup to user interactions.

---

## 1️⃣ **APP STARTUP** (`lib/main.dart`)

### Entry Point: `main()` function

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Lock orientation to portrait only
  SystemChrome.setPreferredOrientations([...]);
  
  // Initialize dependency injection (GetIt)
  await setupLocator();
  
  // Run the app
  runApp(const MyApp());
}
```

**What happens:**
1. ✅ Flutter engine initializes
2. ✅ App locked to portrait mode
3. ✅ Dependency injection setup (GetIt)
4. ✅ App starts running

---

## 2️⃣ **DEPENDENCY INJECTION SETUP** (`lib/core/locator.dart`)

### `setupLocator()` function

```dart
Future<void> setupLocator() async {
  // Initialize SharedPreferences for local storage
  await SharedPrefService.init();
  
  // Register services (not providers - those use Provider package)
  locator.registerLazySingleton<AuthService>(() => AuthService());
}
```

**What happens:**
1. ✅ SharedPreferences initialized (for storing tokens, user data)
2. ✅ Services registered in GetIt (AuthService, etc.)
3. ⚠️ Providers are NOT registered here - they use Provider package

---

## 3️⃣ **PROVIDER SETUP** (`lib/core/providers_list.dart`)

### `MyApp` Widget - Wraps app with Providers

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providersListData,  // All providers listed here
      child: MaterialApp(
        theme: AppTheme.getThemeData(),
        home: Splashscreen(),  // First screen
      ),
    );
  }
}
```

**Registered Providers:**
- ✅ `LoginProvider` - Manages login state
- ✅ `SignupProvider` - Manages signup state
- ✅ `MobileProvider` - Manages mobile verification
- ✅ `HomeProvider` - Manages home screen data
- ✅ `HedProvider` - Manages HED page data

**What happens:**
1. ✅ All providers available app-wide
2. ✅ Any screen can access providers via `Provider.of<ProviderName>(context)`
3. ✅ App theme applied
4. ✅ First screen: `Splashscreen`

---

## 4️⃣ **SPLASH SCREEN** (`lib/view/splash/Splashscreen.dart`)

### Initial Screen - Authentication Check

```dart
class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    requestPermissions();  // Request camera, storage permissions
    fetchSecureStorageData();  // Get saved token
    
    Future.delayed(Duration(seconds: 3), () {
      // Check if token exists and is valid
      if (strToken.isEmpty || expirationDate.isBefore(DateTime.now())) {
        // Token expired or missing → Go to Login
        Navigator.pushReplacement(context, LoginScreen());
      } else {
        // Token valid → Go to Home
        Navigator.pushReplacement(context, HomePageNew());
      }
    });
  }
}
```

**What happens:**
1. ✅ Requests permissions (camera, storage, photos)
2. ✅ Fetches saved token from SecureStorage
3. ✅ Shows splash screen for 3 seconds
4. ✅ Checks token validity:
   - **Token missing/expired** → Navigate to `LoginScreen`
   - **Token valid** → Navigate to `HomePageNew`

**Flow Decision:**
```
Splashscreen
    ├─ Token Invalid/Missing → LoginScreen
    └─ Token Valid → HomePageNew
```

---

## 5️⃣ **LOGIN FLOW** (`lib/view/login/login_screen.dart`)

### User Authentication

```dart
class LoginScreen extends StatefulWidget {
  // User enters CNIC and Password
  // Validates form
  // Calls LoginProvider.login()
}

// In LoginProvider (lib/providers/auth/login_provider.dart)
Future<bool> login({required String cnic, required String password}) async {
  // 1. Check internet connection
  // 2. Call AuthService.login() → API call
  // 3. If successful:
  //    - Save token to SecureStorage
  //    - Save token expiry date
  //    - Save CNIC
  //    - Return true
  // 4. If failed: Show error dialog
}
```

**What happens:**
1. ✅ User enters CNIC (masked: `00000-0000000-0`) and Password
2. ✅ Form validation (CNIC format, password length)
3. ✅ `LoginProvider.login()` called
4. ✅ API call to `/api/user/Login` via `AuthService`
5. ✅ On success:
   - Token saved to SecureStorage
   - Expiry date calculated (24 hours)
   - CNIC saved
   - Navigate to `HomePageNew`
6. ✅ On failure: Show error dialog

**Navigation:**
```
LoginScreen
    ├─ Login Success → HomePageNew
    ├─ "Sign Up" button → SignupScreen
    └─ "Forgot Password" → ForgotPasswordPageNew
```

---

## 6️⃣ **SIGNUP FLOW** (`lib/view/signup/signup_screen.dart`)

### New User Registration

```dart
class SignupScreen extends StatefulWidget {
  // User enters: Full Name, CNIC, Mobile, Email, Password
  // Validates all fields
  // Calls SignupProvider.registerUser()
}

// In SignupProvider (lib/providers/auth/signup_provider.dart)
Future<bool> registerUser({...}) async {
  // 1. Validate all fields
  // 2. Call AuthService.registerUser() → API call
  // 3. If successful:
  //    - Navigate to MobilePageNew (for OTP verification)
  // 4. If failed: Show error dialog
}
```

**What happens:**
1. ✅ User fills registration form
2. ✅ Field validation (CNIC, email, password, mobile)
3. ✅ `SignupProvider.registerUser()` called
4. ✅ API call to `/api/user/RegisterUser` via `AuthService`
5. ✅ On success: Navigate to `MobilePageNew` (OTP verification)
6. ✅ On failure: Show error dialog

**Navigation:**
```
SignupScreen
    ├─ Registration Success → MobilePageNew (OTP)
    └─ "Already registered?" → LoginScreen
```

---

## 7️⃣ **HOME SCREEN** (`lib/view/home_page/home_screen.dart`)

### Main Dashboard

```dart
class HomePageNew extends StatefulWidget {
  @override
  void initState() {
    super.initState();
    _loadInitialData();  // Load all data on startup
  }
  
  Future<void> _loadInitialData() async {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    await provider.loadAllData();  // Load card, transactions, profile
  }
}

// In HomeProvider (lib/view/home_page/home_provider.dart)
Future<void> loadAllData() async {
  await Future.wait([
    loadCardDetails(),        // Get card info
    loadPendingTransactions(), // Get pending payments
    loadDoneTransactions(),   // Get completed payments
    loadProfileDetails(),     // Get user profile
  ]);
}
```

**What happens:**
1. ✅ Screen loads
2. ✅ `HomeProvider.loadAllData()` called automatically
3. ✅ Parallel API calls:
   - Card details (`/api/user/GetCardDetail`)
   - Pending transactions (`/api/service/getPendingTransactions`)
   - Done transactions (`/api/service/getReceivedTransactions`)
   - Profile details (`/api/user/RequestforEditProfile`)
4. ✅ Data displayed in UI:
   - Payment card (card number, holder name)
   - Services grid (Dastak, SIDB, CFC, HED, Sports, PGMI, Assami, More)
   - Transaction tabs (Due Payment, My Paymir, Repay)

**Navigation from Home:**
```
HomePageNew
    ├─ Service Items → Service Pages (DastakPageNew, HEDPageNew, etc.)
    ├─ Pending Transaction → PaymentPageNew
    ├─ Done Transaction → Show details dialog
    ├─ Bottom Nav "Voucher no" → VoucherNoPageNew
    ├─ Bottom Nav "Qpay" → QRCodePageNew
    └─ Bottom Nav "Setting" → ProfilePageNew
```

---

## 8️⃣ **SERVICE PAGES** (Example: HED Page)

### Service-Specific Pages

```dart
// Example: HEDPageNew (lib/view/HED/HEDPageNew.dart)
class HEDPageNew extends StatefulWidget {
  // User enters mobile number
  // Clicks "Load Entries"
  // HedProvider.loadEntries() called
}

// In HedProvider (lib/view/HED/hed_provider.dart)
Future<void> loadEntries(BuildContext context) async {
  // 1. Get mobile number from controller
  // 2. Call HedService.getPendingTransactionsByMobile()
  // 3. Call HedService.getDoneTransactionsByMobile()
  // 4. Update UI with transactions
}
```

**What happens:**
1. ✅ User enters mobile number
2. ✅ Clicks "Load Entries" button
3. ✅ `HedProvider.loadEntries()` called
4. ✅ API calls:
   - Pending transactions by mobile (`/api/service/getPendingTransactions`)
   - Done transactions by mobile (`/api/service/getReceivedTransactions`)
5. ✅ Transactions displayed in tabs
6. ✅ User can tap transaction → Navigate to `PaymentPageNew`

**Architecture Pattern:**
```
Screen (HEDPageNew)
    ↓
Provider (HedProvider) - State Management
    ↓
Service (HedService) - API Calls
    ↓
NetworkHelper - HTTP Requests
```

---

## 9️⃣ **PAYMENT FLOW** (`lib/view/PaymentPageNew.dart`)

### Payment Processing

```dart
class PaymentPageNew extends StatefulWidget {
  // Receives: transaction data, service charges
  // Shows payment details
  // User selects payment method (Jazz Cash, EasyPaisa, etc.)
  // Processes payment
}
```

**What happens:**
1. ✅ Transaction details displayed
2. ✅ Service charges calculated
3. ✅ User selects payment provider
4. ✅ Payment processed via selected provider
5. ✅ On success: Transaction marked as paid
6. ✅ Navigate back to home or service page

---

## 🔟 **BOTTOM NAVIGATION** (From Home Screen)

### Navigation Bar Actions

```dart
BottomNavigationBar(
  items: [
    Home,        // Already on home
    Voucher no,  // → VoucherNoPageNew
    Qpay,        // → QRCodePageNew (requires camera permission)
    Setting,     // → ProfilePageNew
  ],
)
```

**Navigation:**
- **Voucher no** → `VoucherNoPageNew` - Enter voucher number
- **Qpay** → `QRCodePageNew` - Scan QR code for payment
- **Setting** → `ProfilePageNew` - View/edit profile

---

## 🔄 **COMPLETE FLOW DIAGRAM**

```
┌─────────────────────────────────────────────────────────────┐
│                    APP STARTUP (main.dart)                  │
│  1. Initialize Flutter                                      │
│  2. Setup GetIt (Dependency Injection)                     │
│  3. Setup Providers (State Management)                     │
│  4. Show Splashscreen                                       │
└────────────────────┬────────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────────┐
│              SPLASH SCREEN (Splashscreen.dart)              │
│  • Request Permissions                                      │
│  • Check Saved Token                                        │
│  • Wait 3 seconds                                           │
└──────┬───────────────────────────────┬─────────────────────┘
       │                               │
       │ Token Invalid/Missing         │ Token Valid
       ▼                               ▼
┌──────────────────────┐    ┌──────────────────────────────┐
│   LOGIN SCREEN       │    │      HOME SCREEN              │
│  • Enter CNIC        │    │  • Load Card Details          │
│  • Enter Password    │    │  • Load Transactions          │
│  • Validate          │    │  • Show Services              │
│  • API Call          │    │  • Show Payment Card          │
│  • Save Token        │    └──────┬───────────────────────┘
│  • Navigate to Home  │           │
└──────┬───────────────┘           │ User Actions
       │                           │
       │ Sign Up                   ▼
       ▼              ┌──────────────────────────────┐
┌─────────────────────┐│   SERVICE PAGES             │
│  SIGNUP SCREEN      ││  • HEDPageNew               │
│  • Enter Details    ││  • DastakPageNew            │
│  • Validate         ││  • CFCPageNew               │
│  • API Call         ││  • Enter Mobile Number      │
│  • Navigate to OTP  ││  • Load Transactions        │
└─────────────────────┘└──────┬──────────────────────┘
                               │
                               ▼
                    ┌──────────────────────────┐
                    │   PAYMENT PAGE           │
                    │  • Show Transaction      │
                    │  • Select Payment Method  │
                    │  • Process Payment       │
                    └──────────────────────────┘
```

---

## 📁 **ARCHITECTURE OVERVIEW**

### Folder Structure

```
lib/
├── main.dart                    # App entry point
├── core/
│   ├── locator.dart             # GetIt dependency injection
│   ├── providers_list.dart      # Provider registration
│   ├── theme/
│   │   └── app_theme.dart       # App theme configuration
│   └── storage/
│       └── Shared_pref.dart      # SharedPreferences wrapper
├── providers/
│   └── auth/
│       ├── login_provider.dart  # Login state management
│       ├── signup_provider.dart # Signup state management
│       └── mobile_provider.dart # Mobile verification
├── services/
│   └── auth_service.dart        # Authentication API calls
├── models/
│   └── auth/
│       ├── login_model.dart     # Login request/response models
│       └── signup_model.dart    # Signup request/response models
├── view/
│   ├── splash/
│   │   └── Splashscreen.dart    # Splash screen
│   ├── login/
│   │   └── login_screen.dart    # Login UI
│   ├── signup/
│   │   └── signup_screen.dart   # Signup UI
│   ├── home_page/
│   │   ├── home_screen.dart     # Home UI
│   │   ├── home_provider.dart   # Home state management
│   │   ├── home_services.dart   # Home API calls
│   │   └── home_widget.dart     # Home reusable widgets
│   └── HED/
│       ├── HEDPageNew.dart      # HED UI
│       ├── hed_provider.dart    # HED state management
│       ├── hed_services.dart    # HED API calls
│       └── hed_widget.dart      # HED reusable widgets
├── util/
│   ├── Constants.dart           # App constants
│   ├── NetworkHelperClass.dart  # HTTP helper
│   ├── SecureStorage.dart       # Secure storage wrapper
│   └── MyValidation.dart       # Form validation
└── widget/
    └── custom/                  # Reusable custom widgets
```

---

## 🔑 **KEY CONCEPTS**

### 1. **MVVM Architecture**
- **Model**: Data structures (`models/`)
- **View**: UI screens (`view/`)
- **ViewModel**: State management (`providers/`)

### 2. **State Management (Provider)**
- Providers manage state and business logic
- Screens consume providers via `Consumer<ProviderName>`
- Providers notify listeners when state changes

### 3. **Dependency Injection (GetIt)**
- Services registered in GetIt
- Providers access services via `locator.get<ServiceName>()`
- Clean separation of concerns

### 4. **API Communication**
- Services handle API calls
- NetworkHelper provides HTTP methods
- Responses parsed and returned to providers

### 5. **Local Storage**
- SecureStorage: Secure token storage
- SharedPreferences: General app data

---

## 🎯 **SUMMARY**

**App Flow:**
1. **Start** → `main.dart` initializes app
2. **Setup** → GetIt + Providers configured
3. **Splash** → Check authentication token
4. **Auth** → Login/Signup if needed
5. **Home** → Main dashboard with services
6. **Services** → Service-specific pages (HED, Dastak, etc.)
7. **Payment** → Process payments
8. **Profile** → User settings and profile

**Architecture:**
- ✅ MVVM pattern
- ✅ Provider for state management
- ✅ GetIt for dependency injection
- ✅ Clean separation of concerns
- ✅ Reusable widgets
- ✅ Centralized constants and strings

---

## 📝 **Notes**

- All providers are registered globally in `providers_list.dart`
- Services are registered in GetIt (`locator.dart`)
- Screens should NOT contain business logic - use providers
- API calls should be in services, not screens
- State changes trigger UI updates via `notifyListeners()`

---

**Last Updated:** Based on current codebase structure
**Architecture:** MVVM with Provider + GetIt
