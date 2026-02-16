import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../util/app_url.dart';
import 'AppException.dart';
import 'BaseApiService.dart';

/// ============================================
/// NETWORK API SERVICE IMPLEMENTATION
/// ============================================
/// Handles HTTP POST requests with form-urlencoded content type
/// Uses centralized AppUrl for endpoint management
class NetworkApiService extends BaseApiService {
  static Future<bool> checkInternetConnection() async {
    bool isConnected = await InternetConnectionChecker().hasConnection;
    return isConnected;
  }

  /// Default headers for form-urlencoded requests
  static const Map<String, String> _defaultHeaders = {
    "Content-Type": "application/x-www-form-urlencoded",
  };

  /// Create HTTP client with SSL certificate bypass for testing
  /// WARNING: This is for development/testing only. Use proper certificates in production.
  static http.Client _createHttpClient() {
    final httpClient = HttpClient();
    if (kDebugMode) {
      httpClient.badCertificateCallback = (
        X509Certificate cert,
        String host,
        int port,
      ) {
        debugPrint(
          '⚠️ NetworkApiService: Bypassing SSL certificate verification for $host:$port',
        );
        return true; // Accept all certificates in development
      };
    }
    return IOClient(httpClient);
  }

  // Static client instance to reuse across requests
  static http.Client? _client;

  static http.Client get _httpClient {
    _client ??= _createHttpClient();
    return _client!;
  }

  @override
  Future<dynamic> postApiResponse(
    String url,
    dynamic data, {
    Map<String, String>? headers,
  }) async {
    try {
      // Merge default headers with provided headers
      final requestHeaders = {
        ..._defaultHeaders,
        if (headers != null) ...headers,
      };

      // If url is just an endpoint, get full URL
      final fullUrl =
          url.startsWith('http') ? url : ApiEndpoints.getFullUrl(url);

      // Use custom client with SSL bypass
      final response = await _httpClient.post(
        Uri.parse(fullUrl),
        headers: requestHeaders,
        encoding: Encoding.getByName('utf-8'),
        body: data,
      );

      if (kDebugMode) {
        print('NetworkApiService called: $fullUrl');
        print('Response status: ${response.statusCode}');
      }

      return _returnResponse(response);
    } catch (e) {
      if (kDebugMode) {
        print('NetworkApiService error: $e');
      }
      throw NetworkException('Network error: ${e.toString()}');
    }
  }

  /// Process HTTP response and throw appropriate exceptions
  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        try {
          return jsonDecode(response.body);
        } catch (e) {
          // If response is not JSON, return as string
          return response.body;
        }
      case 400:
        throw BadRequestException(response.body);
      case 401:
      case 403:
        throw UnauthorisedException(response.body);
      case 404:
        throw FetchDataException('Resource not found');
      case 500:
      case 502:
      case 503:
        throw ServerException(
          message: response.body,
          statusCode: response.statusCode,
        );
      default:
        throw FetchDataException(
          'Error code: ${response.statusCode} - ${response.body}',
        );
    }
  }
}
