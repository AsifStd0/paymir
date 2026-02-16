import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

import '../../model/login_model.dart';
import '../../model/signup_model.dart';
import '../../util/Shared_pref.dart';
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
          await _saveUserData(request);
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
        if (loginResponse.isSuccess) {
          await _saveLoginData(loginResponse, request.username);
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

  /// !                  Save login data to shared preferences
  Future<void> _saveLoginData(LoginResponse response, String cnic) async {
    try {
      await SharedPrefService.setUserCNIC(cnic);
      if (response.expiresIn != null) {
        final expirationDate = DateTime.now().add(
          Duration(seconds: response.expiresIn!),
        );
        await SharedPrefService.setTokenExpiration(
          expirationDate.toIso8601String(),
        );
      }
    } catch (e) {
      log('Error saving login data: $e');
    }
  }

  /// !                  Save user data to shared preferences
  Future<void> _saveUserData(SignupRequest request) async {
    try {
      await SharedPrefService.setUserCNIC(request.cnic);
      await SharedPrefService.setUserEmail(request.emailAddress);
      await SharedPrefService.setUserFullName(request.fullName);
      await SharedPrefService.setUserMobile(request.mobileNo);
    } catch (e) {
      log('Error saving user data: $e');
    }
  }
}
