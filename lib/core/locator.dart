import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../api/api_client.dart';
import '../core/services/complaint_service.dart';
import '../core/services/payment_service.dart';
import '../core/services/profile_service.dart';
import '../util/Shared_pref.dart';
import '../view/Voucher/voucher_service.dart';
import 'services/auth_service.dart';

// ! ! DEPENDENCY INJECTION CONTAINER
final GetIt locator = GetIt.instance;

// ! Setup dependency injection container
// ! Registers all services and initializes SharedPreferences
// ! Automatically loads and sets authentication token
Future<void> setupLocator() async {
  try {
    //!  Initialize SharedPreferences first
    await SharedPrefService.init();
    if (kDebugMode) {
      debugPrint('✅ SharedPreferences initialized');
    }
  } catch (e) {
    debugPrint('⚠️ SharedPreferences initialization delayed: $e');
  }

  // ============================================
  //!  API CLIENT REGISTRATION (Singleton)
  // ============================================
  if (!locator.isRegistered<ApiClient>()) {
    locator.registerLazySingleton<ApiClient>(() {
      final apiClient = ApiClient();

      // Load and set authentication token from SharedPreferences
      _initializeAuthToken(apiClient);

      if (kDebugMode) {
        debugPrint('✅ ApiClient registered');
      }

      return apiClient;
    });
  }

  // ============================================
  //!  SERVICE REGISTRATIONS (All use ApiClient)
  // ============================================

  //! Auth Service
  if (!locator.isRegistered<AuthService>()) {
    locator.registerLazySingleton<AuthService>(
      () => AuthService(locator<ApiClient>()),
    );
    if (kDebugMode) {
      debugPrint('✅ AuthService registered');
    }
  }

  //! Profile Service
  if (!locator.isRegistered<ProfileService>()) {
    locator.registerLazySingleton<ProfileService>(
      () => ProfileService(locator<ApiClient>()),
    );
    if (kDebugMode) {
      debugPrint('✅ ProfileService registered');
    }
  }

  //! Payment Service
  if (!locator.isRegistered<PaymentService>()) {
    locator.registerLazySingleton<PaymentService>(
      () => PaymentService(locator<ApiClient>()),
    );
    if (kDebugMode) {
      debugPrint('✅ PaymentService registered');
    }
  }

  //! Complaint Service
  if (!locator.isRegistered<ComplaintService>()) {
    locator.registerLazySingleton<ComplaintService>(
      () => ComplaintService(locator<ApiClient>()),
    );
    if (kDebugMode) {
      debugPrint('✅ ComplaintService registered');
    }
  }

  //! Voucher Service (uses NetworkHelper, but can be refactored later)
  if (!locator.isRegistered<VoucherService>()) {
    locator.registerLazySingleton<VoucherService>(() => VoucherService());
    if (kDebugMode) {
      debugPrint('✅ VoucherService registered');
    }
  }
}

// ! Initialize authentication token in ApiClient
// ! Loads token from SharedPreferences and sets it automatically
Future<void> _initializeAuthToken(ApiClient apiClient) async {
  try {
    final token = await SharedPrefService.getToken();
    if (token != null && token.isNotEmpty) {
      // Ensure token has 'Bearer ' prefix
      final formattedToken =
          token.startsWith('Bearer ') ? token : 'Bearer $token';
      apiClient.setAuthToken(formattedToken);

      if (kDebugMode) {
        debugPrint('✅ Auth token loaded and set in ApiClient');
      }
    } else {
      if (kDebugMode) {
        debugPrint('ℹ️ No auth token found in SharedPreferences');
      }
    }
  } catch (e) {
    debugPrint('❌ Error loading auth token: $e');
  }
}

// ! Update authentication token in ApiClient
// ! Call this after login or token refresh
Future<void> updateAuthToken(String token) async {
  try {
    // Save token to SharedPreferences
    await SharedPrefService.setToken(token);

    // Update token in ApiClient
    final apiClient = locator<ApiClient>();
    final formattedToken =
        token.startsWith('Bearer ') ? token : 'Bearer $token';
    apiClient.setAuthToken(formattedToken);

    if (kDebugMode) {
      debugPrint('✅ Auth token updated in ApiClient and SharedPreferences');
    }
  } catch (e) {
    debugPrint('❌ Error updating auth token: $e');
  }
}

// ! Clear authentication token
// ! Call this on logout
Future<void> clearAuthToken() async {
  try {
    // Clear token from SharedPreferences
    await SharedPrefService.deleteToken();

    // Clear token from ApiClient
    final apiClient = locator<ApiClient>();
    apiClient.clearAuthToken();

    if (kDebugMode) {
      debugPrint('✅ Auth token cleared');
    }
  } catch (e) {
    debugPrint('❌ Error clearing auth token: $e');
  }
}

// ! Get current authentication token
Future<String?> getCurrentToken() async {
  try {
    return await SharedPrefService.getToken();
  } catch (e) {
    debugPrint('❌ Error getting token: $e');
    return null;
  }
}
