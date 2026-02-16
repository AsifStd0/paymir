import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:paymir_new_android/api/NetworkApiService.dart';
import 'package:paymir_new_android/core/locator.dart';
import 'package:paymir_new_android/util/Shared_pref.dart';

import '../core/services/auth_service.dart';
import '../model/signup_model.dart';
import '../util/AlertDialogueClass.dart';
import '../util/app_strings.dart';
import '../view/mobile_page_view/MobileVerifiedPageNew.dart';

// !/ ! Provider for managing complete signup flow state and logic
// !/ ! Handles: CNIC check → Mobile entry → Registration → OTP verification
class SignupProvider extends ChangeNotifier {
  final AuthService _authService = locator<AuthService>();

  // ! Loading states
  bool _isLoading = false;
  bool _isLoadingRegistration = false;
  bool _isLoadingVerification = false;

  // ! UI states
  bool _isChecked = false;
  bool _passwordVisible = false;

  // ! Error handling
  String? _errorMessage;

  // ! Signup data (stored temporarily during flow)
  String? _firstName;
  String? _lastName;
  String? _cnic;
  String? _email;
  String? _password;
  String? _mobileNo;
  String? _otp;

  // ! Getters
  bool get isLoading => _isLoading;
  bool get isLoadingRegistration => _isLoadingRegistration;
  bool get isLoadingVerification => _isLoadingVerification;
  bool get isChecked => _isChecked;
  bool get passwordVisible => _passwordVisible;
  String? get errorMessage => _errorMessage;
  String? get otp => _otp;

  // ! Setters
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

  void _setLoadingRegistration(bool value) {
    _isLoadingRegistration = value;
    notifyListeners();
  }

