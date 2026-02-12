import 'package:flutter/material.dart';
import 'package:paymir_new_android/core/locator.dart';

import '../../models/auth/signup_model.dart';
import '../../services/auth_service.dart';
import '../../util/AlertDialogueClass.dart';
import '../../util/NetworkHelperClass.dart';
import '../../utils/app_strings.dart';

/// Provider for managing mobile verification state and logic
class MobileProvider extends ChangeNotifier {
  final AuthService _authService = locator<AuthService>();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  /// Register user with mobile number
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
          title: AppStrings.noInternet,
          message: AppStrings.checkInternetConnection,
          buttonText: AppStrings.ok,
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
        _setError(response.responseMessage ?? AppStrings.registrationFailed);
        ShowAlertDialogueClass.showAlertDialogue(
          context: context,
          title: AppStrings.registrationFailed,
          message:
              response.responseMessage ?? AppStrings.registrationFailedMessage,
          buttonText: AppStrings.ok,
          iconData: Icons.error_outline_rounded,
        );
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
