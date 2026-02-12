import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import 'app_colors.dart';

/// Centralized theme configuration for the application
class AppTheme {
  // ============================================
  // TEXT STYLES
  // ============================================

  /// Main title text style
  static TextStyle mainTitle(BuildContext context) {
    return TextStyle(
      color: AppColors.primary,
      fontFamily: 'Visby',
      fontWeight: FontWeight.bold,
      fontSize: Constants.getMainFontSize(context),
    );
  }

  /// Subtitle text style
  static TextStyle subtitle(BuildContext context) {
    return TextStyle(
      color: AppColors.secondary,
      fontFamily: 'Visby',
      fontWeight: FontWeight.w500,
      fontSize: Constants.getSmallFontSize(context),
    );
  }

  /// Body text style
  static TextStyle body(
    BuildContext context, {
    FontWeight? fontWeight,
    Color? color,
  }) {
    return TextStyle(
      color: color ?? AppColors.secondary,
      fontFamily: 'Visby',
      fontWeight: fontWeight ?? FontWeight.normal,
      fontSize: Constants.getTextformfieldHintFont(context),
    );
  }

  /// Button text style
  static TextStyle button(BuildContext context) {
    return TextStyle(
      color: AppColors.white,
      fontFamily: 'Visby',
      fontWeight: FontWeight.bold,
      fontSize: Constants.getButtonFont(context),
    );
  }

  /// Link text style
  static TextStyle link(BuildContext context) {
    return TextStyle(
      color: AppColors.link,
      fontFamily: 'Visby',
      fontWeight: FontWeight.normal,
      fontSize: Constants.getTextformfieldHintFont(context),
    );
  }

  /// Forgot password text style
  static TextStyle forgotPassword(BuildContext context) {
    return TextStyle(
      color: AppColors.forgotPassword,
      fontFamily: 'Visby',
      fontWeight: FontWeight.normal,
      fontSize: Constants.getForgotPasswordFontSize(context),
    );
  }

  /// Error text style
  static TextStyle error(BuildContext context) {
    return TextStyle(
      color: AppColors.error,
      fontFamily: 'Visby',
      fontWeight: FontWeight.normal,
      fontSize: Constants.getTextformfieldHintFont(context),
    );
  }

  /// Success text style
  static TextStyle success(BuildContext context) {
    return TextStyle(
      color: AppColors.success,
      fontFamily: 'Visby',
      fontWeight: FontWeight.bold,
      fontSize: Constants.getTextformfieldHintFont(context),
    );
  }

  // ============================================
  // SPACING HELPERS
  // ============================================

  /// Get vertical spacing
  static double getVerticalSpacing(BuildContext context, double multiplier) {
    return Constants.getVerticalGapBetweenTwoTextformfields(context) *
        multiplier;
  }

  /// Get horizontal spacing
  static double getHorizontalSpacing(BuildContext context, double multiplier) {
    return Constants.getHorizontalGapBetweenTwoTextformfields(context) *
        multiplier;
  }

  // ============================================
  // THEME DATA
  // ============================================

  /// Get the main theme data for the app
  static ThemeData getThemeData() {
    return ThemeData(
      // Primary color
      primaryColor: AppColors.primary,

      // Scaffold background
      scaffoldBackgroundColor: AppColors.background,

      // Default font family
      fontFamily: 'Visby',

      // Use Material 3
      useMaterial3: true,

      // Color scheme
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        tertiary: AppColors.tertiary,
        error: AppColors.error,
        surface: AppColors.white,
        background: AppColors.background,
      ),

      // App bar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
      ),

      // Card theme
      cardTheme: CardThemeData(
        color: AppColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.tertiary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),

      // Button themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.link),
      ),

      // Divider theme
      dividerTheme: const DividerThemeData(
        color: AppColors.borderLight,
        thickness: 1,
      ),
    );
  }
}
