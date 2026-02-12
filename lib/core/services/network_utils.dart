import 'package:internet_connection_checker/internet_connection_checker.dart';

/// Utility class for network connectivity checks
class NetworkUtils {
  static final InternetConnectionChecker _checker = InternetConnectionChecker();

  /// Check if device has internet connection
  static Future<bool> hasInternet() async {
    return await _checker.hasConnection;
  }

  /// Stream of internet connection status changes
  static Stream<bool> onInternetChange() {
    return _checker.onStatusChange.map(
      (status) => status == InternetConnectionStatus.connected,
    );
  }

  /// Check internet connection (alias for hasInternet)
  static Future<bool> checkInternetConnection() async {
    return await hasInternet();
  }
}
