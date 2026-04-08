// import 'package:flutter/material.dart';
// import 'package:paymir_new_android/api/NetworkApiService.dart';
// import 'package:paymir_new_android/core/locator.dart';

// import '../../core/services/auth_service.dart';
// import '../../model/signup_model.dart';
// import '../../util/AlertDialogueClass.dart';
// import '../../util/app_strings.dart';

// class SignupProvider extends ChangeNotifier {
//   final AuthService _authService = locator<AuthService>();

//   bool _isLoading = false;
//   bool _isChecked = false;
//   bool _passwordVisible = false;
//   String? _errorMessage;

//   bool get isLoading => _isLoading;
//   bool get isChecked => _isChecked;
//   bool get passwordVisible => _passwordVisible;
//   String? get errorMessage => _errorMessage;

//   void setChecked(bool value) {
//     _isChecked = value;
//     notifyListeners();
//   }

//   void togglePasswordVisibility() {
//     _passwordVisible = !_passwordVisible;
//     notifyListeners();
//   }

//   void _setLoading(bool value) {
//     _isLoading = value;
//     notifyListeners();
//   }

//   void _setError(String? error) {
//     _errorMessage = error;
//     notifyListeners();
//   }

//   /// Check if CNIC is verified before registration
//   Future<bool> checkUser(String cnic, BuildContext context) async {
//     try {
//       _setLoading(true);
//       _setError(null);

//       if (!await NetworkApiService.checkInternetConnection()) {
//         _setLoading(false);
//         ShowAlertDialogueClass.showAlertDialogue(
//           context: context,
//           title: AppStrings.noInternet,
//           message: AppStrings.checkInternetConnection,
//           buttonText: AppStrings.ok,
//           iconData: Icons.error,
//         );
//         return false;
//       }

//       final response = await _authService.checkVerifiedCNIC(cnic);

//       _setLoading(false);

//       if (response["statusCode"] == "200") {
//         return true;
//       } else {
//         _setError(
//           response["responseMessage"] ?? AppStrings.cnicVerificationFailed,
//         );
//         ShowAlertDialogueClass.showAlertDialogue(
//           context: context,
//           title: AppStrings.error,
//           message:
//               response["responseMessage"] ?? AppStrings.cnicVerificationFailed,
//           buttonText: AppStrings.ok,
//           iconData: Icons.error_outline_rounded,
//         );
//         return false;
//       }
//     } catch (e) {
//       _setLoading(false);
//       _setError(e.toString());
//       ShowAlertDialogueClass.showAlertDialogue(
//         context: context,
//         title: AppStrings.error,
//         message: e.toString(),
//         buttonText: AppStrings.close,
//         iconData: Icons.error,
//       );
//       return false;
//     }
//   }

//   /// Register a new user
//   Future<bool> registerUser({
//     required String firstName,
//     required String lastName,
//     required String cnic,
//     required String email,
//     required String password,
//     required String mobileNo,
//     required BuildContext context,
//   }) async {
//     try {
//       _setLoading(true);
//       _setError(null);

//       if (!await NetworkApiService.checkInternetConnection()) {
//         _setLoading(false);
//         ShowAlertDialogueClass.showAlertDialogue(
//           context: context,
//           title: AppStrings.noInternet,
//           message: AppStrings.checkInternetConnection,
//           buttonText: AppStrings.ok,
//           iconData: Icons.error,
//         );
//         return false;
//       }

//       final request = SignupRequest(
//         cnic: cnic,
//         password: password,
//         fullName: "$firstName $lastName",
//         mobileNo: mobileNo,
//         emailAddress: email,
//         userType: "NormalUser",
//         roleId: 1,
//         category: "PAYMIR",
//       );

//       final response = await _authService.registerUser(request);

//       _setLoading(false);

//       if (response.isSuccess) {
//         return true;
//       } else {
//         _setError(response.responseMessage ?? AppStrings.registrationFailed);
//         ShowAlertDialogueClass.showAlertDialogue(
//           context: context,
//           title: AppStrings.registrationFailed,
//           message:
//               response.responseMessage ?? AppStrings.registrationFailedMessage,
//           buttonText: AppStrings.ok,
//           iconData: Icons.error_outline_rounded,
//         );
//         return false;
//       }
//     } catch (e) {
//       _setLoading(false);
//       _setError(e.toString());
//       ShowAlertDialogueClass.showAlertDialogue(
//         context: context,
//         title: AppStrings.error,
//         message: e.toString(),
//         buttonText: AppStrings.close,
//         iconData: Icons.error,
//       );
//       return false;
//     }
//   }

//   void clearError() {
//     _errorMessage = null;
//     notifyListeners();
//   }
// }
