import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../util/Constants.dart';
import '../../util/MyValidation.dart';
import '../../widget/PrivacyPolicyPageNew.dart';
import '../../widget/custom/custom_button.dart';
import '../../widget/custom/custom_text.dart';
import '../../widget/custom/custom_textfield.dart';
import '../login/LoginPageNew.dart';
import '../mobile_page_view/MobilePageNew.dart';
import 'signup_provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Map<String, String> values = {};

  // Fallback state if provider is not available
  var _isChecked = false;
  bool _passwordVisible = false;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _cnicController = MaskedTextController(
    mask: '00000-0000000-0',
  );
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // Form validation passed
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPageNew()),
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
                                  builder: (context) => const LoginPageNew(),
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
                        CustomText.mainTitle(text: 'Sign Up', context: context),

                        SizedBox(
                          height:
                              Constants.getVerticalGapBetweenMainAndSmallFont(
                                context,
                              ),
                        ),

                        CustomText.subtitle(
                          text: 'It only takes a minute to create your account',
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
                                hintText: 'First Name',
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
                                hintText: 'Last Name',
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
                        Builder(
                          builder: (builderContext) {
                            try {
                              final signupProvider =
                                  Provider.of<SignupProvider>(
                                    builderContext,
                                    listen: true,
                                  );
                              return CustomTextField.password(
                                controller: _passwordController,
                                obscureText: !signupProvider.passwordVisible,
                                onToggleVisibility: () {
                                  signupProvider.togglePasswordVisibility();
                                },
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
                              );
                            }
                          },
                        ),

                        SizedBox(
                          height:
                              Constants.getVerticalGapBetweenTwoTextformfields(
                                context,
                              ),
                        ),
                        Builder(
                          builder: (builderContext) {
                            try {
                              final signupProvider =
                                  Provider.of<SignupProvider>(
                                    builderContext,
                                    listen: true,
                                  );
                              return Row(
                                children: [
                                  Checkbox(
                                    value: signupProvider.isChecked,
                                    onChanged: (value) {
                                      signupProvider.setChecked(value!);
                                      _submit();
                                    },
                                  ),
                                  Flexible(
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'I agree with the ',
                                            style: TextStyle(
                                              color: Constants.secondaryColor(),
                                              fontFamily: 'Visby',
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          TextSpan(
                                            recognizer:
                                                TapGestureRecognizer()
                                                  ..onTap =
                                                      () => Navigator.push(
                                                        builderContext,
                                                        MaterialPageRoute(
                                                          builder:
                                                              (context) =>
                                                                  const PrivacyPolicyPage(),
                                                        ),
                                                      ),
                                            text: 'Terms of Services ',
                                            style: TextStyle(
                                              color: Constants.tertiaryColor(),
                                              fontFamily: 'Visby',
                                              fontWeight: FontWeight.normal,
                                              fontSize:
                                                  Constants.getTextformfieldHintFont(
                                                    builderContext,
                                                  ),
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'and ',
                                            style: TextStyle(
                                              color: Constants.secondaryColor(),
                                              fontFamily: 'Visby',
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          TextSpan(
                                            recognizer:
                                                TapGestureRecognizer()
                                                  ..onTap =
                                                      () async => Navigator.push(
                                                        builderContext,
                                                        MaterialPageRoute(
                                                          builder:
                                                              (context) =>
                                                                  const PrivacyPolicyPage(),
                                                        ),
                                                      ),
                                            text: 'Privacy Policy',
                                            style: TextStyle(
                                              color: Constants.tertiaryColor(),
                                              fontFamily: 'Visby',
                                              fontWeight: FontWeight.normal,
                                              fontSize:
                                                  Constants.getTextformfieldHintFont(
                                                    builderContext,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } catch (e) {
                              // Provider not found - use local state as fallback
                              return Row(
                                children: [
                                  Checkbox(
                                    value: _isChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        _isChecked = value!;
                                      });
                                      _submit();
                                    },
                                  ),
                                  Flexible(
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'I agree with the ',
                                            style: TextStyle(
                                              color: Constants.secondaryColor(),
                                              fontFamily: 'Visby',
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          TextSpan(
                                            recognizer:
                                                TapGestureRecognizer()
                                                  ..onTap =
                                                      () => Navigator.push(
                                                        builderContext,
                                                        MaterialPageRoute(
                                                          builder:
                                                              (context) =>
                                                                  const PrivacyPolicyPage(),
                                                        ),
                                                      ),
                                            text: 'Terms of Services ',
                                            style: TextStyle(
                                              color: Constants.tertiaryColor(),
                                              fontFamily: 'Visby',
                                              fontWeight: FontWeight.normal,
                                              fontSize:
                                                  Constants.getTextformfieldHintFont(
                                                    builderContext,
                                                  ),
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'and ',
                                            style: TextStyle(
                                              color: Constants.secondaryColor(),
                                              fontFamily: 'Visby',
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          TextSpan(
                                            recognizer:
                                                TapGestureRecognizer()
                                                  ..onTap =
                                                      () async => Navigator.push(
                                                        builderContext,
                                                        MaterialPageRoute(
                                                          builder:
                                                              (context) =>
                                                                  const PrivacyPolicyPage(),
                                                        ),
                                                      ),
                                            text: 'Privacy Policy',
                                            style: TextStyle(
                                              color: Constants.tertiaryColor(),
                                              fontFamily: 'Visby',
                                              fontWeight: FontWeight.normal,
                                              fontSize:
                                                  Constants.getTextformfieldHintFont(
                                                    builderContext,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height:
                              Constants.getVerticalGapBetweenTwoTextformfields(
                                context,
                              ),
                        ),

                        Builder(
                          builder: (builderContext) {
                            try {
                              final signupProvider =
                                  Provider.of<SignupProvider>(
                                    builderContext,
                                    listen: true,
                                  );
                              return CustomButton(
                                onPressed:
                                    signupProvider.isChecked
                                        ? () async {
                                          _submit();

                                          // Validate all fields
                                          if (MyValidationClass.validateName(
                                                    _firstNameController.text,
                                                  ) ==
                                                  null &&
                                              MyValidationClass.validateName(
                                                    _lastNameController.text,
                                                  ) ==
                                                  null &&
                                              MyValidationClass.validateEmail(
                                                    _emailController.text,
                                                  ) ==
                                                  null &&
                                              MyValidationClass.validateCNIC(
                                                    _cnicController.text,
                                                  ) ==
                                                  null &&
                                              MyValidationClass.validatePassword(
                                                    _passwordController.text,
                                                  ) ==
                                                  null &&
                                              signupProvider.isChecked ==
                                                  true) {
                                            // First check if CNIC is verified
                                            final isVerified =
                                                await signupProvider.checkUser(
                                                  _cnicController.text,
                                                  builderContext,
                                                );

                                            if (isVerified) {
                                              // Prepare values for MobilePageNew
                                              values = {
                                                'fullname':
                                                    "${_firstNameController.text} ${_lastNameController.text}",
                                                'emailAddress':
                                                    _emailController.text,
                                                'cnic': _cnicController.text,
                                                'password':
                                                    _passwordController.text,
                                                'Category': "PAYMIR",
                                              };

                                              // Navigate to mobile page for mobile number collection
                                              // Registration will happen after mobile verification
                                              Navigator.push(
                                                builderContext,
                                                MaterialPageRoute(
                                                  builder:
                                                      (context) =>
                                                          MobilePageNew(values),
                                                ),
                                              );
                                            }
                                          }
                                        }
                                        : null,
                                text: 'Sign Up',
                                isLoading: signupProvider.isLoading,
                                isEnabled: signupProvider.isChecked,
                              );
                            } catch (e) {
                              // Provider not found - use local state as fallback
                              return CustomButton(
                                onPressed:
                                    _isChecked
                                        ? () async {
                                          _submit();

                                          // Validate all fields
                                          if (MyValidationClass.validateName(
                                                    _firstNameController.text,
                                                  ) ==
                                                  null &&
                                              MyValidationClass.validateName(
                                                    _lastNameController.text,
                                                  ) ==
                                                  null &&
                                              MyValidationClass.validateEmail(
                                                    _emailController.text,
                                                  ) ==
                                                  null &&
                                              MyValidationClass.validateCNIC(
                                                    _cnicController.text,
                                                  ) ==
                                                  null &&
                                              MyValidationClass.validatePassword(
                                                    _passwordController.text,
                                                  ) ==
                                                  null &&
                                              _isChecked == true) {
                                            // Without provider, we can't check user
                                            // Just navigate to mobile page
                                            values = {
                                              'fullname':
                                                  "${_firstNameController.text} ${_lastNameController.text}",
                                              'emailAddress':
                                                  _emailController.text,
                                              'cnic': _cnicController.text,
                                              'password':
                                                  _passwordController.text,
                                              'Category': "PAYMIR",
                                            };

                                            Navigator.push(
                                              builderContext,
                                              MaterialPageRoute(
                                                builder:
                                                    (context) =>
                                                        MobilePageNew(values),
                                              ),
                                            );
                                          }
                                        }
                                        : null,
                                text: 'Sign Up',
                                isLoading: false,
                                isEnabled: _isChecked,
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
                          height: Constants.getVerticalGapAboveLastLine(
                            context,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText.body(
                              text: "Already Registered? ",
                              context: context,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const LoginPageNew(),
                                  ),
                                );
                              },
                              child: CustomText.link(
                                text: "Sign In",
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
