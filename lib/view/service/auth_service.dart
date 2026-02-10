import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../core/storage/Shared_pref.dart';
import '../login/login_model.dart';
import '../signup/signup_model.dart';

class AuthService {
  static const String _baseUrl = 'https://apipaymir.kp.gov.pk/';

  /// Register a new user
  Future<SignupResponse> registerUser(SignupRequest request) async {
    try {
      final url = Uri.parse('$_baseUrl/api/user/RegisterUser');
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      log('Registering user: ${request.toJson()}');

      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(request.toJson()),
      );

      log('Registration response status: ${response.statusCode}');
      log('Registration response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final signupResponse = SignupResponse.fromJson(jsonResponse);

        // Save user data to shared preferences if registration is successful
        if (signupResponse.isSuccess) {
          await _saveUserData(request);
        }

        return signupResponse;
      } else {
        return SignupResponse(
          statusCode: response.statusCode.toString(),
          responseMessage:
              'Registration failed with status ${response.statusCode}',
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
      final url = Uri.parse('$_baseUrl/api/user/CheckVerifiedCNIC');
      final headers = {'Content-Type': 'application/x-www-form-urlencoded'};

      final body = {'CNIC': cnic, 'Category': 'PAYMIR'};

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          'statusCode': response.statusCode.toString(),
          'responseMessage': 'Check failed',
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
      final url = Uri.parse('$_baseUrl/api/token');
      final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
      final encoding = Encoding.getByName('utf-8');

      log('Logging in user: ${request.toJson()}');

      final response = await http.post(
        url,
        headers: headers,
        body: request.toJson(),
        encoding: encoding,
      );

      log('Login response status: ${response.statusCode}');
      log('Login response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final loginResponse = LoginResponse.fromJson(jsonResponse);

        // Save login data if successful
        if (loginResponse.isSuccess) {
          await _saveLoginData(loginResponse, request.username);
        }

        return loginResponse;
      } else {
        final jsonResponse = json.decode(response.body);
        return LoginResponse.fromJson(jsonResponse);
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
      await SharedPrefService.setString('user_cnic', cnic);
      if (response.expiresIn != null) {
        final expirationDate = DateTime.now().add(
          Duration(seconds: response.expiresIn!),
        );
        await SharedPrefService.setString(
          'token_expiration',
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
      // Use the helper methods which handle initialization
      await SharedPrefService.setString('user_cnic', request.cnic);
      await SharedPrefService.setString('user_email', request.emailAddress);
      await SharedPrefService.setString('user_fullname', request.fullName);
      await SharedPrefService.setString('user_mobile', request.mobileNo);
    } catch (e) {
      log('Error saving user data: $e');
      // Don't throw - saving to SharedPreferences is not critical for registration
    }
  }
}
