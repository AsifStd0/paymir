import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paymir_new_android/core/theme/app_colors.dart';
import 'package:paymir_new_android/utils/app_strings.dart';
import 'package:provider/provider.dart';

import '../../providers/auth/signup_provider.dart';
import '../../util/Constants.dart';
import '../../util/MyValidation.dart';
import '../../widget/PrivacyPolicyPageNew.dart';
import '../../widget/custom/custom_button.dart';
import '../../widget/custom/custom_text.dart';
import '../../widget/custom/custom_textfield.dart';
import '../login/login_screen.dart';
import '../mobile_page_view/MobilePageNew.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _cnicController = MaskedTextController(
    mask: '00000-0000000-0',
  );
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _validateForm() {
    return MyValidationClass.validateName(_firstNameController.text) == null &&
        MyValidationClass.validateName(_lastNameController.text) == null &&
        MyValidationClass.validateEmail(_emailController.text) == null &&
        MyValidationClass.validateCNIC(_cnicController.text) == null &&
        MyValidationClass.validatePassword(_passwordController.text) == null;
  }

  Map<String, String> _prepareValues() {
    return {
      'fullname': "${_firstNameController.text} ${_lastNameController.text}",
      'emailAddress': _emailController.text,
      'cnic': _cnicController.text,
      'password': _passwordController.text,
      'Category': "PAYMIR",
    };
  }

  Future<void> _handleSignUp(BuildContext context) async {
    if (!_formKey.currentState!.validate() || !_validateForm()) return;

    final signupProvider = Provider.of<SignupProvider>(context, listen: false);
    if (!signupProvider.isChecked) return;

    final isVerified = await signupProvider.checkUser(
      _cnicController.text,
      context,
    );

    if (isVerified && mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MobilePageNew(_prepareValues()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
        return false;
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
                        onPressed:
                            () => {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              ),
                            }, //Navigator.pop(context),
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
                        CustomText.mainTitle(
                          text: AppStrings.signUpTitle,
                          context: context,
                        ),

                        SizedBox(
                          height:
                              Constants.getVerticalGapBetweenMainAndSmallFont(
                                context,
                              ),
                        ),

                        CustomText.subtitle(
                          text: AppStrings.signUpSubtitle,
                          context: context,
                        ),

                        SizedBox(
                          height:
                              Constants.getVerticalGapBetweenSmallfontAndTextfield(
                                context,
                              ),
                        ),

                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField.name(
                                controller: _firstNameController,
                                hintText: AppStrings.firstName,
                              ),
                            ),
                            SizedBox(
                              width:
                                  Constants.getHorizontalGapBetweenTwoTextformfields(
                                    context,
                                  ),
                            ),
                            Expanded(
                              child: CustomTextField.name(
                                controller: _lastNameController,
                                hintText: AppStrings.lastName,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height:
                              Constants.getVerticalGapBetweenTwoTextformfields(
                                context,
                              ),
                        ),

                        CustomTextField.cnic(controller: _cnicController),
                        SizedBox(
                          height:
                              Constants.getVerticalGapBetweenTwoTextformfields(
                                context,
                              ),
                        ),

                        CustomTextField.email(controller: _emailController),
                        SizedBox(
                          height:
                              Constants.getVerticalGapBetweenTwoTextformfields(
                                context,
                              ),
                        ),
                        Consumer<SignupProvider>(
                          builder: (context, signupProvider, _) {
                            return CustomTextField.password(
                              controller: _passwordController,
                              obscureText: !signupProvider.passwordVisible,
                              onToggleVisibility: () {
                                signupProvider.togglePasswordVisibility();
                              },
                            );
                          },
                        ),

                        SizedBox(
                          height:
                              Constants.getVerticalGapBetweenTwoTextformfields(
                                context,
                              ),
                        ),
                        Consumer<SignupProvider>(
                          builder: (context, signupProvider, _) {
                            return Row(
                              children: [
                                Checkbox(
                                  value: signupProvider.isChecked,
                                  onChanged: (value) {
                                    signupProvider.setChecked(value!);
                                  },
                                ),
                                Flexible(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: AppStrings.agreeTerms,
                                          style: TextStyle(
                                            color: AppColors.secondaryColor(),
                                            fontFamily: 'Visby',
                                            fontWeight: FontWeight.normal,
                                            fontSize:
                                                Constants.getTextformfieldHintFont(
                                                  context,
                                                ),
                                          ),
                                        ),
                                        TextSpan(
                                          recognizer:
                                              TapGestureRecognizer()
                                                ..onTap =
                                                    () => Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder:
                                                            (_) =>
                                                                const PrivacyPolicyPage(),
                                                      ),
                                                    ),
                                          text: AppStrings.termsOfService,
                                          style: TextStyle(
                                            color: AppColors.tertiaryColor(),
                                            fontFamily: 'Visby',
                                            fontWeight: FontWeight.normal,
                                            fontSize:
                                                Constants.getTextformfieldHintFont(
                                                  context,
                                                ),
                                          ),
                                        ),
                                        TextSpan(
                                          text: AppStrings.and,
                                          style: TextStyle(
                                            color: AppColors.secondaryColor(),
                                            fontFamily: 'Visby',
                                            fontWeight: FontWeight.normal,
                                            fontSize:
                                                Constants.getTextformfieldHintFont(
                                                  context,
                                                ),
                                          ),
                                        ),
                                        TextSpan(
                                          recognizer:
                                              TapGestureRecognizer()
                                                ..onTap =
                                                    () => Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder:
                                                            (_) =>
                                                                const PrivacyPolicyPage(),
                                                      ),
                                                    ),
                                          text: AppStrings.privacyPolicy,
                                          style: TextStyle(
                                            color: AppColors.tertiaryColor(),
                                            fontFamily: 'Visby',
                                            fontWeight: FontWeight.normal,
                                            fontSize:
                                                Constants.getTextformfieldHintFont(
                                                  context,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        SizedBox(
                          height:
                              Constants.getVerticalGapBetweenTwoTextformfields(
                                context,
                              ),
                        ),

                        Consumer<SignupProvider>(
                          builder: (context, signupProvider, _) {
                            return CustomButton(
                              onPressed:
                                  signupProvider.isChecked
                                      ? () => _handleSignUp(context)
                                      : null,
                              text: AppStrings.signUp,
                              isLoading: signupProvider.isLoading,
                              isEnabled: signupProvider.isChecked,
                            );
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
                                text: AppStrings.or,
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
                                  text: AppStrings.loginViaGovIdentity,
                                  type: CustomTextType.body,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Constants.getVerticalGapAboveLastLine(
                            context,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText.body(
                              text: AppStrings.alreadyRegistered,
                              context: context,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const LoginScreen(),
                                  ),
                                );
                              },
                              child: CustomText.link(
                                text: AppStrings.signIn,
                                context: context,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Constants.getLoginVerticalGapBelowLastLine(
                            context,
                          ),
                        ),
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
