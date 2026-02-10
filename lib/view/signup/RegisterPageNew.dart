import 'dart:convert';
import 'dart:developer';

import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../util/AlertDialogueClass.dart';
import '../../util/Constants.dart';
import '../../util/MyValidation.dart';
import '../../util/NetworkHelperClass.dart';
import '../../widget/PrivacyPolicyPageNew.dart';
import '../MobilePageNew.dart';
import '../login/LoginPageNew.dart';

class RegisterPageNew extends StatefulWidget {
  const RegisterPageNew({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterPageNewState createState() => _RegisterPageNewState();
}

class _RegisterPageNewState extends State<RegisterPageNew> {
  late bool _passwordVisible;
  var _isChecked = false;
  late var _isLoading = false;
  Map<String, String> values = {};

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _cnicController = MaskedTextController(
    mask: '00000-0000000-0',
  );
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

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
                        Text(
                          'Sign Up',
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
                          'It only takes a minute to create your account',
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

                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: Constants.getTextFormFieldHeight(
                                  context,
                                ),

                                child: TextFormField(
                                  textAlign: TextAlign.start,
                                  controller: _firstNameController,
                                  maxLength: 15,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(
                                      RegExp(r"\s"),
                                    ),
                                  ],

                                  validator:
                                      (value) =>
                                          MyValidationClass.validateName(value),
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                      fontSize:
                                          Constants.getTextformfieldHintFont(
                                            context,
                                          ),
                                      color: Constants.secondaryColor(),
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

                                  //cursorColor: Colors.red,
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
                                height: Constants.getTextFormFieldHeight(
                                  context,
                                ),
                                child: TextFormField(
                                  controller: _lastNameController,
                                  maxLength: 15,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(
                                      RegExp(r"\s"),
                                    ),
                                  ],

                                  validator:
                                      (value) =>
                                          MyValidationClass.validateName(value),
                                  textAlign: TextAlign.start,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                      fontSize:
                                          Constants.getTextformfieldHintFont(
                                            context,
                                          ),
                                      color: Constants.secondaryColor(),
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
                          height: Constants.getTextFormFieldHeight(context),
                          child: TextFormField(
                            textAlign: TextAlign.start,
                            controller: _cnicController,
                            validator:
                                (value) =>
                                    MyValidationClass.validateCNIC(value),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                fontSize: Constants.getTextformfieldHintFont(
                                  context,
                                ),
                                color: Constants.secondaryColor(),
                                fontFamily: 'Visby',
                                fontWeight: FontWeight.normal,
                              ), //h//hint text style
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
                          height: Constants.getTextformfieldHeight(context),
                          child: TextFormField(
                            textAlign: TextAlign.start,
                            controller: _emailController,
                            maxLength: 60,
                            validator:
                                (value) =>
                                    MyValidationClass.validateEmail(value),
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                fontSize: Constants.getTextformfieldHintFont(
                                  context,
                                ),
                                color: Constants.secondaryColor(),
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
                            controller: _passwordController,
                            maxLength: 30,
                            validator:
                                (value) =>
                                    MyValidationClass.validatePassword(value),
                            obscureText: !_passwordVisible,

                            // Here is key idea
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,

                                  color: Constants.secondaryColor(),
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
                              ), //h//hint text style
                              hintText: 'Password',
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.0),
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
                        Row(
                          children: [
                            Checkbox(
                              value: _isChecked,
                              onChanged: (value) {
                                setState(() {
                                  _isChecked = value!;
                                  _submit();
                                });
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
                                                  context,
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
                                              context,
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
                                                  context,
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
                                              context,
                                            ),
                                      ),
                                    ),
                                  ],
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

                        TextButton(
                          onPressed:
                              _isChecked
                                  ? () async {
                                    _submit();
                                    setState(() {
                                      //_isLoading = true;
                                    });

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
                                      values = {
                                        'fullname':
                                            "${_firstNameController.text} ${_lastNameController.text}",
                                        'emailAddress': _emailController.text,
                                        'cnic': _cnicController.text,
                                        'password': _passwordController.text,
                                        'Category': "PAYMIR",
                                      };
                                      setState(() {
                                        _isLoading = true;
                                      });

                                      if (await NetworkHelper.checkInternetConnection()) {
                                        checkUser();
                                      } else {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        ShowAlertDialogueClass.showAlertDialogue(
                                          context: context,
                                          title: "No Internet",
                                          message:
                                              "Check your internet connection!",
                                          buttonText: "OK",
                                          iconData: Icons.error,
                                        );
                                      }
                                    }
                                  }
                                  : null,
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: Constants.getButtonHeight(context),
                            decoration:
                                (_isChecked)
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
                                          Constants.gradientColor1(),
                                          Constants.gradientColor2(),
                                        ],
                                      ),
                                    )
                                    : BoxDecoration(
                                      color: Constants.secondaryColor(),
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
                                      'Sign Up',
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
                          height: Constants.getVerticalGapAboveLastLine(
                            context,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already Registered? ",
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
                                    builder: (_) => const LoginPageNew(),
                                  ),
                                );
                              },

                              child: Text(
                                "Sign In",
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

  Future<void> checkUser() async {
    log('checking user ***');
    var data = {"CNIC": _cnicController.text, 'Category': "PAYMIR"};
    log('data: $data');
    try {
      log('checking user ***');
      final responseBody = await NetworkHelper.checkUser(data);
      log('responseBody: $responseBody');
      var decodedResponseBody = json.decode(responseBody!);
      log('decodedResponseBody: $decodedResponseBody');
      if (kDebugMode) {
        print("server replied responsebody: " + responseBody);
      }
      log('setting state ***');
      setState(() {
        _isLoading = false;
      });
      log('if condition *** $decodedResponseBody["statusCode"]');
      if (decodedResponseBody["statusCode"] == "200") {
        log('pushing to mobile page ***');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MobilePageNew(values)),
        );
      } else {
        log('showing dialog ***');
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
