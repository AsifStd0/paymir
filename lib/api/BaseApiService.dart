/// ============================================
/// BASE API SERVICE INTERFACE
/// ============================================
/// Abstract base class for all API service implementations
/// Provides a contract for API communication

abstract class BaseApiService {
  /// Make a POST API request
  /// [url] - Full URL or endpoint path
  /// [data] - Request body data
  /// [headers] - Optional headers (including Authorization token)
  Future<dynamic> postApiResponse(
    String url,
    dynamic data, {
    Map<String, String>? headers,
  });
}
