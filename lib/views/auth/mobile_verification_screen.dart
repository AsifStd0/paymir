import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:paymir_new_android/core/theme/app_colors.dart';
import 'package:provider/provider.dart';

import '../../providers/auth/mobile_provider.dart';
import '../../util/AlertDialogueClass.dart';
import '../../util/MyValidation.dart';
import '../../utils/app_strings.dart';
import '../../utils/constants.dart';

/// Mobile verification screen for collecting phone number
class MobileVerificationScreen extends StatefulWidget {
  final dynamic values;
  const MobileVerificationScreen(this.values, {super.key});

  @override
  State<MobileVerificationScreen> createState() =>
      _MobileVerificationScreenState();
}

class _MobileVerificationScreenState extends State<MobileVerificationScreen> {
  dynamic values;
  String phoneNumber = '';

  final TextEditingController _mobileNumberController = MaskedTextController(
    mask: '0000000000',
  );
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    values = widget.values;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [_buildBackButton(), _buildForm()]),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
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

  Widget _buildForm() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Constants.getSymmetricHorizontalPadding(context),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.setupTwoStepVerification,
              style: TextStyle(
                color: AppColors.primaryColor(),
                fontFamily: 'Visby',
                fontWeight: FontWeight.bold,
                fontSize: Constants.getMainFontSize(context),
              ),
            ),
            SizedBox(
              height: Constants.getVerticalGapBetweenMainAndSmallFont(context),
            ),
            Text(
              AppStrings.enterPhoneNumber,
              style: TextStyle(
                color: AppColors.secondaryColor(),
                fontFamily: 'Visby',
                fontWeight: FontWeight.w500,
                fontSize: Constants.getSmallFontSize(context),
              ),
            ),
            SizedBox(
              height: Constants.getVerticalGapBetweenSmallfontAndTextfield(
                context,
              ),
            ),
            _buildPhoneField(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.41),
            _buildVerifyButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Constants.getTextformfieldBorderRadius(context),
        ),
        border: Border.all(),
      ),
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      child: IntlPhoneField(
        decoration: InputDecoration(
          hintText: '3123456789',
          hintStyle: TextStyle(color: Colors.grey),
        ),
        autovalidateMode: AutovalidateMode.disabled,
        showCountryFlag: false,
        showDropdownIcon: true,
        controller: _mobileNumberController,
        validator:
            (value) => MyValidationClass.validateMobile(value as String?),
        dropdownIconPosition: IconPosition.trailing,
        dropdownTextStyle: TextStyle(
          fontSize: Constants.getGeneralFontSize(context) * 0.025,
          color: const Color(0xff03110A),
          fontFamily: 'Visby',
          fontWeight: FontWeight.w500,
        ),
        keyboardType: TextInputType.number,
        style: TextStyle(
          fontSize: Constants.getGeneralFontSize(context) * 0.025,
          color: const Color(0xff03110A),
          fontFamily: 'Visby',
          fontWeight: FontWeight.w500,
        ),
        initialCountryCode: 'PK',
        onChanged: (phone) {
          if (kDebugMode) {
            print(phone.completeNumber);
          }
          setState(() {
            phoneNumber = phone.completeNumber;
          });
        },
      ),
    );
  }

  Widget _buildVerifyButton() {
    return Builder(
      builder: (builderContext) {
        try {
          final mobileProvider = Provider.of<MobileProvider>(
            builderContext,
            listen: false,
          );
          return TextButton(
            onPressed:
                mobileProvider.isLoading
                    ? null
                    : () async {
                      if (_formKey.currentState!.validate()) {
                        if (phoneNumber.isNotEmpty &&
                            RegExp(r'^\+923[0-9]{9}$').hasMatch(phoneNumber)) {
                          values['mobileNo'] = phoneNumber;
                          final nameParts = values['fullname'].split(' ');
                          final firstName = nameParts[0];
                          final lastName =
                              nameParts.length > 1
                                  ? nameParts.sublist(1).join(' ')
                                  : '';

                          final success = await mobileProvider.registerUser(
                            firstName: firstName,
                            lastName: lastName,
                            cnic: values['cnic'],
                            email: values['emailAddress'],
                            password: values['password'],
                            mobileNo: values['mobileNo'],
                            context: builderContext,
                          );

                          if (success && mounted) {
                            String otp = "1234"; // Placeholder
                            values['otp'] = otp;
                            ShowAlertDialogueClass.showAlertDialogSendtoVerificationPage(
                              context: builderContext,
                              title: AppStrings.response,
                              message:
                                  "${AppStrings.registrationSuccessful}. ${AppStrings.pleaseVerifyMobile}",
                              buttonText: AppStrings.ok,
                              values: values,
                              iconData: Icons.offline_pin_rounded,
                            );
                          }
                        } else {
                          ShowAlertDialogueClass.showAlertDialogue(
                            context: builderContext,
                            title: AppStrings.error,
                            message:
                                "${AppStrings.invalidPhoneNumber}. ${AppStrings.phoneNumberFormat}",
                            buttonText: AppStrings.ok,
                            iconData: Icons.error,
                          );
                        }
                      }
                    },
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: Constants.getButtonHeight(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(Constants.getButtonRadius(context)),
                ),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    AppColors.gradientColor1(),
                    AppColors.gradientColor2(),
                  ],
                ),
              ),
              child:
                  mobileProvider.isLoading
                      ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                      : Text(
                        AppStrings.continueText,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Constants.getButtonFont(context),
                          fontFamily: 'Visby',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
            ),
          );
        } catch (e) {
          return TextButton(
            onPressed: () {
              ShowAlertDialogueClass.showAlertDialogue(
                context: builderContext,
                title: AppStrings.providerError,
                message: AppStrings.providerNotInitialized,
                buttonText: AppStrings.ok,
                iconData: Icons.error,
              );
            },
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: Constants.getButtonHeight(context),
              decoration: BoxDecoration(
                color: AppColors.secondaryColor(),
                borderRadius: BorderRadius.all(
                  Radius.circular(Constants.getButtonRadius(context)),
                ),
              ),
              child: Text(
                AppStrings.continueText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Constants.getButtonFont(context),
                  fontFamily: 'Visby',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
