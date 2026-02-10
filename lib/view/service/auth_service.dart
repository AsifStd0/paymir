import 'dart:convert';
import 'dart:developer';

import '../../util/NetworkHelperClass.dart';
import '../signup/signup_model.dart';

class AuthService {
  /// Check if user with given CNIC exists
  Future<CheckUserResponse> checkUser(String cnic) async {
    try {
      log('Checking user with CNIC: $cnic');
      final data = {"CNIC": cnic, 'Category': "PAYMIR"};

      final responseBody = await NetworkHelper.checkUser(data);

      if (responseBody == null) {
        throw Exception('No response from server');
      }

      log('Response received: $responseBody');
      final decodedResponse = json.decode(responseBody) as Map<String, dynamic>;

      return CheckUserResponse.fromJson(decodedResponse);
    } catch (e) {
      log('Error checking user: $e');
      rethrow;
    }
  }

  /// Register a new user
  Future<Map<String, dynamic>> signUp(SignupModel signupData) async {
    try {
      log('Registering user: ${signupData.emailAddress}');
      final responseBody = await NetworkHelper.signUp(signupData.toJson());

      if (responseBody == null) {
        throw Exception('No response from server');
      }

      log('Signup response: $responseBody');
      final decodedResponse = json.decode(responseBody) as Map<String, dynamic>;

      return decodedResponse;
    } catch (e) {
      log('Error during signup: $e');
      rethrow;
    }
  }

  /// Check internet connection
  Future<bool> checkInternetConnection() async {
    return await NetworkHelper.checkInternetConnection();
  }
}
