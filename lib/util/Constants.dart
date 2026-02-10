import 'dart:ui';
import 'package:flutter/material.dart';

class Constants {
  static double getBackArrowTopPadding(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.02;
  }

  static double getBackArrowBottomPadding(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.02;
  }

  static double getBackArrowLeftPadding(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.01;
  }

  static double getSymmetricHorizontalPadding(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.025;
  }

  static double getVerticalGapBetweenMainAndSmallFont(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.002;
  }

  static double getVerticalGapBetweenForgotPasswordAndSignInButton(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.03;
  }

  static double getVerticalGapAfterLoginViaGovLogInPage(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.17;
  }


  static double getButtonFont(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.022;
  }

  static double getVerticalGapBetweenSmallfontAndTextfield(
      BuildContext context) {
    return MediaQuery.of(context).size.height * 0.04;
  }

  static double getHomePageGapAboveCard(
      BuildContext context) {
    return MediaQuery.of(context).size.height * 0.04;
  }

  static double getHomePageMainTextTopPadding(
      BuildContext context) {
    return MediaQuery.of(context).size.height * 0.025;
  }
  static double getHomePageMainTextLeftPadding(
      BuildContext context) {
    return MediaQuery.of(context).size.height * 0.02;
  }
  static double getHomePageMainTextRightPadding(
      BuildContext context) {
    return MediaQuery.of(context).size.height * 0.02;
  }
  static double getHomePageMainTextBottomPadding(
      BuildContext context) {
    return MediaQuery.of(context).size.height * 0.025;
  }

  static double getMainFontSize(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.032;
  }

  static double getServiceFontSize(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.02;
  }

  static double getHomePageMainFontSize(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.028;
  }

  static double getSmallFontSize(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.018;
  }

  static double getGeneralFontSize(BuildContext context) {
    return MediaQuery.of(context).size.height *1;
  }

  static double getTabViewHeight(BuildContext context) {
    return MediaQuery.of(context).size.width * 0.305;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getTabSelectedFontSize(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.017;
  }

  static double getTabUnSelectedFontSize(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.016;
  }

  static double getTextformfieldHeight(BuildContext context) {
    return MediaQuery.of(context).size.height * .08;
  }

  static double getTextformfieldHintFont(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.019;
  }

  static double getCardSmallFontSize(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.012;
  }

  static double getCardHolderNameFontSize(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.017;
  }

  static double getCardNumberFontSize(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.015;
  }

  static double getCardLeftPadding(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.025;
  }

  static double getCardRightPadding(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.025;
  }

  static double getCardHeight(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.27;
  }

  static double getCardBottomPadding(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.015;
  }


  static double getCardMediumFontSize(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.02;
  }

  static double getForgotPasswordFontSize(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.021;
  }

  static double getTextformfieldBorderRadius(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.019;
  }

  static double getCardBorderRadius(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.04;
  }

  static double getButtonRadius(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.5;
  }

  static double getTextformfieldContentPadding(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.01;
  }

  static double getCardInsidePadding(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.025;
  }

  static double getLoginViaEIdentityVerticalPadding(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.01;
  }

  static double getLoginVerticalGapBelowLastLine(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.01;
  }

  static double getSignInButtonAboveGap(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.04;
  }

  static double getVerticalGapAboveLastLine(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.035;
  }

  static double getLoginViaEIdentityLeftImagePadding(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.08;
  }

  static double getLoginViaEIdentityHorizontalGap(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.01;
  }

  static double getLoginViaEIdentityHorizontalPadding(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.01;
  }

  static double getHorizontalGapBetweenTwoTextformfields(
      BuildContext context) {
    return MediaQuery.of(context).size.height * 0.02;
  }

  static double getVerticalGapBetweenTwoTextformfields(
      BuildContext context) {
    return MediaQuery.of(context).size.height * .001;
  }

  static String baseUrl() {
    return 'http://apipaymir.kp.gov.pk/';
  }


  static Color primaryColor() {
    return Color(0xff03110A);
  }

  static Color signInLinkColor() {
    return Color(0xff21BF73);
  }


  static Color signUpLinkColor() {
    return Color(0xff21BF73);
  }

  static Color gradientColor1() {
    return Color(0xff08A1A7);
  }

  static Color gradientColor2() {
    return Color(0xff4B2A7A);
  }

  static Color secondaryColor() {
    return Color(0xff949494);
  }

  static Color tertiaryColor() {
    return Color(0xff21BF73);
  }


  static Color forgotPasswordColor() {
    return Color(0xff7472DE);
  }

  static double getTextFormFieldHeight(BuildContext context) {
    return MediaQuery.of(context).size.height * .08;
  }

  static double getButtonHeight(BuildContext context) {
    return MediaQuery.of(context).size.height * .07;
  }
}
