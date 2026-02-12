import 'dart:developer';

import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paymir_new_android/utils/app_strings.dart';
import 'package:provider/provider.dart';

import '../../providers/auth/login_provider.dart';
import '../../util/AlertDialogueClass.dart';
import '../../util/Constants.dart';
import '../../util/MyValidation.dart';
import '../../widget/custom/custom_button.dart';
import '../../widget/custom/custom_text.dart';
import '../../widget/custom/custom_textfield.dart';
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
    return MyValidationClass.validateCNIC(_CNICController.text) == null &&
        MyValidationClass.validatePassword(_passwordController.text) == null;
  }

  Future<void> _handleLogin(BuildContext context) async {
    log('message');
    // if (!_formKey.currentState!.validate() || !_validateForm()) return;

    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final success = await loginProvider.login(
      cnic: _CNICController.text,
      password: _passwordController.text,
      context: context,
    );

    // if (success && mounted) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MainScreen()),
    );
    // }
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
                            left: Constants.getBackArrowLeftPadding(
                              consumerContext,
                            ),
                            top: Constants.getBackArrowTopPadding(
                              consumerContext,
                            ),
                            bottom: Constants.getBackArrowBottomPadding(
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
                        horizontal: Constants.getSymmetricHorizontalPadding(
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
                                  Constants.getVerticalGapBetweenMainAndSmallFont(
                                    consumerContext,
                                  ),
                            ),
                            CustomText.subtitle(
                              text: AppStrings.signInSubtitle,
                              context: consumerContext,
                            ),
                            SizedBox(
                              height:
                                  Constants.getVerticalGapBetweenSmallfontAndTextfield(
                                    consumerContext,
                                  ),
                            ),
                            CustomTextField.cnic(controller: _CNICController),
                            SizedBox(
                              height:
                                  Constants.getVerticalGapBetweenTwoTextformfields(
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
                                      MyValidationClass.validateEmailPassword(
                                        value,
                                      ),
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
                                  Constants.getVerticalGapBetweenForgotPasswordAndSignInButton(
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
                                  Constants.getVerticalGapBetweenTwoTextformfields(
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
                                  Constants.getVerticalGapBetweenTwoTextformfields(
                                    consumerContext,
                                  ) *
                                  20,
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    Constants.getTextformfieldBorderRadius(
                                      consumerContext,
                                    ),
                                  ),
                                ),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical:
                                    Constants.getLoginViaEIdentityVerticalPadding(
                                      consumerContext,
                                    ),
                                horizontal:
                                    Constants.getLoginViaEIdentityVerticalPadding(
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
                                          Constants.getLoginViaEIdentityLeftImagePadding(
                                            consumerContext,
                                          ),
                                    ),
                                    child: SvgPicture.asset(
                                      "assets/images/gov_eidentity_icon.svg",
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        Constants.getLoginViaEIdentityHorizontalGap(
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
                                  Constants.getVerticalGapAfterLoginViaGovLogInPage(
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
