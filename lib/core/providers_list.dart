import 'package:pdf/widgets.dart';

// final GetIt locator = GetIt.instance;

// Future<void> setupLocator() async {
//   // Check if already initialized
//   if (locator.isRegistered<Dio>()) {
//     print('✅ Locator already initialized, skipping...');
//     return;
//   }

//   // ========== STEP 1: Initialize SharedPreferences ==========
//   final prefs = await SharedPreferences.getInstance();

//   if (!locator.isRegistered<SharedPreferences>()) {
//     locator.registerSingleton<SharedPreferences>(prefs);
//   }

//   // ========== STEP 2: Register & Initialize Storage FIRST ==========
//   if (!locator.isRegistered<UnifiedLocalStorageServiceImpl>()) {
//     // Create instance
//     final storageService = UnifiedLocalStorageServiceImpl();

//     // Initialize it (sets up SharedPreferences internally)
//     await storageService.initialize();

//     // Register the initialized instance
//     locator.registerSingleton<UnifiedLocalStorageServiceImpl>(storageService);
//   }

//   // ========== STEP 3: Register Dio (with initialized storage) ==========
//   if (!locator.isRegistered<Dio>()) {
//     final dio = Dio(
//       BaseOptions(
//         baseUrl: Config.apiBaseUrl,
//         connectTimeout: Config.connectTimeout,
//         receiveTimeout: Config.receiveTimeout,
//         headers: Config.defaultHeaders,
//       ),
//     );
List<SingleChildWidget> providersList = [
  // Add providers here
];
