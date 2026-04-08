// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paymir_new_android/util/theme/app_colors.dart';

import '../util/Mediaquery_Constant.dart';
import 'login/login_screen.dart';

class SuccessfullyPasswordChangedPageNew extends StatefulWidget {
  const SuccessfullyPasswordChangedPageNew({super.key});

  @override
  _SuccessfullyPasswordChangedPageNewState createState() =>
      _SuccessfullyPasswordChangedPageNewState();
}

class _SuccessfullyPasswordChangedPageNewState
    extends State<SuccessfullyPasswordChangedPageNew> {
  TextEditingController textEditingController = TextEditingController();
  String currentText = "";

  String cnicString = "";

  @override
  void initState() {
    super.initState();
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
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: MediaQueryConstant.getBackArrowLeftPadding(
                          context,
                        ),
                        top: MediaQueryConstant.getBackArrowTopPadding(context),
                        bottom: MediaQueryConstant.getBackArrowBottomPadding(
                          context,
                        ),
                      ),

                      child: IconButton(
                        icon: SvgPicture.asset("assets/images/back_arrow.svg"),
                        onPressed:
                            () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const LoginScreen(),
                              ),
                            ),
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top:
                            MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
                              context,
                            ),
                      ),

                      child: SizedBox(
                        height: MediaQueryConstant.getButtonHeight(context) * 5,
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(
                          "assets/images/successfully_registered.gif",
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top:
                            MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
                              context,
                            ) *
                            80,
                      ),
                      child: Text(
                        "Success!",
                        style: TextStyle(
                          color: const Color(
                            0xff03110A,
                          ), //AppColors.primaryColor(),
                          fontFamily: 'Visby',
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQueryConstant.getMainFontSize(context),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height:
                      MediaQueryConstant.getVerticalGapBetweenMainAndSmallFont(
                        context,
                      ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: Text(
                        'You have successfully changed\n              the password',
                        style: TextStyle(
                          color: AppColors.secondaryColor(),
                          fontFamily: 'Visby',
                          fontWeight: FontWeight.normal,
                          fontSize: MediaQueryConstant.getSmallFontSize(
                            context,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height:
                      MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
                        context,
                      ) *
                      60,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal:
                        MediaQueryConstant.getSymmetricHorizontalPadding(
                          context,
                        ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.1,
                        bottom: MediaQuery.of(context).size.height * 0.02,
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: MediaQueryConstant.getButtonHeight(context),

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                MediaQueryConstant.getButtonRadius(context),
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

                          child: Text(
                            'Done',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQueryConstant.getButtonFont(
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
                ),

                // SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, String strResponse) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        if (strResponse.contains("successfully")) {
          Navigator.of(context, rootNavigator: true).pop();
          //Navigator.push(context, MaterialPageRoute(builder: (_)=>VerificationCodePage(cnicString)));
        } else {
          Navigator.of(context, rootNavigator: true).pop();
        }
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

  String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'Invalid email address!';
    } else {
      return null;
    }
  }

  String? validateName(String? value) {
    String pattern = r"^([a-zA-Z]{3})+$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'Invalid Name!';
    } else {
      return null;
    }
  }

  String? validatePassword(String? value) {
    if (value!.length < 8) {
      return 'Password must be at least 8 characters!';
    } else {
      return null;
    }
  }
}
