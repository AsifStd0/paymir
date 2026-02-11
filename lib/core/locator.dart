import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../core/storage/Shared_pref.dart';
import '../services/auth_service.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  try {
    // Initialize SharedPreferences with error handling
    await SharedPrefService.init();
  } catch (e) {
    // If SharedPreferences fails to initialize, we'll retry later when needed
    // This prevents the app from crashing on startup
    debugPrint('SharedPreferences initialization delayed: $e');
  }

  // Register services only (providers are registered via Provider, not GetIt)
  if (!locator.isRegistered<AuthService>()) {
    locator.registerLazySingleton<AuthService>(() => AuthService());
  }
  // Note: LoginProvider is registered via ChangeNotifierProvider in providers_list.dart
  // We don't register providers in GetIt, only services
}
