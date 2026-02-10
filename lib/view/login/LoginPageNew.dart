import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../util/AlertDialogueClass.dart';
import '../../util/Constants.dart';
import '../../util/MyValidation.dart';
import '../../widget/custom/custom_button.dart';
import '../../widget/custom/custom_text.dart';
import '../../widget/custom/custom_textfield.dart';
import '../HomePageNew.dart';
import '../signup/sign_up.dart';
import 'ForgotPasswordPageNew.dart';
import 'login_provider.dart';

class LoginPageNew extends StatefulWidget {
  const LoginPageNew({super.key});

  @override
  _LoginPageNewState createState() => _LoginPageNewState();
}

class _LoginPageNewState extends State<LoginPageNew> {
  final TextEditingController _CNICController = MaskedTextController(
    mask: '00000-0000000-0',
  );
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // Fallback state if provider is not available
  bool _passwordVisible = false;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // Form validation passed
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return (await ShowAlertDialogueClass.exitAppDialog(context));
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
                        left: Constants.getBackArrowLeftPadding(context),
                        top: Constants.getBackArrowTopPadding(context),
                        bottom: Constants.getBackArrowBottomPadding(context),
                      ),

                      child: IconButton(
                        icon: SvgPicture.asset("assets/images/back_arrow.svg"),
                        onPressed: () async {
                          (await ShowAlertDialogueClass.exitAppDialog(context));
                        },
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Constants.getSymmetricHorizontalPadding(
                      context,
                    ),
                  ),

                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText.mainTitle(text: 'Sign In', context: context),

                        SizedBox(
                          height:
                              Constants.getVerticalGapBetweenMainAndSmallFont(
                                context,
                              ),
                        ),

                        CustomText.subtitle(
                          text: 'You have been missed',
                          context: context,
                        ),

                        SizedBox(
                          height:
                              Constants.getVerticalGapBetweenSmallfontAndTextfield(
                                context,
                              ),
                        ),

                        CustomTextField.cnic(controller: _CNICController),

                        SizedBox(
                          height:
                              Constants.getVerticalGapBetweenTwoTextformfields(
                                context,
                              ),
                        ),

                        Builder(
                          builder: (builderContext) {
                            try {
                              final loginProvider = Provider.of<LoginProvider>(
                                builderContext,
                                listen: true,
                              );
                              return CustomTextField.password(
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
                              );
                            } catch (e) {
                              // Provider not found - use local state as fallback
                              return CustomTextField.password(
                                controller: _passwordController,
                                obscureText: !_passwordVisible,
                                onToggleVisibility: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                                validator:
                                    (value) =>
                                        MyValidationClass.validateEmailPassword(
                                          value,
                                        ),
                              );
                            }
                          },
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ForgotPasswordNew(),
                                  ),
                                );
                              },
                              child: CustomText.forgotPassword(
                                text: 'Forgot Password?',
                                context: context,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height:
                              Constants.getVerticalGapBetweenForgotPasswordAndSignInButton(
                                context,
                              ),
                        ),

                        Builder(
                          builder: (builderContext) {
                            try {
                              final loginProvider = Provider.of<LoginProvider>(
                                builderContext,
                                listen: true,
                              );
                              return CustomButton(
                                onPressed: () async {
                                  _submit();

                                  // Validate fields
                                  if (MyValidationClass.validateCNIC(
                                            _CNICController.text,
                                          ) ==
                                          null &&
                                      MyValidationClass.validatePassword(
                                            _passwordController.text,
                                          ) ==
                                          null) {
                                    final success = await loginProvider.login(
                                      cnic: _CNICController.text,
                                      password: _passwordController.text,
                                      context: builderContext,
                                    );

                                    if (success && mounted) {
                                      Navigator.pushReplacement(
                                        builderContext,
                                        MaterialPageRoute(
                                          builder: (_) => const HomePageNew(),
                                        ),
                                      );
                                    }
                                  }
                                },
                                text: 'Sign In',
                                isLoading: loginProvider.isLoading,
                                isEnabled: true,
                              );
                            } catch (e) {
                              // Provider not found - use local state as fallback
                              // This should not happen if provider is properly registered
                              // But we provide fallback for safety
                              return CustomButton(
                                onPressed: () async {
                                  _submit();

                                  // Validate fields
                                  if (MyValidationClass.validateCNIC(
                                            _CNICController.text,
                                          ) ==
                                          null &&
                                      MyValidationClass.validatePassword(
                                            _passwordController.text,
                                          ) ==
                                          null) {
                                    // Show error that provider is not available
                                    ShowAlertDialogueClass.showAlertDialogue(
                                      context: builderContext,
                                      title: "Error",
                                      message:
                                          "Please restart the app. Provider not initialized.",
                                      buttonText: "OK",
                                      iconData: Icons.error,
                                    );
                                  }
                                },
                                text: 'Sign In',
                                isLoading: false,
                                isEnabled: true,
                              );
                            }
                          },
                        ),

                        SizedBox(
                          height:
                              Constants.getVerticalGapBetweenTwoTextformfields(
                                context,
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
                                text: 'OR',
                                context: context,
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
                                context,
                              ) *
                              20,
                        ),

                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                Constants.getTextformfieldBorderRadius(context),
                              ),
                            ),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical:
                                Constants.getLoginViaEIdentityVerticalPadding(
                                  context,
                                ),
                            horizontal:
                                Constants.getLoginViaEIdentityVerticalPadding(
                                  context,
                                ),
                          ),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left:
                                      Constants.getLoginViaEIdentityLeftImagePadding(
                                        context,
                                      ),
                                ),
                                child: SvgPicture.asset(
                                  "assets/images/gov_eidentity_icon.svg",
                                ),
                              ),
                              SizedBox(
                                width:
                                    Constants.getLoginViaEIdentityHorizontalGap(
                                      context,
                                    ),
                              ),
                              Expanded(
                                child: CustomText(
                                  text: 'Login via Gov e Identity',
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
                                context,
                              ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText.body(
                              text: "Not Registered? ",
                              context: context,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const SignUp(),
                                  ),
                                );
                              },
                              child: CustomText.link(
                                text: "Sign Up",
                                context: context,
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
  }
}
