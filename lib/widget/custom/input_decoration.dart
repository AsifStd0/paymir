import 'package:flutter/material.dart';

import '../../../util/Constants.dart';

class CustomInputDecoration {
  static InputDecoration getDecoration({
    required BuildContext context,
    required String hintText,
    Widget? suffixIcon,
    Widget? prefixIcon,
  }) {
    return InputDecoration(
      hintStyle: TextStyle(
        fontSize: Constants.getTextformfieldHintFont(context),
        color: Constants.secondaryColor(),
        fontFamily: 'Visby',
        fontWeight: FontWeight.normal,
      ),
      hintText: hintText,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(Constants.getTextformfieldBorderRadius(context)),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(Constants.getTextformfieldBorderRadius(context)),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(Constants.getTextformfieldBorderRadius(context)),
        ),
      ),
      counterText: '',
      contentPadding: EdgeInsets.only(
        top: Constants.getTextformfieldContentPadding(context),
        left: Constants.getTextformfieldContentPadding(context),
        bottom: Constants.getTextformfieldContentPadding(context),
      ),
    );
  }
}
