import 'dart:convert';
import 'dart:developer';

import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../util/AlertDialogueClass.dart';
import '../../util/Constants.dart';
import '../../util/MyValidation.dart';
import '../../util/NetworkHelperClass.dart';
import '../../util/SecureStorage.dart';
import '../HomePageNew.dart';
import '../signup/RegisterPageNew.dart';
import 'ForgotPasswordPageNew.dart';

class LoginPageNew extends StatefulWidget {
  const LoginPageNew({super.key});

  @override
  _LoginPageNewState createState() => _LoginPageNewState();
}

class _LoginPageNewState extends State<LoginPageNew> {
  late bool _passwordVisible;
  var _isLoading = false;

  final TextEditingController _CNICController = MaskedTextController(
    mask: '00000-0000000-0',
  );
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String cnicString = "";
  void _submit() {
    if (_formKey.currentState!.validate()) {
      // TODO SAVE DATA
    }
  }

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
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
                        Text(
                          'Sign In',
                          style: TextStyle(
                            color: Constants.primaryColor(),
                            fontFamily: 'Visby',
                            fontWeight: FontWeight.bold,
                            fontSize: Constants.getMainFontSize(context),
                          ),
                        ),

                        SizedBox(
                          height:
                              Constants.getVerticalGapBetweenMainAndSmallFont(
                                context,
                              ),
                        ),

                        Text(
                          'You have been missed',
                          style: TextStyle(
                            color: Constants.secondaryColor(),
                            fontFamily: 'Visby',
                            fontWeight: FontWeight.w500,
                            fontSize: Constants.getSmallFontSize(context),
                          ),
                        ),

                        SizedBox(
                          height:
                              Constants.getVerticalGapBetweenSmallfontAndTextfield(
                                context,
                              ),
                        ),

