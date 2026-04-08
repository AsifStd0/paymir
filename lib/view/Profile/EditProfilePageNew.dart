import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paymir_new_android/api/NetworkApiService.dart';
import 'package:provider/provider.dart';

import '../../util/AlertDialogueClass.dart';
import '../../util/Mediaquery_Constant.dart';
import '../../util/MyValidation.dart';
import '../../util/SecureStorage.dart';
import '../../util/app_strings.dart';
import '../../util/theme/app_colors.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text.dart';
import '../main/main_screen.dart';
import 'ProfileUpdateOTPVerificationPageNew.dart';
import 'profile_provider.dart';
import 'profile_widget.dart';

class EditProfilePageNew extends StatefulWidget {
  final String strCNIC;
  final Map<String, dynamic> cardDataJsonObject;

  const EditProfilePageNew(this.strCNIC, this.cardDataJsonObject, {super.key});

  @override
  State<EditProfilePageNew> createState() => _EditProfilePageNewState();
}

class _EditProfilePageNewState extends State<EditProfilePageNew> {
  final _formKey = GlobalKey<FormState>();
  String _strToken = '';

  @override
  void initState() {
    super.initState();
    _initializeProvider();
    _fetchSecureStorageData();
  }

  Future<void> _fetchSecureStorageData() async {
    final secureStorage = SecureStorage();
    _strToken = await secureStorage.getToken() ?? '';
  }

  void _initializeProvider() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ProfileProvider>(context, listen: false);
      provider.initializeEditProfileData(widget.cardDataJsonObject);
    });
  }

  Future<void> _handleSubmit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    final provider = Provider.of<ProfileProvider>(context, listen: false);

    // Validate all fields
    if (MyValidation.validateFirstName(provider.firstNameController.text) !=
            null ||
        MyValidation.validateName(provider.lastNameController.text) != null ||
        MyValidation.validateMobileforEditProfile(
              provider.mobileNumberController.text,
            ) !=
            null ||
        MyValidation.validateEmail(provider.emailController.text) != null) {
      return;
    }

    // Check internet connection
    if (!await NetworkApiService.checkInternetConnection()) {
      ShowAlertDialogueClass.showAlertDialogue(
        context: context,
        title: AppStrings.noInternet,
        message: AppStrings.checkInternetConnection,
        buttonText: AppStrings.ok,
        iconData: Icons.error,
      );
      return;
    }

    // Check if nothing changed
    if (!provider.hasProfileChanged()) {
      _showErrorDialog(context, 'Nothing to edit. Please make some changes!');
      return;
    }

    // If only name changed, update directly
    if (provider.onlyNameChanged()) {
      final success = await provider.updateProfile(
        cnic: widget.strCNIC,
        token: _strToken,
        context: context,
      );

      if (success && mounted) {
        _showSuccessDialog(context);
      }
    } else {
      // Mobile or email changed, send OTP
      final otpData = await provider.sendOTPForEditProfile(
        cnic: widget.strCNIC,
        token: _strToken,
        context: context,
      );

      if (otpData != null && mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProfileUpdateOTPVerificationPageNew(otpData),
          ),
        );
      }
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.error_outline_rounded, color: AppColors.error),
              const SizedBox(width: 8),
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

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              const Text(AppStrings.success),
              const Spacer(),
              Icon(
                Icons.check_circle_outline_rounded,
                color: AppColors.success,
              ),
            ],
          ),
          content: const Text('Profile updated successfully!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const MainScreen()),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text(AppStrings.ok),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        body: Consumer<ProfileProvider>(
          builder: (context, provider, _) {
            return provider.isEditingProfile || provider.isSendingOTP
                ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.22,
                        height: MediaQuery.of(context).size.width * 0.22,
                        child: const CircularProgressIndicator(),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Text(
                        'Loading data...',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Visby',
                        ),
                      ),
                    ],
                  ),
                )
                : SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildHeader(context),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQueryConstant.getSymmetricHorizontalPadding(
                                  context,
                                ),
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText.mainTitle(
                                  text: AppStrings.editProfile,
                                  context: context,
                                ),
                                SizedBox(
                                  height:
                                      MediaQueryConstant.getVerticalGapBetweenMainAndSmallFont(
                                        context,
                                      ),
                                ),
                                CustomText.subtitle(
                                  text:
                                      'It only takes a minute to edit your profile',
                                  context: context,
                                ),
                                SizedBox(
                                  height:
                                      MediaQueryConstant.getVerticalGapBetweenSmallfontAndTextfield(
                                        context,
                                      ),
                                ),
                                Row(
                                  children: [
                                    EditProfileNameField(
                                      controller: provider.firstNameController,
                                      hintText: AppStrings.firstName,
                                      validator: MyValidation.validateFirstName,
                                      isFirstName: true,
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQueryConstant.getHorizontalGapBetweenTwoTextformfields(
                                            context,
                                          ),
                                    ),
                                    EditProfileNameField(
                                      controller: provider.lastNameController,
                                      hintText: AppStrings.lastName,
                                      validator: MyValidation.validateName,
                                      isFirstName: false,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
                                        context,
                                      ),
                                ),
                                EditProfileTextField(
                                  controller: provider.mobileNumberController,
                                  hintText: AppStrings.mobileNumber,
                                  validator:
                                      MyValidation.validateMobileforEditProfile,
                                  keyboardType: TextInputType.number,
                                ),
                                SizedBox(
                                  height:
                                      MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
                                        context,
                                      ),
                                ),
                                EditProfileTextField(
                                  controller: provider.emailController,
                                  hintText: AppStrings.emailAddress,
                                  validator: MyValidation.validateEmail,
                                  maxLength: 60,
                                ),
                                SizedBox(
                                  height:
                                      MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
                                        context,
                                      ) *
                                      350,
                                ),
                                CustomButton(
                                  onPressed: () => _handleSubmit(context),
                                  text: 'Confirm',
                                  isLoading:
                                      provider.isEditingProfile ||
                                      provider.isSendingOTP,
                                  isEnabled:
                                      !provider.isEditingProfile &&
                                      !provider.isSendingOTP,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: MediaQueryConstant.getBackArrowLeftPadding(context),
            top: MediaQueryConstant.getBackArrowTopPadding(context),
            bottom: MediaQueryConstant.getBackArrowBottomPadding(context),
          ),
          child: IconButton(
            icon: SvgPicture.asset("assets/images/back_arrow.svg"),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }
}
