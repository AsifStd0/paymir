import 'dart:convert';

import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paymir_new_android/util/app_colors.dart';

import '../util/AlertDialogueClass.dart';
import '../util/Constants.dart';
import '../util/MyValidation.dart';
import '../util/NetworkHelperClass.dart';
import '../util/SecureStorage.dart';
import 'ProfileUpdateOTPVerificationPageNew.dart';
import 'home_page/home_screen.dart';

class EditProfilePageNew extends StatefulWidget {
  final String strCNIC;
  Map<String, dynamic> cardDataJsonObject = {};

  EditProfilePageNew(this.strCNIC, this.cardDataJsonObject, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EditProfilePageNewState createState() =>
      _EditProfilePageNewState(strCNIC, cardDataJsonObject);
}

class _EditProfilePageNewState extends State<EditProfilePageNew> {
  String strCNIC;
  Map<String, dynamic> cardDataJsonObject = {};

  _EditProfilePageNewState(this.strCNIC, this.cardDataJsonObject);

  late var _isLoading = false;
  late var _isLoading1 = false;

  Map<String, String> values = {};

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileNumberController = MaskedTextController(
    mask: '0000000000',
  );
  final TextEditingController _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // TODO SAVE DATA
    }
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      String fullName = cardDataJsonObject['fullName'].toString();
      List<String> names = fullName.split(' ');
      String firstName = names[0];
      String lastName = names[names.length - 1];

      if (names.length > 2) {
        firstName = names.sublist(0, names.length - 1).join(' ');
      }

      _firstNameController.text = firstName;
      _lastNameController.text = lastName;
      _mobileNumberController.text = cardDataJsonObject['mobileNo']
          .toString()
          .replaceAll('+92', '');
      _emailController.text = cardDataJsonObject['emailAddress'];

