import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../util/Constants.dart';
import '../../util/MyValidation.dart';
import '../../util/NetworkHelperClass.dart';
import '../../util/SecureStorage.dart';
import '../../utils/app_strings.dart';
import '../../widget/custom/custom_button.dart';
import '../../widget/custom/custom_text.dart';
import '../SuccessfullyChangedPasswordNew.dart';
import 'profile_provider.dart';
import 'profile_widget.dart';

class UpdatePasswordPageNew extends StatefulWidget {
  const UpdatePasswordPageNew({super.key});

  @override
  State<UpdatePasswordPageNew> createState() => _UpdatePasswordPageNewState();
}

class _UpdatePasswordPageNewState extends State<UpdatePasswordPageNew> {
  final _formKey = GlobalKey<FormState>();
  final SecureStorage _secureStorage = SecureStorage();
  String _strToken = '';
  String _strCNIC = '';

  @override
  void initState() {
    super.initState();
    _fetchSecureStorageData();
  }

  Future<void> _fetchSecureStorageData() async {
    _strToken = await _secureStorage.getToken() ?? '';
    _strCNIC = await _secureStorage.getCNIC() ?? '';
  }

  Future<void> _handleUpdatePassword(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    final provider = Provider.of<ProfileProvider>(context, listen: false);

    // Validate old password
    if (MyValidationClass.validateOldPassword(
          provider.oldPasswordController.text,
        ) !=
        null) {
      provider.clearPasswordFields();
      return;
    }

    // Validate new password
    if (MyValidationClass.validatePassword(
          provider.newPasswordController.text,
        ) !=
        null) {
      return;
    }

    // Validate confirm password
    if (MyValidationClass.validateRePassword(
          provider.confirmPasswordController.text,
        ) !=
        null) {
      return;
    }

    // Check if old and new passwords are different
    if (provider.oldPasswordController.text ==
        provider.newPasswordController.text) {
      _showErrorDialog(
        context,
        'Old and new passwords are same. Please provide a different password!',
      );
      return;
    }

    // Check if new passwords match
    if (provider.newPasswordController.text !=
        provider.confirmPasswordController.text) {
      _showErrorDialog(context, 'New passwords do not match!');
      return;
    }

    // Check internet connection
    if (!await NetworkHelper.checkInternetConnection()) {
      _showErrorDialog(context, AppStrings.checkInternetConnection);
      return;
    }

    // Update password
    final success = await provider.updatePassword(
      cnic: _strCNIC,
      token: _strToken,
      context: context,
    );

    if (success && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const SuccessfullyPasswordChangedPageNew(),
        ),
      );
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          title: Row(
            children: [
              Icon(Icons.error_outline, color: AppColors.error),
              const SizedBox(width: 5),
              const Text(AppStrings.error),
            ],
          ),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text(AppStrings.ok),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(context),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Constants.getSymmetricHorizontalPadding(
                      context,
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Consumer<ProfileProvider>(
                      builder: (context, provider, _) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText.mainTitle(
                              text: AppStrings.updateProfile,
                              context: context,
                            ),
                            SizedBox(
                              height:
                                  Constants.getVerticalGapBetweenMainAndSmallFont(
                                    context,
                                  ),
                            ),
                            CustomText.subtitle(
                              text: 'Please provide old password!',
                              context: context,
                            ),
                            SizedBox(
                              height:
                                  Constants.getVerticalGapBetweenSmallfontAndTextfield(
                                    context,
                                  ),
                            ),
                            PasswordField(
                              controller: provider.oldPasswordController,
                              hintText: 'Enter current password',
                              obscureText: !provider.oldPasswordVisible,
                              onToggleVisibility:
                                  provider.toggleOldPasswordVisibility,
                              validator: MyValidationClass.validateOldPassword,
                            ),
                            SizedBox(
                              height:
                                  Constants.getVerticalGapBetweenTwoTextformfields(
                                    context,
                                  ) *
                                  30,
                            ),
                            _buildPasswordRequirements(context),
                            SizedBox(
                              height:
                                  Constants.getVerticalGapBetweenTwoTextformfields(
                                    context,
                                  ) *
                                  30,
                            ),
                            PasswordField(
                              controller: provider.newPasswordController,
                              hintText: 'New password',
                              obscureText: !provider.newPasswordVisible,
                              onToggleVisibility:
                                  provider.toggleNewPasswordVisibility,
                              validator: MyValidationClass.validatePassword,
                            ),
                            SizedBox(
                              height:
                                  Constants.getVerticalGapBetweenTwoTextformfields(
                                    context,
                                  ),
                            ),
                            PasswordField(
                              controller: provider.confirmPasswordController,
                              hintText: 'Re enter new password',
                              obscureText: !provider.confirmPasswordVisible,
                              onToggleVisibility:
                                  provider.toggleConfirmPasswordVisibility,
                              validator: MyValidationClass.validateRePassword,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.08,
                            ),
                            CustomButton(
                              onPressed: () => _handleUpdatePassword(context),
                              text: AppStrings.continueText,
                              isLoading: provider.isUpdatingPassword,
                              isEnabled: !provider.isUpdatingPassword,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: Constants.getBackArrowLeftPadding(context),
            top: Constants.getBackArrowTopPadding(context),
            bottom: Constants.getBackArrowBottomPadding(context),
          ),
          child: IconButton(
            icon: SvgPicture.asset("assets/images/back_arrow.svg"),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordRequirements(BuildContext context) {
    return CustomText.body(
      text:
          "- Please enter a password that is\n\n\t  - At least 8 characters long\n\t  - Must contain at least\n\t\t     - One uppercase letter\n\t\t     - One lowercase letter\n\t\t     - One digit\n\t\t     - One special character\n\t  - The password must not contain spaces",
      context: context,
    );
  }
}
