import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paymir_new_android/core/theme/app_colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../util/AlertDialogueClass.dart';
import '../util/Constants.dart';
import '../util/NetworkHelperClass.dart';
import '../view/MobileVerifiedPageNew.dart';

class MobileVerificationPageNew extends StatefulWidget {
  Map<String, dynamic> values; //if you have multiple values add here
  MobileVerificationPageNew(this.values);

  @override
  _MobileVerificationPageNewState createState() =>
      _MobileVerificationPageNewState(this.values);
}

class _MobileVerificationPageNewState extends State<MobileVerificationPageNew> {
  Map<String, dynamic> values; ////if you have multiple values add here

  _MobileVerificationPageNewState(this.values);

  TextEditingController textEditingController = TextEditingController();
  String currentText = "";
  var _isCompleted = false;
  late bool _passwordVisible;
  var _isChecked = false;
  var _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  //String cnicString ="";
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
        Navigator.pop(context);
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
                        onPressed: () => Navigator.pop(context),
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
                          'Enter verification code',
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
                          'Enter 4-digits code that was just sent to your email',
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

                        Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.09,
                          ),
                          child: Center(
                            child: Container(
                              color: Color(0xffFAFCFF),
                              child: PinCodeTextField(
                                length: 4,
                                obscureText: false,
                                keyboardType: TextInputType.number,
                                animationType: AnimationType.fade,
                                pinTheme: PinTheme(
                                  activeColor: Colors.green,
                                  inactiveColor: Colors.grey,
                                  shape: PinCodeFieldShape.box,
                                  errorBorderColor: Colors.lightGreenAccent,
                                  borderRadius: BorderRadius.circular(15),
                                  fieldHeight:
                                      MediaQuery.of(context).size.height *
                                      0.065,
                                  fieldWidth:
                                      MediaQuery.of(context).size.height *
                                      0.065,
                                  activeFillColor: Colors.white,
                                ),
                                animationDuration: const Duration(
                                  milliseconds: 300,
                                ),
                                backgroundColor: Color(0xffFAFCFF),
                                enableActiveFill: false,
                                controller: textEditingController,
                                onCompleted: (v) {
                                  setState(() {
                                    _isCompleted = true;
                                  });
                                  debugPrint("Completed");
                                },
                                onChanged: (value) {
                                  debugPrint(value);
                                  setState(() {
                                    currentText = value;
                                    if (currentText.length < 4) {
                                      _isCompleted = false;
                                    }
                                  });
                                },
                                beforeTextPaste: (text) {
                                  return true;
                                },
                                appContext: context,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.4,
                        ),
                        TextButton(
                          onPressed:
                              _isCompleted
                                  ? () async {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    if (kDebugMode) {
                                      print("value of otp: " + values['otp']);
                                    }
                                    if (currentText.toString() ==
                                        values['otp'].toString()) {
                                      // Do something if the OTP is correct
                                      if (await NetworkHelper.checkInternetConnection()) {
                                        verifyCode();
                                      } else {
                                        ShowAlertDialogueClass.showAlertDialogue(
                                          context: context,
                                          title: "No Internet",
                                          message:
                                              "Check your internet connection!",
                                          buttonText: "OK",
                                          iconData: Icons.error,
                                        );
                                      }
                                    } else {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      // Do something if the OTP is incorrect
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            title: Row(
                                              children: [
                                                Text("Incorrect code"),
                                                Spacer(),
                                                Icon(
                                                  Icons.error,
                                                  color: Colors.red,
                                                ),
                                              ],
                                            ),
                                            content: Text(
                                              "The code you entered is not correct. Please try again!",
                                            ),
                                            actions: [
                                              TextButton(
                                                child: Text("OK"),
                                                onPressed: () {
                                                  setState(() {
                                                    currentText = "";
                                                    _isLoading = false;
                                                  });
                                                  textEditingController.clear();
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }

                                    //Navigator.of(context, rootNavigator: true).pop();
                                  }
                                  : null,
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: Constants.getButtonHeight(context),
                            decoration:
                                _isCompleted
                                    ? BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          Constants.getButtonRadius(context),
                                        ),
                                      ),
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Color(0xff08A1A7),
                                          Color(0xff4B2A7A),
                                        ],
                                      ),
                                    )
                                    : BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          Constants.getButtonRadius(context),
                                        ),
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
                                      'Verify',
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

  Future<bool> verifyCode() async {
    var data;
    String endPoint = "";

    data = {
      "CNIC": values['cnic'], // "Password": values['password'],
      "MobileNo": values['mobileNo'],
      "EmailAddress": values['emailAddress'],
    };
    endPoint = "api/user/verifyUser";

    if (kDebugMode) {
      print("values object: $values");
    }

    try {
      final responseBody = await NetworkHelper.verifyUser(data, endPoint);

      var decoded = json.decode(responseBody.toString());

      setState(() {
        _isLoading = false;
      });

      if (kDebugMode) {
        print(
          "server response body while creating account: " +
              responseBody.toString(),
        );
      }

      if (decoded["statusCode"] == "200") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => MobileVerifiedPageNew()),
        );
      } else {
        showAlertDialog(context, decoded["responseMessage"]);
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            title: const Text("Error"),
            content: Row(
              children: [
                Icon(Icons.error_outline_rounded, color: Colors.red),
                SizedBox(width: 10),
                Text(e.toString()),
              ],
            ),
            actions: [
              TextButton(
                child: const Text("Close"),
                onPressed: () {
                  setState(() {
                    _isLoading = false;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    return false;
  }

  showAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: Row(
            children: [
              Text("Error"),
              Spacer(),
              Icon(Icons.error_outline_rounded, color: Colors.red),
            ],
          ),
          content: Row(children: [Text(message)]),
          actions: [
            TextButton(
              child: const Text("Close"),
              onPressed: () {
                setState(() {
                  _isLoading = false;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
