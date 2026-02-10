import 'package:get_it/get_it.dart';

import '../core/storage/Shared_pref.dart';
import '../view/service/auth_service.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  try {
    // Initialize SharedPreferences with error handling
    await SharedPrefService.init();
  } catch (e) {
    // If SharedPreferences fails to initialize, we'll retry later when needed
    // This prevents the app from crashing on startup
    print('SharedPreferences initialization delayed: $e');
  }

  // Register services
  if (!locator.isRegistered<AuthService>()) {
    locator.registerLazySingleton<AuthService>(() => AuthService());
  }
}
