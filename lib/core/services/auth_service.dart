import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:paymir_new_android/util/SecureStorage.dart';

import '../../model/login_model.dart';
import '../../model/signup_model.dart';
import '../../util/app_url.dart';
import 'base_service.dart';

/// !                  Service for handling authentication operations
class AuthService extends BaseService {
  AuthService(super.apiClient);

  /// !                  Register a new user
  Future<SignupResponse> registerUser(SignupRequest request) async {
    try {
      log('Registering user: ${request.toJson()}');

      final response = await apiClient.request(
        method: 'POST',
        endpoint: ApiEndpoints.registerUser,
        data: request.toJson(),
        isFormData: true, // Keep as form data to match API requirements
      );

      log('Registration response: $response');

      if (response != null) {
        final responseData =
            response is Map<String, dynamic>
                ? response
                : jsonDecode(response.toString());
        final signupResponse = SignupResponse.fromJson(responseData);

        // Save user data to shared preferences if registration is successful
        if (signupResponse.isSuccess) {
          await SecureStorage().storage.write(key: 'cnic', value: request.cnic);
          await SecureStorage().storage.write(
            key: 'email',
            value: request.emailAddress,
          );
          await SecureStorage().storage.write(
            key: 'fullName',
            value: request.fullName,
          );
          await SecureStorage().storage.write(
            key: 'mobileNo',
            value: request.mobileNo.toString(),
          );
        }

        return signupResponse;
      } else {
        return SignupResponse(
          statusCode: '500',
          responseMessage: 'Registration failed: No response from server',
        );
      }
    } catch (e) {
      log('Registration error: $e');
      return SignupResponse(
        statusCode: '500',
        responseMessage: 'Error: ${e.toString()}',
      );
    }
  }

  /// !                  Verify user with OTP
  Future<Map<String, dynamic>> verifyUser({
    required String cnic,
    required String mobileNo,
    required String emailAddress,
  }) async {
    try {
      final data = {
        "CNIC": cnic,
        "MobileNo": mobileNo,
        "EmailAddress": emailAddress,
      };

      log('Verifying user: $data');

      final response = await apiClient.request(
        method: 'POST',
        endpoint: ApiEndpoints.verifyUser,
        data: data,
        isFormData: true, // Changed to form data to match API requirements
      );

      log('Verification response: $response');

      if (response != null) {
        return response is Map<String, dynamic>
            ? response
            : jsonDecode(response.toString());
      } else {
        return {
          'statusCode': '500',
          'responseMessage': 'Verification failed: No response from server',
        };
      }
    } catch (e) {
      log('Verify user error: $e');
      return {'statusCode': '500', 'responseMessage': 'Error: ${e.toString()}'};
    }
  }

  /// !                  Check if CNIC is already verified
  Future<Map<String, dynamic>> checkVerifiedCNIC(String cnic) async {
    try {
      final data = {'CNIC': cnic, 'Category': 'PAYMIR'};

      debugPrint('CheckVerifiedCNIC request data: $data');

      // apiClient.request() returns response.data directly (not http.Response)
      final response = await apiClient.request(
        method: 'POST',
        endpoint: ApiEndpoints.checkVerifiedCNIC,
        data: data,
        isFormData: false, // JSON body (like Postman sends)
      );

      debugPrint('Check CNIC response: $response');

      if (response != null) {
        return response is Map<String, dynamic>
            ? response
            : jsonDecode(response.toString());
      } else {
        return {
          'statusCode': '500',
          'responseMessage': 'Check failed: No response from server',
        };
      }
    } catch (e, stackTrace) {
      debugPrint('Check CNIC error: $e');
      debugPrint('Check CNIC stack trace: $stackTrace');
      log('Check CNIC error: $e');
      return {'statusCode': '500', 'responseMessage': 'Error: ${e.toString()}'};
    }
  }

  /// !                  Login user
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      log('Login request: ${request.toJson()}');
      debugPrint('Logging in user: ${request.toJson()}');

      final response = await apiClient.request(
        method: 'POST',
        endpoint: ApiEndpoints.login,
        data: request.toJson(),
        isFormData: true,
      );
      debugPrint('Login response: $response');
      log('Login response: $response');

      if (response != null) {
        final responseData =
            response is Map<String, dynamic>
                ? response
                : jsonDecode(response.toString());
        final loginResponse = LoginResponse.fromJson(responseData);

        // Save login data if successful
        if (loginResponse.isSuccess && loginResponse.accessToken != null) {
          // Calculate expiration date: current time + expiresIn seconds
          final DateTime now = DateTime.now();
          final int expiresInSeconds =
              loginResponse.expiresIn ?? 3599; // Default to 3599 if null
          final DateTime expirationDate = now.add(
            Duration(seconds: expiresInSeconds),
          );

          // Store token, expiration date, and CNIC using the proper method
          // This matches the old working implementation
          await SecureStorage().storeToken(
            loginResponse.accessToken!,
            expirationDate,
            request.username, // CNIC is stored as username
          );
        }

        return loginResponse;
      } else {
        return LoginResponse(
          isSuccess: false,
          error: 'Login Error',
          errorDescription: 'No response from server',
        );
      }
    } catch (e, stackTrace) {
      log('Login error: $e');
      log('Login error stack trace: $stackTrace');
      return LoginResponse(
        isSuccess: false,
        error: 'Login Error',
        errorDescription: e.toString(),
      );
    }
  }
}
