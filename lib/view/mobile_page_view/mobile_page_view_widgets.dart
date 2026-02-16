import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:paymir_new_android/util/theme/app_colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../util/Mediaquery_Constant.dart';

/// ============================================
/// COMMON WIDGETS FOR MOBILE PAGE VIEWS
/// ============================================

/// Back arrow button widget
class MobileBackButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const MobileBackButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
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
            onPressed: onPressed ?? () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }
}

/// Title text widget
class MobileTitleText extends StatelessWidget {
  final String text;

  const MobileTitleText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: AppColors.primaryColor(),
        fontFamily: 'Visby',
        fontWeight: FontWeight.bold,
        fontSize: MediaQueryConstant.getMainFontSize(context),
      ),
    );
  }
}

/// Subtitle text widget
class MobileSubtitleText extends StatelessWidget {
  final String text;

  const MobileSubtitleText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: AppColors.secondaryColor(),
        fontFamily: 'Visby',
        fontWeight: FontWeight.w500,
        fontSize: MediaQueryConstant.getSmallFontSize(context),
      ),
    );
  }
}

/// Phone number input field widget
class MobilePhoneField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const MobilePhoneField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          MediaQueryConstant.getTextformfieldBorderRadius(context),
        ),
        border: Border.all(),
      ),
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        child: IntlPhoneField(
          decoration: const InputDecoration(
            hintText: '3123456789',
            hintStyle: TextStyle(color: Colors.grey),
          ),
          autovalidateMode: AutovalidateMode.disabled,
          showCountryFlag: false,
          showDropdownIcon: true,
          controller: controller,
          dropdownIconPosition: IconPosition.trailing,
          dropdownTextStyle: TextStyle(
            fontSize: MediaQueryConstant.getGeneralFontSize(context) * 0.025,
            color: const Color(0xff03110A),
            fontFamily: 'Visby',
            fontWeight: FontWeight.w500,
          ),
          keyboardType: TextInputType.number,
          style: TextStyle(
            fontSize: MediaQueryConstant.getGeneralFontSize(context) * 0.025,
            color: const Color(0xff03110A),
            fontFamily: 'Visby',
            fontWeight: FontWeight.w500,
          ),
          initialCountryCode: 'PK',
          onChanged: (phone) {
            if (kDebugMode) {
              print(phone.completeNumber);
            }
            onChanged(phone.completeNumber);
          },
        ),
      ),
    );
  }
}

/// OTP input field widget
class MobileOTPField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onCompleted;

  const MobileOTPField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.09),
      child: Center(
        child: Container(
          color: const Color(0xffFAFCFF),
          child: PinCodeTextField(
            length: 4,
            obscureText: false,
            keyboardType: TextInputType.number,
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
              activeColor: Colors.green,
              inactiveColor: Colors.grey,
              shape: PinCodeFieldShape.box,
              errorBorderColor: Colors.lightGreenAccent,
              borderRadius: BorderRadius.circular(15),
              fieldHeight: MediaQuery.of(context).size.height * 0.065,
              fieldWidth: MediaQuery.of(context).size.height * 0.065,
              activeFillColor: Colors.white,
            ),
            animationDuration: const Duration(milliseconds: 300),
            backgroundColor: const Color(0xffFAFCFF),
            enableActiveFill: false,
            controller: controller,
            onCompleted: (v) {
              if (kDebugMode) {
                debugPrint("Completed");
              }
              onCompleted();
            },
            onChanged: (value) {
              if (kDebugMode) {
                debugPrint(value);
              }
              onChanged(value);
            },
            beforeTextPaste: (text) => true,
            appContext: context,
          ),
        ),
      ),
    );
  }
}

/// Gradient button widget
class MobileGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;

  const MobileGradientButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isEnabled && !isLoading ? onPressed : null,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: MediaQueryConstant.getButtonHeight(context),
        decoration:
            isEnabled
                ? BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      MediaQueryConstant.getButtonRadius(context),
                    ),
                  ),
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xff08A1A7), Color(0xff4B2A7A)],
                  ),
                )
                : BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      MediaQueryConstant.getButtonRadius(context),
                    ),
                  ),
                ),
        child:
            isLoading
                ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
                : Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Visby',
                    fontSize: MediaQueryConstant.getButtonFont(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
      ),
    );
  }
}

/// Success image widget
class MobileSuccessImage extends StatelessWidget {
  const MobileSuccessImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
              context,
            ),
          ),
          child: SizedBox(
            height: MediaQueryConstant.getButtonHeight(context) * 5,
            width: MediaQuery.of(context).size.width,
            child: Image.asset("assets/images/successfully_registered1.gif"),
          ),
        ),
      ],
    );
  }
}

/// Success title widget
class MobileSuccessTitle extends StatelessWidget {
  final String text;

  const MobileSuccessTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top:
                MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
                  context,
                ) *
                80,
          ),
          child: Text(
            text,
            style: TextStyle(
              color: const Color(0xff03110A),
              fontFamily: 'Visby',
              fontWeight: FontWeight.bold,
              fontSize: MediaQueryConstant.getMainFontSize(context),
            ),
          ),
        ),
      ],
    );
  }
}

/// Success message widget
class MobileSuccessMessage extends StatelessWidget {
  final String text;

  const MobileSuccessMessage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: Text(
            text,
            style: TextStyle(
              color: AppColors.secondaryColor(),
              fontFamily: 'Visby',
              fontWeight: FontWeight.normal,
              fontSize: MediaQueryConstant.getSmallFontSize(context),
            ),
          ),
        ),
      ],
    );
  }
}

/// Error dialog widget
class MobileErrorDialog {
  static void show({
    required BuildContext context,
    required String title,
    required String message,
    VoidCallback? onOkPressed,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              const Icon(Icons.error, color: Colors.red),
              const SizedBox(width: 8),
              Text(title),
            ],
          ),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: onOkPressed ?? () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}

/// Incorrect OTP dialog widget
class MobileIncorrectOTPDialog {
  static void show({
    required BuildContext context,
    required VoidCallback onClearOTP,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: const Row(
            children: [
              Text("Incorrect code"),
              Spacer(),
              Icon(Icons.error, color: Colors.red),
            ],
          ),
          content: const Text(
            "The code you entered is not correct. Please try again!",
          ),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                onClearOTP();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
