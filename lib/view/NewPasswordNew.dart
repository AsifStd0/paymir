import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paymir_new_android/util/app_colors.dart';

import '../util/Constants.dart';
import '../util/MyValidation.dart';
import '../util/NetworkHelperClass.dart';
import 'SuccessfullyChangedPasswordNew.dart';
import 'login/login_screen.dart';

class NewPasswordNew extends StatefulWidget {
  final String CNICString;
  const NewPasswordNew(this.CNICString, {super.key});

  @override
  _NewPasswordNewState createState() => _NewPasswordNewState(CNICString);
}

class _NewPasswordNewState extends State<NewPasswordNew> {
  String CNICString;
  bool _passwordVisible1 = false;
  bool _passwordVisible2 = false;

  _NewPasswordNewState(this.CNICString);

  final txtPasswordController = TextEditingController();
  final txtRePasswordController = TextEditingController();

  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();
  void _submit() {
    if (_formKey.currentState!.validate()) {
      // TODO SAVE DATA
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
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
                          Navigator.pop(context);
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
                          'Enter new password',
                          style: TextStyle(
                            color: AppColors.primaryColor(),
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
                          'Please provide a strong password to reset it!',
                          style: TextStyle(
                            color: AppColors.secondaryColor(),
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

                        Text(
                          "- Please enter a password that is\n\n\t  - At least 8 characters long\n\t  - Must contain at least\n\t\t     - One uppercase letter\n\t\t     - One lowercase letter\n\t\t     - One digit\n\t\t     - One special character\n\t  - The password must not contain spaces",
                          style: TextStyle(
                            color: AppColors.secondaryColor(),
                            fontFamily: 'Visby',
                            fontWeight: FontWeight.w300,
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
                            controller: txtPasswordController,
                            validator:
                                (value) =>
                                    MyValidationClass.validatePassword(value),
                            obscureText: !_passwordVisible1,

                            // Here is key idea
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible1
                                      ? Icons.visibility
                                      : Icons.visibility_off,

                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toggle the state of passwordVisible variable
                                  setState(() {
                                    _passwordVisible1 = !_passwordVisible1;
                                  });
                                },
                              ),
                              hintStyle: TextStyle(
                                fontSize: Constants.getTextformfieldHintFont(
                                  context,
                                ),
                                color: AppColors.secondaryColor(),
                                fontFamily: 'Visby',
                                fontWeight: FontWeight.normal,
                              ), //hint text style
                              hintText: 'Enter password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    Constants.getTextformfieldBorderRadius(
                                      context,
                                    ),
                                  ),
                                ),
                              ),
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
                          height: Constants.getTextformfieldHeight(context),
                          child: TextFormField(
                            textAlign: TextAlign.start,
                            controller: txtRePasswordController,
                            validator:
                                (value) =>
                                    MyValidationClass.validatePassword(value),
                            obscureText: !_passwordVisible2,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible2
                                      ? Icons.visibility
                                      : Icons.visibility_off,

                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible2 = !_passwordVisible2;
                                  });
                                },
                              ),
                              hintStyle: TextStyle(
                                fontSize: Constants.getTextformfieldHintFont(
                                  context,
                                ),
                                color: AppColors.secondaryColor(),
                                fontFamily: 'Visby',
                                fontWeight: FontWeight.normal,
                              ), //hint text style
                              hintText: 'Confirm password',
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
                              ) *
                              90,
                        ),

                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.1,
                              bottom: MediaQuery.of(context).size.height * 0.02,
                            ),
                            child: TextButton(
                              onPressed: () {
                                _submit();
                                if (MyValidationClass.validatePassword(
                                          txtPasswordController.text,
                                        ) ==
                                        null &&
                                    MyValidationClass.validatePassword(
                                          txtRePasswordController.text,
                                        ) ==
                                        null) {
                                  if (txtPasswordController.text ==
                                      txtRePasswordController.text) {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    resetPassword();
                                  } else {
                                    {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Row(
                                              children: [
                                                Icon(Icons.error_outline),
                                                SizedBox(width: 5),
                                                Text('Error'),
                                              ],
                                            ),
                                            content: const Text(
                                              'Passwords do not match!',
                                            ),
                                            actions: [
                                              TextButton(
                                                child: const Text('OK'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  }
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
                                      AppColors.gradientColor1(),
                                      AppColors.gradientColor2(),
                                    ],
                                  ),
                                ),
                                child:
                                    _isLoading
                                        ? const CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                Colors.white,
                                              ),
                                        )
                                        : Text(
                                          'Continue',
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
                          ),
                        ),
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

  Future<bool> resetPassword() async {
    var data = {"CNIC": CNICString, "Password": txtPasswordController.text};

    try {
      final responseBody = await NetworkHelper.resetPassword(data);

      setState(() {
        _isLoading = false;
      });

      var decoded = json.decode(responseBody!);

      //print(responseBody.toString());

      if (decoded["responseStatus"] == true) {
        // storeToken(decoded["access_token"]);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SuccessfullyPasswordChangedPageNew(),
          ),
        );
        //showAlertDialog(context, "Password updated successfully!");
      } else {
        showAlertDialog(context, "Password not updated!");
      }
    } catch (e) {
      // print(e);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text("Server is down and cannot be accessed!"),
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
    return false;
  }

  String? validateUserName(String? value) {
    if (value!.length < 15) {
      return 'Please Enter Correct CNIC';
    } else {
      return null;
    }
  }

  showAlertDialog(BuildContext context, String strResponse) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Response"),
      content: Text(strResponse),
      actions: [okButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
