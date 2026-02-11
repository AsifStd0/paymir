import 'package:flutter/material.dart';

import '../../../util/Constants.dart';
import 'app_color.dart';

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
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      AppColor.gradientColor1(),
                      AppColor.gradientColor2(),
                    ],
                  ),
                )
                : BoxDecoration(
                  color: AppColors.secondaryColor(),
                  borderRadius: BorderRadius.all(
                    Radius.circular(Constants.getButtonRadius(context)),
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
                    fontSize: Constants.getButtonFont(context),
                    fontFamily: 'Visby',
                    fontWeight: FontWeight.bold,
                  ),
                ),
      ),
    );
  }
}
