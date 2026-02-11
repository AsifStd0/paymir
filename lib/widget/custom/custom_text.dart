import 'package:flutter/material.dart';
import 'package:paymir_new_android/util/app_colors.dart';

import '../../../util/Constants.dart';

enum CustomTextType {
  mainTitle,
  subtitle,
  body,
  hint,
  button,
  link,
  error,
  forgotPassword,
  divider,
}

class CustomText extends StatelessWidget {
  final String text;
  final CustomTextType type;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const CustomText({
    super.key,
    required this.text,
    required this.type,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: _getTextStyle(context),
    );
  }

  TextStyle _getTextStyle(BuildContext context) {
    final baseStyle = TextStyle(
      fontFamily: 'Visby',
      color: color ?? _getDefaultColor(context),
      fontSize: fontSize ?? _getDefaultFontSize(context),
      fontWeight: fontWeight ?? _getDefaultFontWeight(),
    );

    return baseStyle;
  }

  Color _getDefaultColor(BuildContext context) {
    switch (type) {
      case CustomTextType.mainTitle:
        return AppColors.primaryColor();
      case CustomTextType.subtitle:
      case CustomTextType.body:
      case CustomTextType.hint:
      case CustomTextType.divider:
        return AppColors.secondaryColor();
      case CustomTextType.button:
        return Colors.white;
      case CustomTextType.link:
        return const Color(0xff21BF73);
      case CustomTextType.error:
        return Colors.red;
      case CustomTextType.forgotPassword:
        return AppColors.forgotPasswordColor();
    }
  }

  double _getDefaultFontSize(BuildContext context) {
    switch (type) {
      case CustomTextType.mainTitle:
        return Constants.getMainFontSize(context);
      case CustomTextType.subtitle:
        return Constants.getSmallFontSize(context);
      case CustomTextType.body:
      case CustomTextType.hint:
      case CustomTextType.link:
      case CustomTextType.divider:
        return Constants.getTextformfieldHintFont(context);
      case CustomTextType.button:
        return Constants.getButtonFont(context);
      case CustomTextType.error:
        return Constants.getTextformfieldHintFont(context);
      case CustomTextType.forgotPassword:
        return Constants.getForgotPasswordFontSize(context);
    }
  }

  FontWeight _getDefaultFontWeight() {
    switch (type) {
      case CustomTextType.mainTitle:
      case CustomTextType.button:
        return FontWeight.bold;
      case CustomTextType.subtitle:
        return FontWeight.w500;
      case CustomTextType.body:
      case CustomTextType.hint:
      case CustomTextType.link:
      case CustomTextType.divider:
      case CustomTextType.error:
      case CustomTextType.forgotPassword:
        return FontWeight.normal;
    }
  }

  // Factory constructors for common text types
  factory CustomText.mainTitle({
    required String text,
    BuildContext? context,
    Color? color,
    TextAlign? textAlign,
  }) {
    return CustomText(
      text: text,
      type: CustomTextType.mainTitle,
      color: color,
      textAlign: textAlign,
    );
  }

  factory CustomText.subtitle({
    required String text,
    BuildContext? context,
    Color? color,
    TextAlign? textAlign,
  }) {
    return CustomText(
      text: text,
      type: CustomTextType.subtitle,
      color: color,
      textAlign: textAlign,
    );
  }

  factory CustomText.body({
    required String text,
    BuildContext? context,
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
  }) {
    return CustomText(
      text: text,
      type: CustomTextType.body,
      color: color,
      fontWeight: fontWeight,
      textAlign: textAlign,
    );
  }

  factory CustomText.link({
    required String text,
    BuildContext? context,
    Color? color,
    VoidCallback? onTap,
    TextAlign? textAlign,
  }) {
    return CustomText(
      text: text,
      type: CustomTextType.link,
      color: color,
      textAlign: textAlign,
    );
  }

  factory CustomText.divider({
    required String text,
    BuildContext? context,
    Color? color,
    TextAlign? textAlign,
  }) {
    return CustomText(
      text: text,
      type: CustomTextType.divider,
      color: color,
      textAlign: textAlign,
    );
  }

  factory CustomText.forgotPassword({
    required String text,
    BuildContext? context,
    Color? color,
    TextAlign? textAlign,
  }) {
    return CustomText(
      text: text,
      type: CustomTextType.forgotPassword,
      color: color,
      textAlign: textAlign,
    );
  }
}
