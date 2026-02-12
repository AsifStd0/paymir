import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../core/services/api_class.dart';
import '../core/services/complaint_service.dart';
import '../core/services/payment_service.dart';
import '../core/services/profile_service.dart';
import '../core/storage/Shared_pref.dart';
import '../services/auth_service.dart';

final GetIt locator = GetIt.instance;

/// Setup dependency injection container
/// Registers all services and initializes SharedPreferences
Future<void> setupLocator() async {
  try {
    // Initialize SharedPreferences
    await SharedPrefService.init();
  } catch (e) {
    debugPrint('SharedPreferences initialization delayed: $e');
  }

  // Register ApiClient (Singleton)
  if (!locator.isRegistered<ApiClient>()) {
    locator.registerLazySingleton<ApiClient>(() {
      final apiClient = ApiClient();

      // Try to load token from SharedPreferences and set it
      try {
        SharedPrefService.getToken()
            .then((token) {
              if (token != null && token.isNotEmpty) {
                apiClient.setAuthToken('Bearer $token');
              }
            })
            .catchError((e) {
              debugPrint('Error loading token: $e');
            });
      } catch (e) {
        debugPrint('Error setting up token: $e');
      }

      return apiClient;
    });
  }

  // Register Services (all extend BaseService and use ApiClient)
  if (!locator.isRegistered<AuthService>()) {
    locator.registerLazySingleton<AuthService>(
      () => AuthService(locator<ApiClient>()),
    );
  }

  if (!locator.isRegistered<ProfileService>()) {
    locator.registerLazySingleton<ProfileService>(
      () => ProfileService(locator<ApiClient>()),
    );
  }

  if (!locator.isRegistered<PaymentService>()) {
    locator.registerLazySingleton<PaymentService>(
      () => PaymentService(locator<ApiClient>()),
    );
  }

  if (!locator.isRegistered<ComplaintService>()) {
    locator.registerLazySingleton<ComplaintService>(
      () => ComplaintService(locator<ApiClient>()),
    );
  }
}