                        SizedBox(
                          height: Constants.getTextFormFieldHeight(context),
                          child: TextFormField(
                            textAlign: TextAlign.start,
                            controller: _CNICController,
                            keyboardType: TextInputType.number,
                            validator:
                                (value) =>
                                    MyValidationClass.validateCNIC(value),
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                fontSize: Constants.getTextformfieldHintFont(
                                  context,
                                ),
                                color: Constants.secondaryColor(),
                                fontFamily: 'Visby',
                                fontWeight: FontWeight.normal,
                              ), //hint text style
                              hintText: 'CNIC',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    Constants.getTextformfieldBorderRadius(
                                      context,
                                    ),
                                  ),
                                ),
                              ),
                              counterText: '',
                              contentPadding: EdgeInsets.only(
                                top: Constants.getTextformfieldContentPadding(
                                  context,
                                ),
                                left: Constants.getTextformfieldContentPadding(
                                  context,
                                ),
                                bottom:
                                    Constants.getTextformfieldContentPadding(
                                      context,
                                    ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height:
                              Constants.getVerticalGapBetweenTwoTextformfields(
                                context,
                              ),
                        ),

                        SizedBox(
                          height: Constants.getTextFormFieldHeight(context),
                          child: TextFormField(
                            textAlign: TextAlign.start,
                            controller: _passwordController,
                            validator:
                                (value) =>
                                    MyValidationClass.validateEmailPassword(
                                      value,
                                    ),
                            obscureText: !_passwordVisible,

                            // Here is key idea
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,

                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                              hintStyle: TextStyle(
                                fontSize: Constants.getTextformfieldHintFont(
                                  context,
                                ),
                                color: Constants.secondaryColor(),
                                fontFamily: 'Visby',
                                fontWeight: FontWeight.normal,
                              ), //hint text style
                              hintText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    Constants.getTextformfieldBorderRadius(
                                      context,
                                    ),
                                  ),
                                ),
                              ),
                              counterText: '',
                              contentPadding: EdgeInsets.only(
                                top: Constants.getTextformfieldContentPadding(
                                  context,
                                ),
                                left: Constants.getTextformfieldContentPadding(
                                  context,
                                ),
                                bottom:
                                    Constants.getTextformfieldContentPadding(
                                      context,
                                    ),
                              ),
                            ),
                          ),
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
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: Constants.forgotPasswordColor(),
                                  fontFamily: 'Visby',
                                  fontWeight: FontWeight.normal,
                                  fontSize: Constants.getForgotPasswordFontSize(
                                    context,
                                  ),
                                ),
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

                        TextButton(
                          onPressed: () async {
                            _submit();

                            // Call your function here

                            if (await NetworkHelper.checkInternetConnection()) {
                              if (MyValidationClass.validateCNIC(
                                        _CNICController.text,
                                      ) ==
                                      null &&
                                  MyValidationClass.validatePassword(
                                        _passwordController.text,
                                      ) ==
                                      null) {
                                setState(() {
                                  _isLoading = true;
                                });
                                loginUser();
                              }
                            } else {
                              ShowAlertDialogueClass.showAlertDialogue(
                                context: context,
                                title: "No Internet",
                                message: "Check your internet connection!",
                                buttonText: "OK",
                                iconData: Icons.error,
                              );
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: Constants.getButtonHeight(context),

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  Constants.getButtonRadius(context),
                                ),
                              ),

                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Constants.gradientColor1(),
                                  Constants.gradientColor2(),
                                ],
                              ),
                            ),

                            child:
                                _isLoading
                                    ? const CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    )
                                    : Text(
                                      'Sign In',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: Constants.getButtonFont(
                                          context,
                                        ),
                                        fontFamily: 'Visby',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                          ),
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
                              child: Text(
                                'OR',
                                style: TextStyle(
                                  color: Constants.secondaryColor(),
                                  fontSize: Constants.getTextformfieldHintFont(
                                    context,
                                  ),
                                  fontFamily: 'Visby',
                                  fontWeight: FontWeight.normal,
                                ),
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
                                child: Text(
                                  'Login via Gov e Identity',
                                  style: TextStyle(
                                    fontFamily: 'Visbyy',
                                    fontWeight: FontWeight.w600,
                                    fontSize:
                                        Constants.getTextformfieldHintFont(
                                          context,
                                        ),
                                  ),
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
                            Text(
                              "Not Registered? ",
                              style: TextStyle(
                                color: Constants.secondaryColor(),
                                fontFamily: 'Visby',
                                fontWeight: FontWeight.normal,
                                fontSize: Constants.getTextformfieldHintFont(
                                  context,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const RegisterPageNew(),
                                  ),
                                );
                              },

                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: const Color(0xff21BF73),
                                  fontFamily: 'Visby',
                                  fontWeight: FontWeight.normal,
                                  fontSize: Constants.getTextformfieldHintFont(
                                    context,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Container(
                        //       width: 150,
                        //       height: 5,
                        //       decoration: BoxDecoration(
                        //         color: Colors.black,
                        //         borderRadius: BorderRadius.circular(20),
                        //       ),
                        //     ),
                        //   ],
                        // ),
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

  Future<void> loginUser() async {
    log('logging user ***');
    cnicString = _CNICController.text;
    if (kDebugMode) {
      log("value of cnicString: $cnicString");
    }

    var data = {
      "grant_type": "password",
      "username": _CNICController.text,
      "password": _passwordController.text,
      "Category": "PAYMIR",
    };

    try {
      final responseBody = await NetworkHelper.signIn(data);
      var decodedResponseBody = json.decode(responseBody!);

      if (kDebugMode) {
        log('****************************');
        log(responseBody);
      }

      const int expiresIn = 86399;
      final DateTime now = DateTime.now();
      final DateTime expirationDate = now.add(
        const Duration(seconds: expiresIn),
      );

      if (kDebugMode) {
        log("Expiry Date: $expirationDate");
      }

      if (expirationDate.isBefore(DateTime.now())) {
        if (kDebugMode) {
          log('Token has expired.');
        }
      } else {
        if (kDebugMode) {
          log('Token is still valid.');
        }
      }

      setState(() {
        _isLoading = false;
      });

      if (responseBody.contains("access_token")) {
        SecureStorage secureStorage = SecureStorage();

        // Store the access token first
        secureStorage
            .storeToken(
              decodedResponseBody["access_token"],
              expirationDate,
              cnicString,
            )
            .then((_) {
              // Now navigate to the new page
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomePageNew()),
              );
            })
            .catchError((error) {
              // Handle any errors during storage
              if (kDebugMode) {
                log("Error storing token: $error");
              }
            });
      } else {
        if (decodedResponseBody["error_description"].toString().contains(
          "Unverified",
        )) {
          ShowAlertDialogueClass.showAlertDialogCodeVerificationPage(
            context: context,
            title: "Unverified CNIC",
            message:
                "A verification code has been sent to the associated mobile number. Please verify!",
            buttonText: "Okay",
            values: {
              "code": "1234",
              "cnic": _CNICController.text,
              "page": "from LoginPage",
            },
            iconData: const Icon(Icons.verified_user),
          );
        } else {
          ShowAlertDialogueClass.showAlertDialogue(
            context: context,
            title: "Error!",
            message: decodedResponseBody["error_description"],
            buttonText: "Okay!",
            iconData: Icons.warning_sharp,
          );
        }
      }
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            title: const Row(
              children: [
                Icon(Icons.error, color: Colors.red),
                SizedBox(width: 10),
                Text("Error"),
              ],
            ),
            content: Text(e.toString()),
            actions: [
              TextButton(
                child: const Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    _isLoading = false;
                  });
                },
              ),
            ],
          );
        },
      );
    }
  }
}
