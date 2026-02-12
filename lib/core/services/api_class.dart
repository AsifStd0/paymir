import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiClient {
  static const String _baseUrl = 'https://apipaymir.kp.gov.pk/';
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
              headers: {'Accept': 'application/json'},
            ),
          ) {
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
    try {
      final options = Options(
        method: method,
        contentType:
            isFormData
                ? Headers.formUrlEncodedContentType
                : Headers.jsonContentType,
      );

      // For form-urlencoded, Dio needs the data as a Map
      // For JSON, Dio will automatically encode the Map to JSON
      final response = await _dio.request(
        endpoint,
        data: data,
        queryParameters: queryParams,
        options: options,
      );

      return response.data;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  void _handleError(DioException e) {
    // You can throw custom exceptions here
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
