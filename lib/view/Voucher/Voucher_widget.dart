import 'package:flutter/material.dart';
import 'package:paymir_new_android/util/theme/app_colors.dart';

import '../../util/Mediaquery_Constant.dart';
import '../../util/MyValidation.dart';

/// ============================================
/// COMMON WIDGETS FOR VOUCHER PAGE
/// ============================================

/// Title text widget for voucher page
class VoucherTitleText extends StatelessWidget {
  final String text;

  const VoucherTitleText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top:
            MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(context) *
            50,
        left: MediaQueryConstant.getHomePageMainTextLeftPadding(context) * 2.3,
        right: MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
          context,
        ),
        bottom:
            MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(context) *
            9,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
              color: const Color(0xff3F3F3F),
              fontFamily: 'Metropolis',
              fontWeight: FontWeight.w700,
              fontSize: MediaQueryConstant.getServiceFontSize(context),
            ),
          ),
        ],
      ),
    );
  }
}

/// Voucher number input field widget
class VoucherNumberField extends StatelessWidget {
  final TextEditingController controller;

  const VoucherNumberField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: MediaQueryConstant.getTextFormFieldHeight(context),
          width: MediaQuery.of(context).size.width * 0.79,
          child: TextFormField(
            maxLength: 19,
            textAlign: TextAlign.start,
            style: const TextStyle(fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              hintText: "",
              hintStyle: TextStyle(
                fontSize: MediaQueryConstant.getTextformfieldHintFont(context),
                color: AppColors.secondaryColor(),
                fontFamily: 'Visby',
                fontWeight: FontWeight.normal,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    MediaQueryConstant.getTextformfieldBorderRadius(context),
                  ),
                ),
              ),
              counterText: '',
              contentPadding: EdgeInsets.only(
                top: MediaQueryConstant.getTextformfieldContentPadding(context),
                left: MediaQueryConstant.getTextformfieldContentPadding(
                  context,
                ),
                bottom: MediaQueryConstant.getTextformfieldContentPadding(
                  context,
                ),
              ),
            ),
            controller: controller,
            validator: (value) => MyValidation.validateVoucher(value),
          ),
        ),
      ],
    );
  }
}

/// Check payment details button widget
class VoucherCheckButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;

  const VoucherCheckButton({super.key, this.onPressed, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: isLoading ? null : onPressed,
        child: Container(
          alignment: Alignment.center,
          width: MediaQueryConstant.getButtonHeight(context) * 5,
          height: MediaQueryConstant.getButtonHeight(context),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(MediaQueryConstant.getButtonRadius(context)),
            ),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [AppColors.gradientColor1(), AppColors.gradientColor2()],
            ),
          ),
          child:
              isLoading
                  ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                  : Text(
                    'Check Payment Details',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQueryConstant.getButtonFont(context),
                      fontFamily: 'Visby',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
        ),
      ),
    );
  }
}
