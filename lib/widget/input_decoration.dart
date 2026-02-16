import 'package:flutter/material.dart';
import 'package:paymir_new_android/util/theme/app_colors.dart';

import '../util/Mediaquery_Constant.dart';

class CustomInputDecoration {
  static InputDecoration getDecoration({
    required BuildContext context,
    required String hintText,
    Widget? suffixIcon,
    Widget? prefixIcon,
  }) {
    return InputDecoration(
      hintStyle: TextStyle(
        fontSize: MediaQueryConstant.getTextformfieldHintFont(context),
        color: AppColors.secondaryColor(),
        fontFamily: 'Visby',
        fontWeight: FontWeight.normal,
      ),
      hintText: hintText,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            MediaQueryConstant.getTextformfieldBorderRadius(context),
          ),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            MediaQueryConstant.getTextformfieldBorderRadius(context),
          ),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            MediaQueryConstant.getTextformfieldBorderRadius(context),
          ),
        ),
      ),
      counterText: '',
      contentPadding: EdgeInsets.only(
        top: MediaQueryConstant.getTextformfieldContentPadding(context),
        left: MediaQueryConstant.getTextformfieldContentPadding(context),
        bottom: MediaQueryConstant.getTextformfieldContentPadding(context),
      ),
    );
  }
}
