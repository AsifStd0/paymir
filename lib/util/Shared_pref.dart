// import 'package:shared_preferences/shared_preferences.dart';

// /// Centralized service for SharedPreferences operations
// /// This is the ONLY storage class used throughout the app
// class SharedPrefService {
//   static SharedPreferences? _prefs;
//   static bool _isInitialized = false;

//   // Storage keys (matching SecureStorage keys for compatibility)
//   static const String _keyToken = 'token';
//   static const String _keyTokenExpiry = 'expiry';
//   static const String _keyCNIC = 'cnic';

//   /// Initialize SharedPreferences
//   static Future<void> init() async {
//     if (_isInitialized && _prefs != null) {
//       return;
//     }
//     try {
//       _prefs = await SharedPreferences.getInstance();
//       _isInitialized = true;
//     } catch (e) {
//       _isInitialized = false;
//       rethrow;
//     }
//   }

//   /// Get SharedPreferences instance
//   static SharedPreferences? getPrefs() {
//     return _prefs;
//   }

//   // ============================================
//   // STRING OPERATIONS
//   // ============================================

//   static Future<bool> setString(String key, String value) async {
//     if (!_isInitialized || _prefs == null) {
//       await init();
//     }
//     return await _prefs!.setString(key, value);
//   }

//   static String? getString(String key) {
//     return _prefs?.getString(key);
//   }

//   // ============================================
//   // BOOLEAN OPERATIONS
//   // ============================================

//   static Future<bool> setBool(String key, bool value) async {
//     if (!_isInitialized || _prefs == null) {
//       await init();
//     }
//     return await _prefs!.setBool(key, value);
//   }

//   static bool? getBool(String key) {
//     return _prefs?.getBool(key);
//   }

//   // ============================================
//   // INTEGER OPERATIONS
//   // ============================================

//   static Future<bool> setInt(String key, int value) async {
//     if (!_isInitialized || _prefs == null) {
//       await init();
//     }
//     return await _prefs!.setInt(key, value);
//   }

//   static int? getInt(String key) {
//     return _prefs?.getInt(key);
//   }

//   // ============================================
//   // DOUBLE OPERATIONS
//   // ============================================

//   static Future<bool> setDouble(String key, double value) async {
//     if (!_isInitialized || _prefs == null) {
//       await init();
//     }
//     return await _prefs!.setDouble(key, value);
//   }

//   static double? getDouble(String key) {
//     return _prefs?.getDouble(key);
//   }

//   // ============================================
//   // STRING LIST OPERATIONS
//   // ============================================

//   static Future<bool> setStringList(String key, List<String> value) async {
//     if (!_isInitialized || _prefs == null) {
//       await init();
//     }
//     return await _prefs!.setStringList(key, value);
//   }

//   static List<String>? getStringList(String key) {
//     return _prefs?.getStringList(key);
//   }

//   // ============================================
//   // REMOVE & CLEAR OPERATIONS
//   // ============================================

//   static Future<bool> remove(String key) async {
//     if (!_isInitialized || _prefs == null) {
//       await init();
//     }
//     return await _prefs!.remove(key);
//   }

//   static Future<bool> clear() async {
//     if (!_isInitialized || _prefs == null) {
//       await init();
//     }
//     return await _prefs!.clear();
//   }

//   // ============================================
//   // AUTHENTICATION TOKEN OPERATIONS
//   // ============================================
//   // These methods match SecureStorage API for easy migration

//   /// Get authentication token
//   /// Compatible with SecureStorage.getToken()
//   static Future<String?> getToken() async {
//     if (!_isInitialized || _prefs == null) {
//       await init();
//     }
//     return _prefs?.getString(_keyToken);
//   }

//   /// Set authentication token
//   static Future<bool> setToken(String token) async {
//     if (!_isInitialized || _prefs == null) {
//       await init();
//     }
//     return await _prefs!.setString(_keyToken, token);
//   }

//   /// Get token expiration date
//   /// Compatible with SecureStorage.getTokenExpiry()
//   static Future<String?> getTokenExpiry() async {
//     if (!_isInitialized || _prefs == null) {
//       await init();
//     }
//     return _prefs?.getString(_keyTokenExpiry);
//   }

