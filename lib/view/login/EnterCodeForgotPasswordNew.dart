import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paymir_new_android/core/theme/app_colors.dart';

import '../../util/Constants.dart';
import '../../util/MyValidation.dart';
import '../NewPasswordNew.dart';
import 'ForgotPasswordPageNew.dart';

class EnterCodeNew extends StatefulWidget {
  final String CNICString;
  final String verificationCodeString;
  const EnterCodeNew(this.CNICString, this.verificationCodeString, {super.key});
  @override
  _EnterCodeNewState createState() =>
      _EnterCodeNewState(CNICString, verificationCodeString);
}

class _EnterCodeNewState extends State<EnterCodeNew> {
  String CNICString;
  String verificationCodeString;
  _EnterCodeNewState(this.CNICString, this.verificationCodeString);
  final txtCodeController = TextEditingController();
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
                          'Enter the Code',
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
                          'The code was sent to your associated mobile number!',
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
                        SizedBox(
                          height: Constants.getTextFormFieldHeight(context),
                          child: TextFormField(
                            textAlign: TextAlign.start,
                            controller: txtCodeController,
                            maxLength: 4,
                            keyboardType: TextInputType.number,
                            validator:
                                (value) =>
                                    MyValidationClass.validateFourDigitsCode(
                                      value,
                                    ),
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                fontSize: Constants.getTextformfieldHintFont(
                                  context,
                                ),
                                color: AppColors.secondaryColor(),
                                fontFamily: 'Visby',
                                fontWeight: FontWeight.normal,
                              ), //hint text style
                              hintText: 'Enter the code',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    Constants.getTextformfieldBorderRadius(
                                      context,
                                    ),
                                  ),
                                ),
                              ),
                              //  counterText: '',
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
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ForgotPasswordNew(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              top:
                                  Constants.getVerticalGapBetweenTwoTextformfields(
                                    context,
                                  ) *
                                  20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "I didn't receive the code!",
                                  style: TextStyle(
                                    fontSize:
                                        Constants.getTextformfieldHintFont(
                                          context,
                                        ),
                                    color: const Color(
                                      0xff7472DE,
                                    ), //AppColors.secondaryColor(),
                                    fontFamily: 'Visby',
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height:
                              Constants.getVerticalGapBetweenTwoTextformfields(
                                context,
                              ) *
                              30,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.4,
                            bottom: MediaQuery.of(context).size.height * 0.02,
                          ),
                          child: TextButton(
                            onPressed: () {
                              _submit();
                              if (MyValidationClass.validateFourDigitsCode(
                                    txtCodeController.text,
                                  ) ==
                                  null) {
                                if (txtCodeController.text ==
                                    verificationCodeString) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) => NewPasswordNew(CNICString),
                                    ),
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            20.0,
                                          ),
                                        ),
                                        title: Row(
                                          children: [
                                            Text("Incorrect code"),
                                            Spacer(),
                                            Icon(
                                              Icons.error_outline,
                                              color: Colors.red,
                                            ),
                                          ],
                                        ),
                                        content: const Text(
                                          "Please enter the correct verification code.",
                                        ),
                                        actions: [
                                          TextButton(
                                            child: const Text("OK"),
                                            onPressed: () {
                                              txtCodeController.clear();
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
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
