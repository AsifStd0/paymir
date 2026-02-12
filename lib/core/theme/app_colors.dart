import 'package:flutter/material.dart';

/// Centralized color system for the entire application
/// All colors used throughout the app should be defined here
class AppColors {
  // ============================================
  // PRIMARY BRAND COLORS
  // ============================================

  /// Primary brand color - Dark green/black
  /// Used for: Main titles, primary text
  static const Color primary = Color(0xff03110A);

  /// Secondary color - Medium gray
  /// Used for: Subtitles, body text, hints
  static const Color secondary = Color(0xff949494);

  /// Tertiary color - Green
  /// Used for: Links, success indicators
  static const Color tertiary = Color(0xff21BF73);

  // ============================================
  // GRADIENT COLORS
  // ============================================

  /// Gradient color 1 - Teal/Cyan
  /// Used for: Buttons, cards, gradients
  static const Color gradient1 = Color(0xff08A1A7);

  /// Gradient color 2 - Purple
  /// Used for: Buttons, cards, gradients
  static const Color gradient2 = Color(0xff4B2A7A);

  // ============================================
  // TEXT COLORS
  // ============================================

  /// Dark gray for headings
  /// Used for: Page titles, section headers
  static const Color textDark = Color(0xff474747);

  /// Medium dark gray for text
  /// Used for: Tab labels, important text
  static const Color textMedium = Color(0xff3F3F3F);

  /// Dark text color
  /// Used for: Transaction items, card text
  static const Color textDarkGray = Color(0xff424242);

  /// Light gray text
  /// Used for: Secondary text, placeholders
  static const Color textLightGray = Color(0xff929BA1);

  /// Card text color - Light blue/gray
  /// Used for: Payment card text
  static const Color cardText = Color(0xffD3DDE5);

  // ============================================
  // BACKGROUND COLORS
  // ============================================

  /// Main background color - Light blue/white
  /// Used for: Screen backgrounds
  static const Color background = Color(0xffFAFCFF);

  /// White background
  /// Used for: Cards, dialogs, containers
  static const Color white = Colors.white;

  /// Light gray background
  /// Used for: Service items, input fields
  static const Color backgroundLight = Color(0xffF4F6F9);

  /// Black background
  static const Color black = Colors.black;

  // ============================================
  // ACCENT COLORS
  // ============================================

  /// Success/Positive color - Green
  /// Used for: Success messages, positive amounts
  static const Color success = Color(0xff45C232);

  /// Success variant - Bright green
  /// Used for: Payment success, active states
  static const Color successVariant = Color(0xff32C774);

  /// Error color - Red
  /// Used for: Error messages, warnings
  static const Color error = Colors.red;

  /// Info color - Teal/Blue
  /// Used for: Information, links
  static const Color info = Color(0xff207797);

  /// Warning color - Orange/Yellow
  static const Color warning = Colors.orange;

  // ============================================
  // LINK & INTERACTIVE COLORS
  // ============================================

  /// Link color - Green
  /// Used for: Clickable links, sign up links
  static const Color link = Color(0xff21BF73);

  /// Sign in link color - Green
  static const Color signInLink = Color(0xff21BF73);

  /// Sign up link color - Green
  static const Color signUpLink = Color(0xff21BF73);

  /// Forgot password color - Purple
  /// Used for: Forgot password links
  static const Color forgotPassword = Color(0xff7472DE);

  // ============================================
  // BORDER & DIVIDER COLORS
  // ============================================

  /// Light border color
  /// Used for: Input field borders, dividers
  static const Color borderLight = Color(0xffEBEBEB);

  /// Medium border color
  static const Color borderMedium = Color(0xffCCCCCC);

  /// Divider color - Medium gray
  /// Used for: Tab dividers, separators
  static const Color divider = Color(0xff707070);

  // ============================================
  // SHADOW COLORS
  // ============================================

  /// Very light shadow - Almost transparent black
  /// Used for: Card shadows, elevation
  static const Color shadowLight = Color(0xff0000000a);

  /// Medium shadow - Semi-transparent black
  /// Used for: Text shadows
  static const Color shadowMedium = Color(0xff00000080);

  /// Dark shadow - For dialogs
  static Color shadowDark = Colors.black.withOpacity(0.5);

  // ============================================
  // SPECIAL COLORS
  // ============================================

  /// Tab indicator color - Purple
  /// Used for: Active tab indicators
  static const Color tabIndicator = Color(0xff6045FF);

  /// Purple accent - For special highlights
  static const Color purpleAccent = Color(0xff6E78F7);

  /// Card icon background - Purple
  /// Used for: Transaction item icons
  static const Color cardIconBg = Color(0xff4B2A7A);

  // ============================================
  // LEGACY METHODS (for backward compatibility)
  // ============================================

  /// Primary color (legacy method)
  @Deprecated('Use AppColors.primary instead')
  static Color primaryColor() => primary;

  /// Secondary color (legacy method)
  @Deprecated('Use AppColors.secondary instead')
  static Color secondaryColor() => secondary;

  /// Tertiary color (legacy method)
  @Deprecated('Use AppColors.tertiary instead')
  static Color tertiaryColor() => tertiary;

  /// Gradient color 1 (legacy method)
  @Deprecated('Use AppColors.gradient1 instead')
  static Color gradientColor1() => gradient1;

  /// Gradient color 2 (legacy method)
  @Deprecated('Use AppColors.gradient2 instead')
  static Color gradientColor2() => gradient2;

  /// Sign in link color (legacy method)
  @Deprecated('Use AppColors.signInLink instead')
  static Color signInLinkColor() => signInLink;

  /// Sign up link color (legacy method)
  @Deprecated('Use AppColors.signUpLink instead')
  static Color signUpLinkColor() => signUpLink;

  /// Forgot password color (legacy method)
  @Deprecated('Use AppColors.forgotPassword instead')
  static Color forgotPasswordColor() => forgotPassword;

  // ============================================
  // GRADIENTS
  // ============================================

  /// Primary gradient - Teal to Purple
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [gradient1, gradient2],
  );

  /// Vertical gradient - Top to bottom
  static const LinearGradient verticalGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [gradient1, gradient2],
  );

  /// Card gradient - For payment cards
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [gradient1, gradient2],
  );
}
