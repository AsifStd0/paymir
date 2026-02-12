import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../util/Constants.dart';

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
        height: height ?? Constants.getButtonHeight(context),
        decoration:
            canPress
                ? BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(Constants.getButtonRadius(context)),
                  ),
                  gradient: AppColors.primaryGradient,
                )
                : BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.all(
                    Radius.circular(Constants.getButtonRadius(context)),
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
                    fontSize: Constants.getButtonFont(context),
                    fontFamily: 'Visby',
                    fontWeight: FontWeight.bold,
                  ),
                ),
      ),
    );
  }
}
