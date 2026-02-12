import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paymir_new_android/core/theme/app_colors.dart';

import '../util/Constants.dart';
import 'login/login_screen.dart';

class MobileVerifiedPageNew extends StatefulWidget {
  const MobileVerifiedPageNew({super.key});

  @override
  _MobileVerifiedPageNewState createState() => _MobileVerifiedPageNewState();
}

class _MobileVerifiedPageNewState extends State<MobileVerifiedPageNew> {
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
                        left: Constants.getBackArrowLeftPadding(context),
                        top: Constants.getBackArrowTopPadding(context),
                        bottom: Constants.getBackArrowBottomPadding(context),
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
                        top: Constants.getVerticalGapBetweenTwoTextformfields(
                          context,
                        ),
                      ),

                      child: SizedBox(
                        height: Constants.getButtonHeight(context) * 5,
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(
                          "assets/images/successfully_registered1.gif",
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
                            Constants.getVerticalGapBetweenTwoTextformfields(
                              context,
                            ) *
                            80,
                      ),
                      child: Text(
                        "You're verified!",
                        style: TextStyle(
                          color: const Color(
                            0xff03110A,
                          ), //AppColors.primaryColor(),
                          fontFamily: 'Visby',
                          fontWeight: FontWeight.bold,
                          fontSize: Constants.getMainFontSize(context),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: Constants.getVerticalGapBetweenMainAndSmallFont(
                    context,
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: Text(
                        'You have successfully been verified\n                   and registered',
                        style: TextStyle(
                          color: AppColors.secondaryColor(),
                          fontFamily: 'Visby',
                          fontWeight: FontWeight.normal,
                          fontSize: Constants.getSmallFontSize(context),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height:
                      Constants.getVerticalGapBetweenTwoTextformfields(
                        context,
                      ) *
                      60,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Constants.getSymmetricHorizontalPadding(
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

                          child: Text(
                            'Done',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Constants.getButtonFont(context),
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