  void _setLoadingVerification(bool value) {
    _isLoadingVerification = value;
    notifyListeners();
  }

  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  // !/ ! !  Step 1: Check if CNIC is verified before registration
  Future<bool> checkUser(String cnic, BuildContext context) async {
    try {
      _setLoading(true);
      _setError(null);

      if (!await NetworkApiService.checkInternetConnection()) {
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
      // ! ! CNIC Response
      final response = await _authService.checkVerifiedCNIC(cnic);
      _setLoading(false);

      if (response["statusCode"] == "200") {
        // ! Store CNIC for later use
        _cnic = cnic;
        return true;
      } else {
        _setError(
          response["responseMessage"] ?? AppStrings.cnicVerificationFailed,
        );
        ShowAlertDialogueClass.showAlertDialogue(
          context: context,
          title: AppStrings.error,
          message:
              response["responseMessage"] ?? AppStrings.cnicVerificationFailed,
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

  // !/ !! Step 2: Store signup form data (called from signup screen)
  void setSignupFormData({
    required String firstName,
    required String lastName,
    required String cnic,
    required String email,
    required String password,
  }) {
    _firstName = firstName;
    _lastName = lastName;
    _cnic = cnic;
    _email = email;
    _password = password;
  }

  // !/ ! ! Step 3: Register user with mobile number (called from MobilePageNew)
  Future<bool> registerUserWithMobile({
    required String mobileNo,
    required BuildContext context,
  }) async {
    try {
      _setLoadingRegistration(true);
      _setError(null);
      _mobileNo = mobileNo;

      if (!await NetworkApiService.checkInternetConnection()) {
        _setLoadingRegistration(false);
        ShowAlertDialogueClass.showAlertDialogue(
          context: context,
          title: AppStrings.noInternet,
          message: AppStrings.checkInternetConnection,
          buttonText: AppStrings.ok,
          iconData: Icons.error,
        );
        return false;
      }

      if (_cnic == null ||
          _email == null ||
          _password == null ||
          _firstName == null ||
          _lastName == null) {
        _setLoadingRegistration(false);
        _setError('Signup data is missing. Please start from the beginning.');
        ShowAlertDialogueClass.showAlertDialogue(
          context: context,
          title: AppStrings.error,
          message: 'Signup data is missing. Please start from the beginning.',
          buttonText: AppStrings.ok,
          iconData: Icons.error,
        );
        return false;
      }
      log('request: start 111');

      final request = SignupRequest(
        cnic: _cnic!,
        password: _password!,
        fullName: "$_firstName $_lastName",
        mobileNo: mobileNo,
        emailAddress: _email!,
        userType: "NormalUser",
        roleId: 1,
        category: "PAYMIR",
      );
      log('request: $request');
      // ! ! Register Api Calling
      final response = await _authService.registerUser(request);
      _setLoadingRegistration(false);

      if (response.isSuccess && response.otp != null) {
        _otp = response.otp;

        // ! Store signup data in SharedPreferences
        await SharedPrefService.setUserCNIC(_cnic!);
        await SharedPrefService.setUserEmail(_email!);
        await SharedPrefService.setUserFullName("$_firstName $_lastName");
        await SharedPrefService.setUserMobile(mobileNo);

        // ! Show appropriate dialog based on status code
        if (response.isRegistered) {
          // ! Status 201: User registered successfully
          ShowAlertDialogueClass.showAlertDialogSendtoVerificationPage(
            context: context,
            title: "Response",
            message: response.responseMessage ?? "Registration successful!",
            buttonText: "Okay!",
            values: {
              'cnic': _cnic!,
              'emailAddress': _email!,
              'mobileNo': mobileNo,
              'otp': _otp!,
            },
            iconData: Icons.offline_pin_rounded,
          );
        } else if (response.isUnverified) {
          // ! Status 202: User registered but unverified
          ShowAlertDialogueClass.showAlertDialogMobileVerificationPage(
            context: context,
            title: "Response",
            message: response.responseMessage ?? "Please verify your account!",
            buttonText: "Okay!",
            values: {
              'cnic': _cnic!,
              'emailAddress': _email!,
              'mobileNo': mobileNo,
              'otp': _otp!,
            },
            iconData: Icons.offline_pin_rounded,
          );
        }

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
      _setLoadingRegistration(false);
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

  // !/ ! Step 4: Verify OTP locally (called from MobileVerificationPageNew)
  bool verifyOTPLocally(String enteredOTP) {
    if (_otp == null) {
      return false;
    }
    return enteredOTP == _otp;
  }

  // !/ ! Step 5: Verify user with server (called from MobileVerificationPageNew)
  Future<bool> verifyUserWithServer({required BuildContext context}) async {
    try {
      _setLoadingVerification(true);
      _setError(null);

      if (!await NetworkApiService.checkInternetConnection()) {
        _setLoadingVerification(false);
        ShowAlertDialogueClass.showAlertDialogue(
          context: context,
          title: AppStrings.noInternet,
          message: AppStrings.checkInternetConnection,
          buttonText: AppStrings.ok,
          iconData: Icons.error,
        );
        return false;
      }

      if (_cnic == null || _mobileNo == null || _email == null) {
        _setLoadingVerification(false);
        _setError('Verification data is missing.');
        return false;
      }

      final response = await _authService.verifyUser(
        cnic: _cnic!,
        mobileNo: _mobileNo!,
        emailAddress: _email!,
      );

      _setLoadingVerification(false);

      if (response["statusCode"] == "200") {
        // ! Verification successful - navigate to success page
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const MobileVerifiedPageNew()),
          );
        }
        return true;
      } else {
        _setError(response["responseMessage"] ?? "Verification failed");
        ShowAlertDialogueClass.showAlertDialogue(
          context: context,
          title: AppStrings.error,
          message: response["responseMessage"] ?? "Verification failed",
          buttonText: AppStrings.ok,
          iconData: Icons.error_outline_rounded,
        );
        return false;
      }
    } catch (e) {
      _setLoadingVerification(false);
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

  // !/ ! Clear all signup data
  void clearSignupData() {
    _firstName = null;
    _lastName = null;
    _cnic = null;
    _email = null;
    _password = null;
    _mobileNo = null;
    _otp = null;
    _errorMessage = null;
    notifyListeners();
  }
}
