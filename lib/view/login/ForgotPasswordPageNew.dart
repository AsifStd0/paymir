import 'dart:convert';
import 'dart:io';

import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import '../../util/Constants.dart';
import '../../util/MyValidation.dart';
import '../../util/NetworkHelperClass.dart';
import '../EnterCodeForgotPasswordNew.dart';

class ForgotPasswordNew extends StatefulWidget {
  @override
  _ForgotPasswordNewState createState() => _ForgotPasswordNewState();
}

class _ForgotPasswordNewState extends State<ForgotPasswordNew> {
  final txtUsernameController = MaskedTextController(mask: '00000-0000000-0');

  bool _isLoading = false;
  String verificationCode = "";

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
                          'Reset Password',
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
                          'Enter your CNIC. The verification code will be sent to the associated mobile number!',
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
                            controller: txtUsernameController,
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
                              ) *
                              160,
                        ),

                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.3,
                              bottom: MediaQuery.of(context).size.height * 0.02,
                            ),
                            child: TextButton(
                              onPressed: () {
                                _submit();
                                if (MyValidationClass.validateCNIC(
                                      txtUsernameController.text,
                                    ) ==
                                    null) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  sendCode();
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
                                        ? CircularProgressIndicator(
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

  Future<bool> sendCode() async {
    var data = {"cnic": txtUsernameController.text};

    try {
      final responseBody = await NetworkHelper.verifyUserforResettingPassword(
        data,
      );

      var decoded = json.decode(responseBody!);

      if (kDebugMode) {
        print("Response from the server: " + responseBody.toString());
      }

      setState(() {
        _isLoading = false;
      });

      if (decoded["statusCode"] == "200") {
        verificationCode = decoded["otp"];

        showAlertDialog(
          context,
          "Verified",
          "Verification code sent to your email. Please verify yourself in the next screen!",
        );
      } else {
        showAlertDialog(context, "Not found", decoded["responseMessage"]);
      }
    } catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(
              "Failed host lookup. Please check your internet connection.",
            ),
            actions: [
              TextButton(
                child: Text("Close"),
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

  showAlertDialog(BuildContext context, String title, String strResponse) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        if (strResponse.contains("code")) {
          Navigator.of(context, rootNavigator: true).pop();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (_) => EnterCodeNew(
                    txtUsernameController.text,
                    verificationCode,
                  ),
            ),
          );
        } else {
          Navigator.of(context, rootNavigator: true).pop();
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      title: Row(
        children: [
          Text(title),
          Spacer(),
          strResponse.contains("code")
              ? Icon(Icons.offline_pin_rounded, color: Colors.green)
              : Icon(Icons.error_outline, color: Colors.red),
        ],
      ),
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
