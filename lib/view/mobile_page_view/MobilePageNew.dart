import 'dart:convert';

import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../util/AlertDialogueClass.dart';
import '../../util/Constants.dart';
import '../../util/MyValidation.dart';
import '../../util/NetworkHelperClass.dart';

class MobilePageNew extends StatefulWidget {
  final dynamic values; //if you have multiple values add here
  const MobilePageNew(this.values);

  @override
  _MobilePageNewState createState() => _MobilePageNewState(values);
}

class _MobilePageNewState extends State<MobilePageNew> {
  dynamic values;

  _MobilePageNewState(this.values);

  bool _isLoading = false;

  final TextEditingController _mobileNumberController = MaskedTextController(
    mask: '0000000000',
  );

  final _formKey = GlobalKey<FormState>();

  String cnicString = "";
  String phoneNumber = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: //MediaQuery.of(context).size.width * 0.2,
                        IconButton(
                      icon: SvgPicture.asset("assets/images/back_arrow.svg"),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Constants.getSymmetricHorizontalPadding(context),
                ),

                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Set up 2-step verification',
                        style: TextStyle(
                          color: Constants.primaryColor(),
                          fontFamily: 'Visby',
                          fontWeight: FontWeight.bold,
                          fontSize: Constants.getMainFontSize(context),
                        ),
                      ),

                      SizedBox(
                        height: Constants.getVerticalGapBetweenMainAndSmallFont(
                          context,
                        ),
                      ),

                      Text(
                        'Enter your phone number so that we can send you verification code',
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
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            Constants.getTextformfieldBorderRadius(context),
                          ),
                          border: Border.all(),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.05,
                          ),
                          child: IntlPhoneField(
                            decoration: InputDecoration(
                              hintText: '3123456789',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            autovalidateMode: AutovalidateMode.disabled,
                            showCountryFlag: false,

                            showDropdownIcon: true,
                            controller: _mobileNumberController,
                            validator:
                                (value) => MyValidationClass.validateMobile(
                                  value as String?,
                                ),
                            dropdownIconPosition: IconPosition.trailing,
                            dropdownTextStyle: TextStyle(
                              fontSize:
                                  Constants.getGeneralFontSize(context) * 0.025,
                              color: const Color(0xff03110A),
                              fontFamily: 'Visby',
                              fontWeight: FontWeight.w500,
                            ),
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              fontSize:
                                  Constants.getGeneralFontSize(context) * 0.025,
                              color: const Color(0xff03110A),
                              fontFamily: 'Visby',
                              fontWeight: FontWeight.w500,
                            ),
                            initialCountryCode: 'PK',
                            onChanged: (phone) {
                              if (kDebugMode) {
                                print(phone.completeNumber);
                              }
                              setState(() {
                                phoneNumber = phone.completeNumber;
                              });
                            },
                          ),
                        ),
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.41,
                      ),

                      TextButton(
                        onPressed: () async {
                          if (phoneNumber.isNotEmpty &&
                              RegExp(
                                r'^\+923[0-9]{9}$',
                              ).hasMatch(phoneNumber)) {
                            setState(() {});
                            values['mobileNo'] = phoneNumber;
                            if (kDebugMode) {
                              print(values.toString());
                            }
                            setState(() {
                              _isLoading = true;
                            });
                            try {
                              if (await NetworkHelper.checkInternetConnection()) {
                                registerUser();
                              } else {
                                setState(() {
                                  _isLoading = false;
                                });
                                ShowAlertDialogueClass.showAlertDialogue(
                                  context: context,
                                  title: "No Internet",
                                  message: "Check your internet connection!",
                                  buttonText: "OK",
                                  iconData: Icons.error,
                                );
                              }
                            } catch (error) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Row(
                                      children: [
                                        Icon(
                                          Icons.error_outline_rounded,
                                          color: Colors.red,
                                        ),
                                        SizedBox(width: 8),
                                        Text('Error'),
                                      ],
                                    ),
                                    content: Text(error.toString()),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    actions: [
                                      TextButton(
                                        child: Text('OK'),
                                        onPressed:
                                            () => Navigator.of(context).pop(),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          } else {
                            setState(() {});
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  title: const Row(
                                    children: [
                                      Icon(Icons.error, color: Colors.red),
                                      SizedBox(width: 8),
                                      Text('Error'),
                                    ],
                                  ),
                                  content: const Text(
                                    'Invalid phone number. Valid format is 3123456789',
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
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Color(0xff08A1A7), Color(0xff4B2A7A)],
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
                                    'Continue',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Visby',
                                      fontSize: Constants.getButtonFont(
                                        context,
                                      ),
                                      fontWeight: FontWeight.bold,
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
    );
  }

  Future<void> registerUser() async {
    var data = values;

    print("data for registration: " + values.toString());

    try {
      final responseBody = await NetworkHelper.signUp(data);

      var decodedResponseBody = json.decode(responseBody!);

      if (kDebugMode) {
        print("Response Body: $responseBody");
      }

      setState(() {
        _isLoading = false;
      });

      if (decodedResponseBody["responseStatus"] == true) {
        String otp = decodedResponseBody["otp"];
        if (kDebugMode) {
          print("OTP here: $otp");
        }
        values['otp'] = otp;
        if (decodedResponseBody["statusCode"].toString() ==
            "201") //201 is for user Registered successfully
        {
          ShowAlertDialogueClass.showAlertDialogSendtoVerificationPage(
            context: context,
            title: "Response",
            message: decodedResponseBody["responseMessage"].toString(),
            buttonText: "Okay!",
            values: values,
            iconData: Icons.offline_pin_rounded,
          );
        } else if (decodedResponseBody["statusCode"].toString() ==
            "202") //202 is for user Registered but unverified
        {
          ShowAlertDialogueClass.showAlertDialogMobileVerificationPage(
            context: context,
            title: "Response",
            message: decodedResponseBody["responseMessage"].toString(),
            buttonText: "Okay!",
            values: values,
            iconData: Icons.offline_pin_rounded,
          );
        }
      } else {
        ShowAlertDialogueClass.showAlertDialogue(
          context: context,
          title: "Response",
          message: decodedResponseBody["responseMessage"],
          buttonText: "Okay!",
          iconData: Icons.warning_sharp,
        );
      }
    } //try
    catch (error) {
      setState(() {
        _isLoading = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: Row(
              children: [
                Icon(Icons.error_outline, color: Colors.red),
                SizedBox(width: 10.0),
                Text("Error"),
              ],
            ),
            content: Text(error.toString()),
            actions: [
              TextButton(
                child: Text("OK"),
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
