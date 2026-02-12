import 'dart:convert';
import 'dart:developer';

import '../core/services/base_service.dart';
import '../core/storage/Shared_pref.dart';
import '../models/auth/login_model.dart';
import '../models/auth/signup_model.dart';

/// Service for handling authentication operations
class AuthService extends BaseService {
  AuthService(super.apiClient);

  /// Register a new user
  Future<SignupResponse> registerUser(SignupRequest request) async {
    try {
      log('Registering user: ${request.toJson()}');

      final response = await apiClient.request(
        method: 'POST',
        endpoint: 'api/user/registerUser',
        data: request.toJson(),
        isFormData: true,
      );

      log('Registration response: $response');

      if (response != null) {
        final signupResponse = SignupResponse.fromJson(response);

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

  /// Check if CNIC is already verified
  Future<Map<String, dynamic>> checkVerifiedCNIC(String cnic) async {
    try {
      final data = {'CNIC': cnic, 'Category': 'PAYMIR'};

      final response = await apiClient.request(
        method: 'POST',
        endpoint: 'api/user/CheckVerifiedCNIC',
        data: data,
        isFormData: true,
      );

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
    } catch (e) {
      log('Check CNIC error: $e');
      return {'statusCode': '500', 'responseMessage': 'Error: ${e.toString()}'};
    }
  }

  /// Login user
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      log('Logging in user: ${request.toJson()}');

      final response = await apiClient.request(
        method: 'POST',
        endpoint: 'api/token',
        data: request.toJson(),
        isFormData: true,
      );

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
    } catch (e) {
      log('Login error: $e');
      return LoginResponse(
        isSuccess: false,
        error: 'Login Error',
        errorDescription: e.toString(),
      );
    }
  }

  /// Save login data to shared preferences
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

  /// Save user data to shared preferences
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
