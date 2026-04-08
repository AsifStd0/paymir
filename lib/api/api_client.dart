import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

import '../util/app_url.dart';

class ApiClient {
  static const String _baseUrl = ApiEndpoints.baseUrl;
  final Dio _dio;
  String? _authToken;

  ApiClient({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: _baseUrl,
              connectTimeout: const Duration(seconds: 30),
              receiveTimeout: const Duration(seconds: 30),
              sendTimeout: const Duration(seconds: 30),
            ),
          ) {
    // Configure SSL certificate bypass for development
    // NOTE: This is for development only. For production, use proper certificates.
    if (kDebugMode) {
      final adapter = _dio.httpClientAdapter;
      if (adapter is IOHttpClientAdapter) {
        adapter.createHttpClient = () {
          final client = HttpClient();
          client.badCertificateCallback = (
            X509Certificate cert,
            String host,
            int port,
          ) {
            debugPrint(
              '⚠️ Bypassing SSL certificate verification for $host:$port',
            );
            return true; // Accept all certificates in development
          };
          return client;
        };
      }
    }
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add auth token if available
          if (_authToken != null) {
            options.headers['Authorization'] = _authToken;
          }
          debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
          debugPrint('HEADERS: ${options.headers}');
          debugPrint('DATA: ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint(
            'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
          );
          debugPrint('DATA: ${response.data}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          debugPrint(
            'ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}',
          );
          debugPrint('MESSAGE: ${e.message}');
          return handler.next(e);
        },
      ),
    );
  }

  void setAuthToken(String token) {
    _authToken = token.startsWith('Bearer ') ? token : 'Bearer $token';
  }

  void clearAuthToken() {
    _authToken = null;
  }

  // Generic request handler
  Future<dynamic> request({
    required String method,
    required String endpoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParams,
    bool isFormData = false,
  }) async {
    debugPrint(
      'ApiClient request: $method $endpoint $data $queryParams $isFormData',
    );
    try {
      final options = Options(
        method: method,
        contentType:
            isFormData
                ? Headers.formUrlEncodedContentType
                : Headers.jsonContentType,
        validateStatus: (status) => status! < 500,
      );
      debugPrint('ApiClient options: $options');
      debugPrint(
        'ApiClient contentType: ${isFormData ? "form-urlencoded" : "application/json"}',
      );

      // IMPORTANT: Do NOT wrap data in FormData.fromMap() for form-urlencoded!
      // FormData.fromMap() sends multipart/form-data (with boundaries),
      // which is NOT the same as application/x-www-form-urlencoded.
      // Just pass the Map directly — Dio will auto-encode it as
      // key=value&key=value when contentType is formUrlEncodedContentType.
      dynamic requestData = data;

      debugPrint('ApiClient requestData type: ${requestData.runtimeType}');
      debugPrint('ApiClient requestData: $requestData');

      final response = await _dio.request(
        endpoint,
        data: requestData,
        queryParameters: queryParams,
        options: options,
      );

      debugPrint('ApiClient response status: ${response.statusCode}');
      debugPrint('ApiClient response data: ${response.data}');

      return response.data;
    } on DioException catch (e) {
      debugPrint('ApiClient DioException: ${e.type}');
      debugPrint('ApiClient error message: ${e.message}');
      debugPrint('ApiClient error response: ${e.response?.data}');
      debugPrint('ApiClient error status code: ${e.response?.statusCode}');
      debugPrint('ApiClient error request path: ${e.requestOptions.path}');
      debugPrint('ApiClient error request data: ${e.requestOptions.data}');
      debugPrint(
        'ApiClient error request headers: ${e.requestOptions.headers}',
      );
      debugPrint('ApiClient error stack trace: ${e.stackTrace}');
      _handleError(e);
      rethrow;
    } catch (e, stackTrace) {
      debugPrint('ApiClient general error: $e');
      debugPrint('ApiClient general error stack trace: $stackTrace');
      rethrow;
    }
  }

  void _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw NetworkException('Connection timeout');
      case DioExceptionType.cancel:
        throw NetworkException('Request cancelled');
      case DioExceptionType.connectionError:
        throw NetworkException('No internet connection');
      case DioExceptionType.badResponse:
        throw ServerException(
          message: 'Server error: ${e.response?.statusCode}',
          statusCode: e.response?.statusCode,
        );
      default:
        throw NetworkException('Network error: ${e.message}');
    }
  }
}

// Custom Exceptions
class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
}

class ServerException implements Exception {
  final String message;
  final int? statusCode;
  ServerException({required this.message, this.statusCode});
}
