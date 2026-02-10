import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../util/NetworkHelperClass.dart';
import '../view/SuccessfullyChangedPasswordNew.dart';
import '../util/Constants.dart';
import '../util/MyValidation.dart';
import '../util/SecureStorage.dart';

class UpdatePasswordPageNew extends StatefulWidget {
  const UpdatePasswordPageNew({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UpdatePasswordPageNewState createState() => _UpdatePasswordPageNewState();
}
class _UpdatePasswordPageNewState extends State<UpdatePasswordPageNew> {

  final TextEditingController _txtOldPasswordController = TextEditingController();
  final TextEditingController _txtPasswordController = TextEditingController();
  final TextEditingController _txtRePasswordController = TextEditingController();

  bool _isLoading = false;
  late bool _passwordVisible1;
  late bool _passwordVisible2;
  late bool _passwordVisible3;

  final _formKey = GlobalKey<FormState>();


  void _submit() {
    if (_formKey.currentState!.validate()) {
      // TODO SAVE DATA
    }
  }

  String strToken="";
  String strTokenExpiry="";
  String strCNIC="";

  final SecureStorage _secureStorage = SecureStorage();

  Future<void> fetchSecureStorageData() async {
    strToken = await _secureStorage.getToken() ?? '';
    strCNIC = await _secureStorage.getCNIC() ?? '';

    // _passwordController.text = await _secureStorage.getPassWord() ?? '';
  }

  @override
  void initState() {
    super.initState();
    fetchSecureStorageData();
    _passwordVisible1 = false;
    _passwordVisible2 = false;
    _passwordVisible3 = false;
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
                          top:  Constants.getBackArrowTopPadding(context),
                          bottom: Constants.getBackArrowBottomPadding(context),
                        ),

                          child: IconButton(
                            icon:
                            SvgPicture.asset("assets/images/back_arrow.svg"),
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                          ),

                      ),
                    ],
                  ),

                Padding(
                  padding:  EdgeInsets.symmetric(
                    horizontal: Constants.getSymmetricHorizontalPadding(context),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                            'Update Password',
                            style: TextStyle(
                              color: Constants.primaryColor(),
                              fontFamily: 'Visby',
                              fontWeight: FontWeight.bold,
                              fontSize:Constants.getMainFontSize(context),
                            ),
                          ),

                        SizedBox(
                            height: Constants.getVerticalGapBetweenMainAndSmallFont(context)
                        ),

                        Text(
                          'Please provide old password!',
                          style: TextStyle(
                            color: Constants.secondaryColor(),
                            fontFamily: 'Visby',
                            fontWeight: FontWeight.w500,
                            fontSize: Constants.getSmallFontSize(context),
                          ),
                        ),

                        SizedBox(
                          height: Constants.getVerticalGapBetweenSmallfontAndTextfield(context),
                        ),

                        SizedBox(height: Constants.getTextFormFieldHeight(context),

                          child: TextFormField(textAlign: TextAlign.start,
                            controller: _txtOldPasswordController,
                            validator: (value) => MyValidationClass.validateOldPassword(value),
                            obscureText: !_passwordVisible1,

                            // Here is key idea

                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible1? Icons.visibility: Icons.visibility_off,

                                  color: Colors.grey,
                                ),
                                onPressed: () {

                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _passwordVisible1 = !_passwordVisible1;
                                  });
                                },
                              ),
                              hintStyle: TextStyle(
                                  fontSize: Constants.getTextformfieldHintFont(context),
                                  color: Constants.secondaryColor(),
                                  fontFamily: 'Visby',
                                  fontWeight: FontWeight.normal
                              ), //hint text style
                              hintText: 'Enter current password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(Constants.getTextformfieldBorderRadius(context))),

                        ),
                              counterText: '',
                              contentPadding: EdgeInsets.only(
                                top: Constants.getTextformfieldContentPadding(context),
                                left: Constants.getTextformfieldContentPadding(context),
                                bottom: Constants.getTextformfieldContentPadding(context),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: Constants.getVerticalGapBetweenTwoTextformfields(context)*30),

                        Text(
                            "- Please enter a password that is\n\n\t  - At least 8 characters long\n\t  - Must contain at least\n\t\t     - One uppercase letter\n\t\t     - One lowercase letter\n\t\t     - One digit\n\t\t     - One special character\n\t  - The password must not contain spaces",
                          style: TextStyle(
                              fontSize: Constants.getTextformfieldHintFont(context),
                              color: Constants.secondaryColor(),
                              fontFamily: 'Visby',
                              fontWeight: FontWeight.normal
                          ),
                        ),

                        SizedBox(height: Constants.getVerticalGapBetweenTwoTextformfields(context)*30),

                        SizedBox(height:Constants.getTextFormFieldHeight(context),
                          child: TextFormField(textAlign: TextAlign.start,
                            controller: _txtPasswordController,
                            validator: (value) => MyValidationClass.validatePassword(value),
                            obscureText: !_passwordVisible2,

                            // Here is key idea

                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible2? Icons.visibility: Icons.visibility_off,

                                  color: Colors.grey,
                                ),
                                onPressed: () {

                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _passwordVisible2 = !_passwordVisible2;
                                  });
                                },
                              ),
                              hintStyle: TextStyle(
                                  fontSize: Constants.getTextformfieldHintFont(context),
                                  color: Constants.secondaryColor(),
                                  fontFamily: 'Visby',
                                  fontWeight: FontWeight.normal
                              ), //hint text style
                              hintText: 'New password',
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(Constants.getTextformfieldBorderRadius(context))),

                              ),
                              counterText: '',
                              contentPadding: EdgeInsets.only(
                                top: Constants.getTextformfieldContentPadding(context),
                                left: Constants.getTextformfieldContentPadding(context),
                                bottom: Constants.getTextformfieldContentPadding(context),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: Constants.getVerticalGapBetweenTwoTextformfields(context)),

                        SizedBox(height:Constants.getTextFormFieldHeight(context),
                          child: TextFormField(textAlign: TextAlign.start,
                            controller: _txtRePasswordController,
                            validator: (value) => MyValidationClass.validateRePassword(value),
                            obscureText: !_passwordVisible3,

                            // Here is key idea

                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible3? Icons.visibility: Icons.visibility_off,

                                  color: Colors.grey,
                                ),
                                onPressed: () {

                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _passwordVisible3 = !_passwordVisible3;
                                  });
                                },
                              ),
                              hintStyle: TextStyle(
                                  fontSize: Constants.getTextformfieldHintFont(context),
                                  color: Constants.secondaryColor(),
                                  fontFamily: 'Visby',
                                  fontWeight: FontWeight.normal
                              ), //hint text style
                              hintText: 'Re enter new password',
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(Constants.getTextformfieldBorderRadius(context))),

                              ),
                              counterText: '',
                              contentPadding: EdgeInsets.only(
                                top: Constants.getTextformfieldContentPadding(context),
                                left: Constants.getTextformfieldContentPadding(context),
                                bottom: Constants.getTextformfieldContentPadding(context),
                              ),
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.08,
                              //bottom: MediaQuery.of(context).size.height * 0.02,
                            ),
                            child: TextButton(
                              onPressed: () {
                                _submit();

                                if(MyValidationClass.validateOldPassword(_txtOldPasswordController.text) != null)
                                  {
                                    _txtPasswordController.clear();
                                    _txtRePasswordController.clear();
                                  }
                                else {
                                  if (MyValidationClass.validateOldPassword(
                                      _txtOldPasswordController.text) == null &&
                                      MyValidationClass.validatePassword(
                                          _txtPasswordController.text) ==
                                          null &&
                                      MyValidationClass.validateRePassword(
                                          _txtRePasswordController.text) ==
                                          null) {
                                    if (_txtOldPasswordController.text !=
                                        _txtPasswordController.text) {
                                      if (_txtPasswordController.text ==
                                          _txtRePasswordController.text) {
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        updatePassword();
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(12.0),
                                              ),
                                              title: Row(
                                                children: [
                                                  Icon(
                                                    Icons.error_outline,
                                                    color: Colors.red,
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text('Error'),
                                                ],
                                              ),
                                              content:
                                              const Text('New passwords do not match!'),
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
                                    else {
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
                                                'Old and new passwords are same. Please provide a different password!'),
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
                                  borderRadius: BorderRadius.all(Radius.circular(Constants.getButtonRadius(context))),

                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Constants.gradientColor1(),
                                      Constants.gradientColor2(),
                                    ],
                                  ),
                                ),
                                child: _isLoading
                                    ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                )
                                    : Text(
                                  'Continue',
                                  style: TextStyle(
                                      color:Colors.white,
                                      fontSize:Constants.getButtonFont(context),
                                      fontFamily: 'Visby',
                                      fontWeight:FontWeight.bold
                                  ),
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

  Future<bool> updatePassword() async {

    var data22 = {
      "CNIC": strCNIC,
    };

    String auth = "Bearer $strToken";

    if (kDebugMode) {
      print("The value of auth: $auth");
    }

    try {
      final responseBody = await NetworkHelper.getOldPassword(data22, auth);

      if (kDebugMode) {
        print("Server response: ${responseBody!}");
      }

      // ignore: non_constant_identifier_names
      Map<String, dynamic> JsonObject = jsonDecode(responseBody!);
      String oldPasswordString = JsonObject['responseMessage'];

      //print("Old password: " + oldPasswordString);
      String password = oldPasswordString.split(':')[1];
      if (password == _txtOldPasswordController.text) {
        updatePasswordNow();
      }
      else {
        // ignore: use_build_context_synchronously
        showAlertDialog(context, "Incorrect old password.");
        setState(() {
          _isLoading = false;
        });
      }
    }
    catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            title: Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                ),
                SizedBox(width: 5),
                Text('Error'),
              ],
            ),
            content:
             Text(e.toString()),
            actions: [
              TextButton(
                child: const Text('Close'),
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

  Future<bool> updatePasswordNow() async {
    var data = {
      "CNIC": strCNIC,
      "Password": _txtPasswordController.text
    };

    String auth = "Bearer $strToken";

   try{
    final responseBody = await NetworkHelper.updateOldPassword(data, auth);

    setState(() {
      _isLoading = false;
    });

    if (responseBody!.contains("true")) {
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (_) => const SuccessfullyPasswordChangedPageNew()));
    }
    else {
      showAlertDialog(
          context, "Password could not be upated. Please try again!");
    }
    return false;
  }
   catch (e) {
     // print(e);
     showDialog(
       context: context,
       builder: (BuildContext context) {
         return AlertDialog(
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(12.0),
           ),
           title: Row(
             children: [
               Icon(
                 Icons.error_outline,
                 color: Colors.red,
               ),
               SizedBox(width: 5),
               Text('Error'),
             ],
           ),
           content: const Text('Server is down and cannot be accessed!'),
           actions: [
             TextButton(
               child: const Text('Close'),
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

  showAlertDialog(BuildContext context, String strResponse) {
    Widget okButton = TextButton(
      child: const Text('OK'),
      onPressed: () {
        if (strResponse.contains('successfully')) {
          Navigator.of(context, rootNavigator: true).pop();
        }
        else
        {
          Navigator.of(context, rootNavigator: true).pop();
        }
      },
    );
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      title: Row(
        children: [
          Icon(
            strResponse.contains('successfully')
                ? Icons.check_circle_outline
                : Icons.error_outline,
            color:
            strResponse.contains('successfully') ? Colors.green : Colors.red,
          ),
          SizedBox(width: 5),
          Text(strResponse.contains('successfully') ? 'Success' : 'Error'),
        ],
      ),
      content: Text(strResponse),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}