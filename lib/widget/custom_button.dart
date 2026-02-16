import 'package:flutter/material.dart';

import '../util/Mediaquery_Constant.dart';
import '../util/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;
  final bool isEnabled;
  final double? width;
  final double? height;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.isEnabled = true,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final bool canPress = isEnabled && !isLoading && onPressed != null;

    return TextButton(
      onPressed: canPress ? onPressed : null,
      child: Container(
        alignment: Alignment.center,
        width: width ?? double.infinity,
        height: height ?? MediaQueryConstant.getButtonHeight(context),
        decoration:
            canPress
                ? BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      MediaQueryConstant.getButtonRadius(context),
                    ),
                  ),
                  gradient: AppColors.primaryGradient,
                )
                : BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      MediaQueryConstant.getButtonRadius(context),
                    ),
                  ),
                ),
        child:
            isLoading
                ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                )
                : Text(
                  text,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: MediaQueryConstant.getButtonFont(context),
                    fontFamily: 'Visby',
                    fontWeight: FontWeight.bold,
                  ),
                ),
      ),
    );
  }
}
