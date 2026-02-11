import 'package:flutter/material.dart';

import '../../utils/constants.dart';

/// Centralized theme configuration for the application
class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xff03110A);
  static const Color secondaryColor = Color(0xff949494);
  static const Color tertiaryColor = Color(0xff21BF73);
  static const Color signUpLinkColor = Color(0xff21BF73);
  static const Color forgotPasswordColor = Color(0xff7472DE);
  static const Color gradientColor1 = Color(0xff08A1A7);
  static const Color gradientColor2 = Color(0xff4B2A7A);
  static const Color errorColor = Colors.red;
  static const Color successColor = Colors.green;
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [gradientColor1, gradientColor2],
  );

  // Text Styles
  static TextStyle mainTitle(BuildContext context) {
    return TextStyle(
      color: primaryColor,
      fontFamily: 'Visby',
      fontWeight: FontWeight.bold,
      fontSize: Constants.getMainFontSize(context),
    );
  }

  static TextStyle subtitle(BuildContext context) {
    return TextStyle(
      color: secondaryColor,
      fontFamily: 'Visby',
      fontWeight: FontWeight.w500,
      fontSize: Constants.getSmallFontSize(context),
    );
  }

  static TextStyle body(BuildContext context, {FontWeight? fontWeight}) {
    return TextStyle(
      color: secondaryColor,
      fontFamily: 'Visby',
      fontWeight: fontWeight ?? FontWeight.normal,
      fontSize: Constants.getTextformfieldHintFont(context),
    );
  }

  static TextStyle button(BuildContext context) {
    return TextStyle(
      color: white,
      fontFamily: 'Visby',
      fontWeight: FontWeight.bold,
      fontSize: Constants.getButtonFont(context),
    );
  }

  static TextStyle link(BuildContext context) {
    return TextStyle(
      color: signUpLinkColor,
      fontFamily: 'Visby',
      fontWeight: FontWeight.normal,
      fontSize: Constants.getTextformfieldHintFont(context),
    );
  }

  static TextStyle forgotPassword(BuildContext context) {
    return TextStyle(
      color: forgotPasswordColor,
      fontFamily: 'Visby',
      fontWeight: FontWeight.normal,
      fontSize: Constants.getForgotPasswordFontSize(context),
    );
  }

  // Spacing
  static double getVerticalSpacing(BuildContext context, double multiplier) {
    return Constants.getVerticalGapBetweenTwoTextformfields(context) * multiplier;
  }

  static double getHorizontalSpacing(BuildContext context, double multiplier) {
    return Constants.getHorizontalGapBetweenTwoTextformfields(context) * multiplier;
  }

  // Theme Data
  static ThemeData getThemeData() {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: white,
      fontFamily: 'Visby',
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: tertiaryColor,
      ),
    );
  }
}