      setState(() {
        _isLoading = false;
      });
    });

    fetchSecureStorageData();
    setState(() {
      _isLoading = false;
    });
    Future.delayed(const Duration(milliseconds: 2900), () {
      //loadData();
    });
  }

  //Map<String, dynamic> cardDataJsonObject ={};

  String strToken = "";
  final SecureStorage _secureStorage = SecureStorage();
  Future<void> fetchSecureStorageData() async {
    strToken = await _secureStorage.getToken() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        body:
            _isLoading
                ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.22,
                        height: MediaQuery.of(context).size.width * 0.22,
                        child: CircularProgressIndicator(),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Text(
                        'Loading data...',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Visby',
                        ),
                      ),
                    ],
                  ),
                )
                : SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: Constants.getBackArrowLeftPadding(
                                  context,
                                ),
                                top: Constants.getBackArrowTopPadding(context),
                                bottom: Constants.getBackArrowBottomPadding(
                                  context,
                                ),
                              ),
                              child: IconButton(
                                icon: SvgPicture.asset(
                                  "assets/images/back_arrow.svg",
                                ),
                                onPressed:
                                    () => {
                                      Navigator.pop(context),
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
                                Text(
                                  'Edit Profile',
                                  style: TextStyle(
                                    color: AppColors.primaryColor(),
                                    fontFamily: 'Visby',
                                    fontWeight: FontWeight.bold,
                                    fontSize: Constants.getMainFontSize(
                                      context,
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height:
                                      Constants.getVerticalGapBetweenMainAndSmallFont(
                                        context,
                                      ),
                                ),

                                Text(
                                  'It only takes a minute to edit your profile',
                                  style: TextStyle(
                                    color: AppColors.secondaryColor(),
                                    fontFamily: 'Visby',
                                    fontWeight: FontWeight.w500,
                                    fontSize: Constants.getSmallFontSize(
                                      context,
                                    ),
                                  ),
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
                                      child: SizedBox(
                                        height:
                                            Constants.getTextFormFieldHeight(
                                              context,
                                            ),

                                        child: TextFormField(
                                          // textAlign: TextAlign.start,
                                          controller: _firstNameController,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          maxLength: 15,
                                          validator:
                                              (value) =>
                                                  MyValidationClass.validateFirstName(
                                                    value,
                                                  ),
                                          decoration: InputDecoration(
                                            hintStyle: TextStyle(
                                              fontSize:
                                                  Constants.getTextformfieldHintFont(
                                                    context,
                                                  ),
                                              color: AppColors.secondaryColor(),
                                              fontFamily: 'Visby',
                                              fontWeight: FontWeight.normal,
                                            ),
                                            hintText: 'First Name',
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
                                              top:
                                                  Constants.getTextformfieldContentPadding(
                                                    context,
                                                  ),
                                              left:
                                                  Constants.getTextformfieldContentPadding(
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
                                    ),

                                    SizedBox(
                                      width:
                                          Constants.getHorizontalGapBetweenTwoTextformfields(
                                            context,
                                          ),
                                    ),

                                    Expanded(
                                      child: SizedBox(
                                        height:
                                            Constants.getTextFormFieldHeight(
                                              context,
                                            ),
                                        child: TextFormField(
                                          controller: _lastNameController,
                                          maxLength: 15,

                                          validator:
                                              (value) =>
                                                  MyValidationClass.validateName(
                                                    value,
                                                  ),
                                          textAlign: TextAlign.start,
                                          decoration: InputDecoration(
                                            hintStyle: TextStyle(
                                              fontSize:
                                                  Constants.getTextformfieldHintFont(
                                                    context,
                                                  ),
                                              color: AppColors.secondaryColor(),
                                              fontFamily: 'Visby',
                                              fontWeight: FontWeight.normal,
                                            ), //hint text style
                                            hintText: 'Last Name',
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
                                              top:
                                                  Constants.getTextformfieldContentPadding(
                                                    context,
                                                  ),
                                              left:
                                                  Constants.getTextformfieldContentPadding(
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
                                    ),
                                  ],
                                ),

                                SizedBox(
                                  height:
                                      Constants.getVerticalGapBetweenTwoTextformfields(
                                        context,
                                      ),
                                ),

                                SizedBox(
                                  height: Constants.getTextFormFieldHeight(
                                    context,
                                  ),
                                  child: TextFormField(
                                    textAlign: TextAlign.start,
                                    controller: _mobileNumberController,
                                    validator:
                                        (value) =>
                                            MyValidationClass.validateMobileforEditProfile(
                                              value,
                                            ),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                        fontSize:
                                            Constants.getTextformfieldHintFont(
                                              context,
                                            ),
                                        color: AppColors.secondaryColor(),
                                        fontFamily: 'Visby',
                                        fontWeight: FontWeight.normal,
                                      ), //h//hint text style
                                      hintText: 'Mobile Number',
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
                                        top:
                                            Constants.getTextformfieldContentPadding(
                                              context,
                                            ),
                                        left:
                                            Constants.getTextformfieldContentPadding(
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
                                  height: Constants.getTextformfieldHeight(
                                    context,
                                  ),
                                  child: TextFormField(
                                    textAlign: TextAlign.start,
                                    controller: _emailController,
                                    maxLength: 60,
                                    validator:
                                        (value) =>
                                            MyValidationClass.validateEmail(
                                              value,
                                            ),
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                        fontSize:
                                            Constants.getTextformfieldHintFont(
                                              context,
                                            ),
                                        color: AppColors.secondaryColor(),
                                        fontFamily: 'Visby',
                                        fontWeight: FontWeight.normal,
                                      ), //hhint text style
                                      hintText: 'Email Address',
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
                                        top:
                                            Constants.getTextformfieldContentPadding(
                                              context,
                                            ),
                                        left:
                                            Constants.getTextformfieldContentPadding(
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
                                  height:
                                      Constants.getVerticalGapBetweenTwoTextformfields(
                                        context,
                                      ),
                                ),

                                SizedBox(
                                  height:
                                      Constants.getVerticalGapBetweenTwoTextformfields(
                                        context,
                                      ) *
                                      350,
                                ),

                                TextButton(
                                  onPressed: () async {
                                    _submit();

                                    if (await NetworkHelper.checkInternetConnection()) {
                                      if (MyValidationClass.validateFirstName(
                                                _firstNameController.text,
                                              ) ==
                                              null &&
                                          MyValidationClass.validateName(
                                                _lastNameController.text,
                                              ) ==
                                              null &&
                                          MyValidationClass.validateMobileforEditProfile(
                                                _mobileNumberController.text,
                                              ) ==
                                              null &&
                                          MyValidationClass.validateEmail(
                                                _emailController.text,
                                              ) ==
                                              null) {
                                        setState(() {
                                          _isLoading1 = true;
                                        });

                                        if (("${_firstNameController.text} ${_lastNameController.text}") ==
                                                cardDataJsonObject['fullName']
                                                    .toString() &&
                                            _mobileNumberController.text ==
                                                cardDataJsonObject['mobileNo']
                                                    .toString()
                                                    .replaceAll('+92', '') &&
                                            _emailController.text ==
                                                cardDataJsonObject['emailAddress']
                                                    .toString()) {
                                          _isLoading1 = false;
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .error_outline_rounded,
                                                      color: Colors.red,
                                                    ),
                                                    SizedBox(width: 8),
                                                    Text('Error'),
                                                  ],
                                                ),
                                                content: Text(
                                                  "Nothing to edit. Please make some changes!",
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    child: Text('OK'),
                                                    onPressed:
                                                        () =>
                                                            Navigator.of(
                                                              context,
                                                            ).pop(),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        } else if (_mobileNumberController
                                                    .text ==
                                                cardDataJsonObject['mobileNo']
                                                    .toString()
                                                    .replaceAll('+92', '') &&
                                            _emailController.text ==
                                                cardDataJsonObject['emailAddress']
                                                    .toString()) {
                                          updateProfile();
                                        } else {
                                          values = {
                                            'fullName':
                                                "${_firstNameController.text} ${_lastNameController.text}",
                                            'mobileNo':
                                                _mobileNumberController.text,
                                            'emailAddress':
                                                _emailController.text,
                                          };

                                          sendOTP();
                                        }
                                      }
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
                                        _isLoading1
                                            ? const CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                    Colors.white,
                                                  ),
                                            )
                                            : Text(
                                              'Confirm',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    Constants.getButtonFont(
                                                      context,
                                                    ),
                                                fontFamily: 'Visby',
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
      ),
    );
  }

  Future<void> updateProfile() async {
    var data = {
      "CNIC": strCNIC,
      "FullName": "${_firstNameController.text} ${_lastNameController.text}",
      "EmailAddress": _emailController.text,
      "MobileNo": "+92${_mobileNumberController.text}",
    };

    String auth = "Bearer $strToken";

    try {
      final responseBody = await NetworkHelper.editProfile(data, auth);
      var decodedResponseBody = json.decode(responseBody!);

      if (kDebugMode) {
        print("server replied responsebody: $responseBody");
      }

      setState(() {
        _isLoading1 = false;
      });

      if (decodedResponseBody["statusCode"] == "200") {
        await showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: Row(
                  children: [
                    const Text('Success'),
                    const Spacer(),
                    Icon(
                      Icons.check_circle_outline_rounded,
                      color: Colors.green,
                    ),
                  ],
                ),
                content: Text(decodedResponseBody["responseMessage"]),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => HomePageNew()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              title: Row(
                children: [
                  Text("Error"),
                  Spacer(),
                  Icon(Icons.error_outline_rounded, color: Colors.red),
                ],
              ),
              content: Text(decodedResponseBody["responseMessage"]),
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
    } catch (e) {
      _isLoading1 = false;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            title: Row(
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
                    _isLoading1 = false;
                  });
                },
              ),
            ],
          );
        },
      );
    }
  }

  // Future<bool> loadData() async {
  //
  //   var data =  {
  //     "CNIC" : strCNIC,
  //   };
  //
  //
  //   String auth = "Bearer $strToken";
  //
  //   try {
  //     final responseBody = await NetworkHelper.getProfileDetail(data, auth);
  //
  //     cardDataJsonObject = jsonDecode(responseBody!);
  //
  //     if (kDebugMode) {
  //       print("Header: $auth");
  //       print("data object: $data");
  //       print("CNIC used: $strCNIC");
  //       print("Response: $responseBody");
  //     }
  //
  //     if (cardDataJsonObject["statusCode"]=="204")
  //       {
  //         showDialog(
  //           context: context,
  //           builder: (BuildContext context) {
  //             return AlertDialog(
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(10.0),
  //               ),
  //               title: const Row(
  //                 children: [
  //                   Icon(
  //                     Icons.error_outline,
  //                     color: Colors.red,
  //                   ),
  //                   SizedBox(width: 10.0),
  //                   Text('Error'),
  //                 ],
  //               ),
  //               content: Text(cardDataJsonObject["responseMessage"]),
  //               actions: [
  //                 TextButton(
  //                   child: const Text('OK'),
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                   },
  //                 ),
  //               ],
  //             );
  //           },
  //         );
  //
  //       }
  //     else
  //       {
  //         {
  //           setState(() {
  //
  //             String fullName = cardDataJsonObject['fullName'].toString();
  //             List<String> names = fullName.split(' ');
  //             String firstName = names[0];
  //             String lastName = names[names.length - 1];
  //
  //             if (names.length > 2) {
  //               firstName = names.sublist(0, names.length - 1).join(' ');
  //             }
  //
  //             _firstNameController.text = firstName;
  //             _lastNameController.text = lastName;
  //             _mobileNumberController.text = cardDataJsonObject['mobileNo'].toString().replaceAll('+92', '');
  //             _emailController.text = cardDataJsonObject['emailAddress'];
  //
  //
  //             setState(() {
  //               _isLoading = false;
  //             });
  //
  //           });
  //         }
  //       }
  //
  //     if (kDebugMode) {
  //       print("card checking: ${cardDataJsonObject['fullName']}");
  //     }
  //   }
  //   catch (e) {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: const Text("Error"),
  //           content:
  //           Text(e.toString()),
  //           actions: [
  //             TextButton(
  //               child: const Text("Close"),
  //               onPressed: () {
  //                 _secureStorage.deleteToken();
  //                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPageNew()));
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  //   return false;
  // }

  Future<void> sendOTP() async {
    var data = {
      "EmailAddress": _emailController.text,
      "MobileNo": _mobileNumberController.text,
    };

    String auth = "Bearer $strToken";

    try {
      final responseBody = await NetworkHelper.sendOTPEditProfile(data, auth);
      var decodedResponseBody = json.decode(responseBody!);

      if (kDebugMode) {
        print("server replied responsebody: $responseBody");
      }

      setState(() {
        _isLoading1 = false;
      });

      if (decodedResponseBody["statusCode"] == "200") {
        values['otp'] = decodedResponseBody["otp"];
        values['cnic'] = strCNIC;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProfileUpdateOTPVerificationPageNew(values),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              title: Row(
                children: [
                  Text("Error"),
                  Spacer(),
                  Icon(Icons.error_outline_rounded, color: Colors.red),
                ],
              ),
              content: Text(decodedResponseBody["responseMessage"]),
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
    } catch (e) {
      _isLoading1 = false;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            title: Row(
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
                    _isLoading1 = false;
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
