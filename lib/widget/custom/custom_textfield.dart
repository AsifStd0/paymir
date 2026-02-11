import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paymir_new_android/util/app_colors.dart';

import '../../../util/Constants.dart';
import 'input_decoration.dart';
import 'validation.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextAlign textAlign;
  final VoidCallback? onSuffixIconTap;
  final bool showPasswordToggle;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.maxLength,
    this.inputFormatters,
    this.suffixIcon,
    this.prefixIcon,
    this.textAlign = TextAlign.start,
    this.onSuffixIconTap,
    this.showPasswordToggle = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Constants.getTextFormFieldHeight(context),
      child: TextFormField(
        controller: controller,
        textAlign: textAlign,
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLength: maxLength,
        inputFormatters: inputFormatters,
        validator: validator,
        decoration: CustomInputDecoration.getDecoration(
          context: context,
          hintText: hintText,
          suffixIcon:
              suffixIcon ??
              (showPasswordToggle && onSuffixIconTap != null
                  ? IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.secondaryColor(),
                    ),
                    onPressed: onSuffixIconTap,
                  )
                  : null),
          prefixIcon: prefixIcon,
        ),
      ),
    );
  }

  // Factory constructors for common field types
  factory CustomTextField.name({
    required TextEditingController controller,
    String hintText = 'Name',
    int? maxLength = 15,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return CustomTextField(
      controller: controller,
      hintText: hintText,
      validator: CustomValidation.validateName,
      maxLength: maxLength,
      inputFormatters:
          inputFormatters ?? [FilteringTextInputFormatter.deny(RegExp(r"\s"))],
    );
  }

  factory CustomTextField.email({
    required TextEditingController controller,
    String hintText = 'Email Address',
    int? maxLength = 60,
  }) {
    return CustomTextField(
      controller: controller,
      hintText: hintText,
      validator: CustomValidation.validateEmail,
      keyboardType: TextInputType.emailAddress,
      maxLength: maxLength,
    );
  }

  factory CustomTextField.cnic({
    required TextEditingController controller,
    String hintText = 'CNIC',
  }) {
    return CustomTextField(
      controller: controller,
      hintText: hintText,
      validator: CustomValidation.validateCNIC,
      keyboardType: TextInputType.number,
    );
  }

  factory CustomTextField.password({
    required TextEditingController controller,
    required bool obscureText,
    required VoidCallback onToggleVisibility,
    String hintText = 'Password',
    int? maxLength = 30,
    String? Function(String?)? validator,
  }) {
    return CustomTextField(
      controller: controller,
      hintText: hintText,
      validator: validator ?? CustomValidation.validatePassword,
      obscureText: obscureText,
      maxLength: maxLength,
      showPasswordToggle: true,
      onSuffixIconTap: onToggleVisibility,
    );
  }
}
