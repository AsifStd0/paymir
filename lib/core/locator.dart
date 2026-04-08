import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../api/api_client.dart';
import '../core/services/complaint_service.dart';
import '../core/services/payment_service.dart';
import '../core/services/profile_service.dart';
import '../util/SecureStorage.dart';
import '../view/Voucher/voucher_service.dart';
import 'services/auth_service.dart';

// ! ! DEPENDENCY INJECTION CONTAINER
final GetIt locator = GetIt.instance;

// ! Setup dependency injection container
Future<void> setupLocator() async {
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
    final token = await SecureStorage().getToken();
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
  // Save token to SharedPreferences
  await SecureStorage().storage.write(key: 'token', value: token);
}

// ! Clear authentication token
// ! Call this on logout
Future<void> clearAuthToken() async {
  try {
    // Clear token from SharedPreferences
    await SecureStorage().deleteToken();

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
    return await SecureStorage().getToken();
  } catch (e) {
    debugPrint('❌ Error getting token: $e');
    return null;
  }
}