//   /// Set token expiration date
//   static Future<bool> setTokenExpiry(String expiry) async {
//     if (!_isInitialized || _prefs == null) {
//       await init();
//     }
//     return await _prefs!.setString(_keyTokenExpiry, expiry);
//   }

//   /// Get user CNIC
//   /// Compatible with SecureStorage.getCNIC()
//   static Future<String?> getCNIC() async {
//     if (!_isInitialized || _prefs == null) {
//       await init();
//     }
//     return _prefs?.getString(_keyCNIC);
//   }

//   /// Set user CNIC
//   static Future<bool> setCNIC(String cnic) async {
//     if (!_isInitialized || _prefs == null) {
//       await init();
//     }
//     return await _prefs!.setString(_keyCNIC, cnic);
//   }

//   /// Store token, expiry, and CNIC together
//   /// Compatible with SecureStorage.storeToken()
//   static Future<void> storeToken({
//     required String tokenValue,
//     required DateTime expirationDate,
//     required String cnic,
//   }) async {
//     if (!_isInitialized || _prefs == null) {
//       await init();
//     }

//     final expiryString = expirationDate.toString();

//     // Store all values
//     await Future.wait([
//       _prefs!.setString(_keyToken, tokenValue),
//       _prefs!.setString(_keyTokenExpiry, expiryString),
//       _prefs!.setString(_keyCNIC, cnic),
//     ]);
//   }

//   /// Delete all authentication data (token, expiry, CNIC)
//   /// Compatible with SecureStorage.deleteToken()
//   static Future<void> deleteToken() async {
//     if (!_isInitialized || _prefs == null) {
//       await init();
//     }

//     // Remove all auth-related keys
//     await Future.wait([
//       _prefs!.remove(_keyToken),
//       _prefs!.remove(_keyTokenExpiry),
//       _prefs!.remove(_keyCNIC),
//     ]);
//   }

//   // ============================================
//   // USER DATA OPERATIONS (Additional Convenience Methods)
//   // ============================================

//   /// Get user email
//   static String? getUserEmail() {
//     return getString('user_email');
//   }

//   /// Set user email
//   static Future<bool> setUserEmail(String email) async {
//     return await setString('user_email', email);
//   }

//   /// Get user full name
//   static String? getUserFullName() {
//     return getString('user_fullname');
//   }

//   /// Set user full name
//   static Future<bool> setUserFullName(String fullName) async {
//     return await setString('user_fullname', fullName);
//   }

//   /// Get user mobile number
//   static String? getUserMobile() {
//     return getString('user_mobile');
//   }

//   /// Set user mobile number
//   static Future<bool> setUserMobile(String mobile) async {
//     return await setString('user_mobile', mobile);
//   }

//   // ============================================
//   // LEGACY METHODS (for backward compatibility)
//   // ============================================

//   /// Get authentication token (legacy - uses 'auth_token' key)
//   /// Use getToken() instead for new code
//   static String? getAuthToken() {
//     return getString('auth_token');
//   }

//   /// Set authentication token (legacy - uses 'auth_token' key)
//   /// Use setToken() instead for new code
//   static Future<bool> setAuthToken(String token) async {
//     return await setString('auth_token', token);
//   }

//   /// Get user CNIC (legacy - uses 'user_cnic' key)
//   /// Use getCNIC() instead for new code
//   static String? getUserCNIC() {
//     return getString('user_cnic');
//   }

//   /// Set user CNIC (legacy - uses 'user_cnic' key)
//   /// Use setCNIC() instead for new code
//   static Future<bool> setUserCNIC(String cnic) async {
//     return await setString('user_cnic', cnic);
//   }

//   /// Get token expiration (legacy - uses 'token_expiration' key)
//   /// Use getTokenExpiry() instead for new code
//   static String? getTokenExpiration() {
//     return getString('token_expiration');
//   }

//   /// Set token expiration (legacy - uses 'token_expiration' key)
//   /// Use setTokenExpiry() instead for new code
//   static Future<bool> setTokenExpiration(String expiration) async {
//     return await setString('token_expiration', expiration);
//   }

//   /// Remove token (legacy)
//   /// Use deleteToken() instead for new code
//   static Future<bool> removeToken() async {
//     return await remove('auth_token');
//   }
// }
