import 'dart:developer';

import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paymir_new_android/util/app_strings.dart';
import 'package:provider/provider.dart';

import '../../providers/login_provider.dart';
import '../../util/AlertDialogueClass.dart';
import '../../util/Mediaquery_Constant.dart';
import '../../util/MyValidation.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text.dart';
import '../../widget/custom_textfield.dart';
import '../main/main_screen.dart';
import '../signup/signup_screen.dart';
import 'ForgotPasswordPageNew.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _CNICController = MaskedTextController(
    mask: '00000-0000000-0',
  );
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _validateForm() {
    return MyValidation.validateCNIC(_CNICController.text) == null &&
        MyValidation.validatePassword(_passwordController.text) == null;
  }

  Future<void> _handleLogin(BuildContext context) async {
    log('Login button pressed');
    if (!_formKey.currentState!.validate() || !_validateForm()) {
      log('Form validation failed');
      return;
    }

    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    log('Calling login API...');
    final success = await loginProvider.login(
      cnic: _CNICController.text,
      password: _passwordController.text,
      context: context,
    );

    log('Login result: $success');
    if (success && mounted) {
      log('Navigating to MainScreen');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    } else {
      log('Login failed or widget unmounted - not navigating');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (consumerContext, loginProvider, _) {
        return WillPopScope(
          onWillPop: () async {
            return (await ShowAlertDialogueClass.exitAppDialog(
              consumerContext,
            ));
          },
          child: Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: MediaQueryConstant.getBackArrowLeftPadding(
                              consumerContext,
                            ),
                            top: MediaQueryConstant.getBackArrowTopPadding(
                              consumerContext,
                            ),
                            bottom:
                                MediaQueryConstant.getBackArrowBottomPadding(
                                  consumerContext,
                                ),
                          ),
                          child: IconButton(
                            icon: SvgPicture.asset(
                              "assets/images/back_arrow.svg",
                            ),
                            onPressed: () async {
                              await ShowAlertDialogueClass.exitAppDialog(
                                consumerContext,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            MediaQueryConstant.getSymmetricHorizontalPadding(
                              consumerContext,
                            ),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText.mainTitle(
                              text: AppStrings.signInTitle,
                              context: consumerContext,
                            ),
                            SizedBox(
                              height:
                                  MediaQueryConstant.getVerticalGapBetweenMainAndSmallFont(
                                    consumerContext,
                                  ),
                            ),
                            CustomText.subtitle(
                              text: AppStrings.signInSubtitle,
                              context: consumerContext,
                            ),
                            SizedBox(
                              height:
                                  MediaQueryConstant.getVerticalGapBetweenSmallfontAndTextfield(
                                    consumerContext,
                                  ),
                            ),
                            CustomTextField.cnic(controller: _CNICController),
                            SizedBox(
                              height:
                                  MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
                                    consumerContext,
                                  ),
                            ),
                            CustomTextField.password(
                              controller: _passwordController,
                              obscureText: !loginProvider.passwordVisible,
                              onToggleVisibility: () {
                                loginProvider.togglePasswordVisibility();
                              },
                              validator:
                                  (value) =>
                                      MyValidation.validateEmailPassword(value),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      consumerContext,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => ForgotPasswordNew(),
                                      ),
                                    );
                                  },
                                  child: CustomText.forgotPassword(
                                    text: AppStrings.forgotPassword,
                                    context: consumerContext,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQueryConstant.getVerticalGapBetweenForgotPasswordAndSignInButton(
                                    consumerContext,
                                  ),
                            ),
                            CustomButton(
                              onPressed: () => _handleLogin(consumerContext),
                              text: AppStrings.signIn,
                              isLoading: loginProvider.isLoading,
                              isEnabled: true,
                            ),
                            SizedBox(
                              height:
                                  MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
                                    consumerContext,
                                  ) *
                                  20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    thickness: 1,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  child: CustomText.divider(
                                    text: AppStrings.or,
                                    context: consumerContext,
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    thickness: 1,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
                                    consumerContext,
                                  ) *
                                  20,
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    MediaQueryConstant.getTextformfieldBorderRadius(
                                      consumerContext,
                                    ),
                                  ),
                                ),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQueryConstant.getLoginViaEIdentityVerticalPadding(
                                      consumerContext,
                                    ),
                                horizontal:
                                    MediaQueryConstant.getLoginViaEIdentityVerticalPadding(
                                      consumerContext,
                                    ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left:
                                          MediaQueryConstant.getLoginViaEIdentityLeftImagePadding(
                                            consumerContext,
                                          ),
                                    ),
                                    child: SvgPicture.asset(
                                      "assets/images/gov_eidentity_icon.svg",
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQueryConstant.getLoginViaEIdentityHorizontalGap(
                                          consumerContext,
                                        ),
                                  ),
                                  Expanded(
                                    child: CustomText(
                                      text: AppStrings.loginViaGovIdentity,
                                      type: CustomTextType.body,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQueryConstant.getVerticalGapAfterLoginViaGovLogInPage(
                                    consumerContext,
                                  ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText.body(
                                  text: AppStrings.notRegistered,
                                  context: consumerContext,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      consumerContext,
                                      MaterialPageRoute(
                                        builder: (_) => const SignUp(),
                                      ),
                                    );
                                  },
                                  child: CustomText.link(
                                    text: AppStrings.signUp,
                                    context: consumerContext,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
