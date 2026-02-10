import 'package:flutter/material.dart';

import '../../util/AlertDialogueClass.dart';
import '../../util/NetworkHelperClass.dart';
import '../service/auth_service.dart';
import 'signup_model.dart';

class SignupProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool _isChecked = false;
  bool _passwordVisible = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  bool get isChecked => _isChecked;
  bool get passwordVisible => _passwordVisible;
  String? get errorMessage => _errorMessage;

  void setChecked(bool value) {
    _isChecked = value;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  /// Check if CNIC is verified before registration
  Future<bool> checkUser(String cnic, BuildContext context) async {
    try {
      _setLoading(true);
      _setError(null);

      if (!await NetworkHelper.checkInternetConnection()) {
        _setLoading(false);
        ShowAlertDialogueClass.showAlertDialogue(
          context: context,
          title: "No Internet",
          message: "Check your internet connection!",
          buttonText: "OK",
          iconData: Icons.error,
        );
        return false;
      }

      final response = await _authService.checkVerifiedCNIC(cnic);

      _setLoading(false);

      if (response["statusCode"] == "200") {
        return true;
      } else {
        _setError(response["responseMessage"] ?? "CNIC verification failed");
        ShowAlertDialogueClass.showAlertDialogue(
          context: context,
          title: "Error",
          message: response["responseMessage"] ?? "CNIC verification failed",
          buttonText: "OK",
          iconData: Icons.error_outline_rounded,
        );
        return false;
      }
    } catch (e) {
      _setLoading(false);
      _setError(e.toString());
      ShowAlertDialogueClass.showAlertDialogue(
        context: context,
        title: "Error",
        message: e.toString(),
        buttonText: "Close",
        iconData: Icons.error,
      );
      return false;
    }
  }

  /// Register a new user
  Future<bool> registerUser({
    required String firstName,
    required String lastName,
    required String cnic,
    required String email,
    required String password,
    required String mobileNo,
    required BuildContext context,
  }) async {
    try {
      _setLoading(true);
      _setError(null);

      if (!await NetworkHelper.checkInternetConnection()) {
        _setLoading(false);
        ShowAlertDialogueClass.showAlertDialogue(
          context: context,
          title: "No Internet",
          message: "Check your internet connection!",
          buttonText: "OK",
          iconData: Icons.error,
        );
        return false;
      }

      final request = SignupRequest(
        cnic: cnic,
        password: password,
        fullName: "$firstName $lastName",
        mobileNo: mobileNo,
        emailAddress: email,
        userType: "NormalUser",
        roleId: 1,
        category: "PAYMIR",
      );

      final response = await _authService.registerUser(request);

      _setLoading(false);

      if (response.isSuccess) {
        return true;
      } else {
        _setError(response.responseMessage ?? "Registration failed");
        ShowAlertDialogueClass.showAlertDialogue(
          context: context,
          title: "Registration Failed",
          message:
              response.responseMessage ??
              "Registration failed. Please try again.",
          buttonText: "OK",
          iconData: Icons.error_outline_rounded,
        );
        return false;
      }
    } catch (e) {
      _setLoading(false);
      _setError(e.toString());
      ShowAlertDialogueClass.showAlertDialogue(
        context: context,
        title: "Error",
        message: e.toString(),
        buttonText: "Close",
        iconData: Icons.error,
      );
      return false;
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
