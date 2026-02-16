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

  // Future<void> storeToken(
  //   String tokenValue,
  //   DateTime expirationDate,
  //   String strCNIC,
  // ) async {
  //   // Unique key for token
  //   final keyToken = 'token';
  //   final keyExpiry = 'expiry';
  //   final keyCNIC = 'cnic';

  //   String ExpiryString = expirationDate.toString();

  //   // Delete previous keys
  //   await storage.deleteAll(
  //     iOptions: _getIOSOptions(),
  //     aOptions: _getAndroidOptions(),
  //   );

  // // Write token value
  // await storage.write(
  //   key: keyToken,
  //   value: tokenValue,
  //   iOptions: _getIOSOptions(),
  //   aOptions: _getAndroidOptions(),
  // );
  // await storage.write(
  //   key: keyExpiry,
  //   value: ExpiryString,
  //   iOptions: _getIOSOptions(),
  //   aOptions: _getAndroidOptions(),
  // );
  // await storage.write(
  //   key: keyCNIC,
  //   value: strCNIC,
  //   iOptions: _getIOSOptions(),
  //   aOptions: _getAndroidOptions(),
  // );

  //   print("Values stored to secure storage");
  // }
}
