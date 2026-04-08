import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  IOSOptions _getIOSOptions() =>
      const IOSOptions(accountName: "paymentgateway");

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
    // sharedPreferencesName: 'Test2',
    // preferencesKeyPrefix: 'Test'
  );

  // Create storage
  final storage = const FlutterSecureStorage();

  final String _keyToken = 'token';
  final String _keyTokenExpiry = 'expiry';
  final String _keyCNIC = 'cnic';

  Future deleteToken() async {
    //Delete prvious key
    storage.deleteAll();
  }

  Future<String?> getToken() async {
    return await storage.read(
      key: _keyToken,
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
  }

  Future<String?> getTokenExpiry() async {
    return await storage.read(
      key: _keyTokenExpiry,
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
  }

  Future<String?> getCNIC() async {
    return await storage.read(
      key: _keyCNIC,
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
  }

  /// Store token, expiration date, and CNIC
  /// This matches the old working implementation
  Future<void> storeToken(
    String tokenValue,
    DateTime expirationDate,
    String strCNIC,
  ) async {
    String expiryString = expirationDate.toString();

    // Delete previous keys first
    await storage.deleteAll(
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );

    // Write token value
    await storage.write(
      key: _keyToken,
      value: tokenValue,
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );

    // Write expiration date
    await storage.write(
      key: _keyTokenExpiry,
      value: expiryString,
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );

    // Write CNIC
    await storage.write(
      key: _keyCNIC,
      value: strCNIC,
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
  }
}
