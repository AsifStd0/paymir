import 'package:flutter/material.dart';
import 'package:paymir_new_android/core/locator.dart';

import '../../core/storage/Shared_pref.dart';
import '../../models/auth/login_model.dart';
import '../../services/auth_service.dart';
import '../../util/AlertDialogueClass.dart';
import '../../util/NetworkHelperClass.dart';
import '../../utils/app_strings.dart';

/// Provider for managing login state and logic
class LoginProvider extends ChangeNotifier {
  final AuthService _authService = locator<AuthService>();

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

  ///!  Login user
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
          title: AppStrings.noInternet,
          message: AppStrings.checkInternetConnection,
          buttonText: AppStrings.ok,
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

        await SharedPrefService.storeToken(
          tokenValue: response.accessToken!,
          expirationDate: expirationDate,
          cnic: cnic,
        );

        return true;
      } else {
        _setError(response.errorDescription ?? AppStrings.loginFailed);

        if (response.isUnverified) {
          ShowAlertDialogueClass.showAlertDialogCodeVerificationPage(
            context: context,
            title: AppStrings.unverifiedCnic,
            message: AppStrings.verificationCodeSent,
            buttonText: AppStrings.ok,
            values: {"code": "1234", "cnic": cnic, "page": "from LoginPage"},
            iconData: const Icon(Icons.verified_user),
          );
        } else {
          ShowAlertDialogueClass.showAlertDialogue(
            context: context,
            title: AppStrings.error,
            message: response.errorDescription ?? AppStrings.loginFailedMessage,
            buttonText: AppStrings.ok,
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
        title: AppStrings.error,
        message: e.toString(),
        buttonText: AppStrings.close,
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
