import 'package:flutter/material.dart';

import '../../util/AlertDialogueClass.dart';
import '../../util/NetworkHelperClass.dart';
import '../../util/SecureStorage.dart';
import '../service/auth_service.dart';
import 'login_model.dart';

class LoginProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool _passwordVisible = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  bool get passwordVisible => _passwordVisible;
  String? get errorMessage => _errorMessage;

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

  /// Login user
  Future<bool> login({
    required String cnic,
    required String password,
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

      final request = LoginRequest(username: cnic, password: password);

      final response = await _authService.login(request);

      _setLoading(false);

      if (response.isSuccess && response.accessToken != null) {
        // Store token in secure storage
        const int expiresIn = 86399;
        final DateTime now = DateTime.now();
        final DateTime expirationDate = now.add(
          const Duration(seconds: expiresIn),
        );

        final secureStorage = SecureStorage();
        await secureStorage.storeToken(
          response.accessToken!,
          expirationDate,
          cnic,
        );

        return true;
      } else {
        _setError(response.errorDescription ?? "Login failed");

        if (response.isUnverified) {
          ShowAlertDialogueClass.showAlertDialogCodeVerificationPage(
            context: context,
            title: "Unverified CNIC",
            message:
                "A verification code has been sent to the associated mobile number. Please verify!",
            buttonText: "Okay",
            values: {"code": "1234", "cnic": cnic, "page": "from LoginPage"},
            iconData: const Icon(Icons.verified_user),
          );
        } else {
          ShowAlertDialogueClass.showAlertDialogue(
            context: context,
            title: "Error!",
            message:
                response.errorDescription ?? "Login failed. Please try again.",
            buttonText: "Okay!",
            iconData: Icons.warning_sharp,
          );
        }
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
