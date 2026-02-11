import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paymir_new_android/util/app_colors.dart';

import '../util/Constants.dart';
import '../util/NetworkHelperClass.dart';
import '../util/SecureStorage.dart';
import 'ProfilePageNew.dart';

class CustomerSupportPageNew extends StatefulWidget {
  final String strCNIC;
  Map<String, dynamic> cardDataJsonObject;

  CustomerSupportPageNew(this.strCNIC, this.cardDataJsonObject, {super.key});
  //const CustomerSupportPageNew({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomerSupportPageNewState createState() =>
      _CustomerSupportPageNewState(strCNIC, cardDataJsonObject);
}

class _CustomerSupportPageNewState extends State<CustomerSupportPageNew> {
  String strCNIC;
  Map<String, dynamic> cardDataJsonObject;

  _CustomerSupportPageNewState(this.strCNIC, this.cardDataJsonObject);

  var _isLoading = false;
  var _selectedCategory;
  // Map<String, String> values ={};

  String strToken = "";
  String strTokenExpiry = "";
  // String strCNIC="";

  final SecureStorage _secureStorage = SecureStorage();

  Future<void> fetchSecureStorageData() async {
    strToken = await _secureStorage.getToken() ?? '';
    // strCNIC = await _secureStorage.getCNIC() ?? '';

    // _passwordController.text = await _secureStorage.getPassWord() ?? '';
  }

  @override
  void initState() {
    super.initState();
    fetchSecureStorageData();
  }

  final TextEditingController _descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String cnicString = "";
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
        backgroundColor: const Color(0xffFAFCFF),
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
                          'Customer Support',
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
                          'It only takes a minute to register your suggestion/complaint',
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

                        DropdownButtonFormField(
                          value: _selectedCategory,
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value;
                              if (kDebugMode) {
                                print(_selectedCategory);
                              }
                            });
                          },
                          items: const [
                            DropdownMenuItem(
                              value: 'suggestions',
                              child: Text('Suggestions'),
                            ),
                            DropdownMenuItem(
                              value: 'complaints',
                              child: Text('Complaints'),
                            ),
                            DropdownMenuItem(
                              value: 'issues',
                              child: Text('Issues'),
                            ),
                            DropdownMenuItem(
                              value: 'servicerelated',
                              child: Text('Service Related'),
                            ),
                          ],
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.05,
                            ),
                            hintStyle: TextStyle(
                              fontSize: Constants.getTextformfieldHintFont(
                                context,
                              ),
                              color: const Color(0xff03110A),
                              fontFamily: 'Visby',
                              fontWeight: FontWeight.bold,
                            ), //hint text style
                            hintText: 'Select Category',

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  Constants.getTextformfieldBorderRadius(
                                    context,
                                  ),
                                ),
                              ),
                              borderSide: const BorderSide(
                                color: Color(0xFF21BF73),
                              ),
                            ),
                            counterText: '',
                          ),
                        ),

                        SizedBox(
                          height:
                              Constants.getVerticalGapBetweenTwoTextformfields(
                                context,
                              ) *
                              20,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xffCCCCCC)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                Constants.getTextformfieldBorderRadius(context),
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.width * 0.03,
                                  left:
                                      MediaQuery.of(context).size.width * 0.03,
                                ),
                                child: Text(
                                  'Description',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        Constants.getTextformfieldHintFont(
                                          context,
                                        ),
                                    color: const Color(0xff03110A),
                                    fontFamily: 'Visby',
                                  ),
                                ),
                              ),
                              //SizedBox(height: 10),
                              TextFormField(
                                textAlign: TextAlign.start,
                                controller: _descriptionController,
                                maxLength: 200,
                                maxLines: null,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  counterText: '',
                                  contentPadding: EdgeInsets.only(
                                    left:
                                        Constants.getTextformfieldContentPadding(
                                          context,
                                        ),
                                    bottom:
                                        Constants.getTextformfieldContentPadding(
                                          context,
                                        ),
                                  ),
                                  hintText: 'Add your details here',
                                  hintStyle: TextStyle(
                                    fontSize:
                                        Constants.getTextformfieldHintFont(
                                          context,
                                        ),
                                    color: AppColors.secondaryColor(),
                                    fontFamily: 'Visby',
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height:
                              Constants.getVerticalGapBetweenTwoTextformfields(
                                context,
                              ) *
                              200,
                        ),

                        TextButton(
                          onPressed: () async {
                            _submit();
                            if (!(_selectedCategory == null ||
                                _selectedCategory.isEmpty)) {
                              if (_descriptionController.text.isNotEmpty) {
                                _isLoading = true;
                                registerComplaint();
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          10.0,
                                        ),
                                      ),
                                      title: const Row(
                                        children: [
                                          Icon(
                                            Icons.error_outline,
                                            color: Colors.red,
                                          ),
                                          SizedBox(width: 10.0),
                                          Text('Error'),
                                        ],
                                      ),
                                      content: const Text(
                                        'Please enter description.',
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
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    title: const Row(
                                      children: [
                                        Icon(
                                          Icons.error_outline,
                                          color: Colors.red,
                                        ),
                                        SizedBox(width: 10.0),
                                        Text('Error'),
                                      ],
                                    ),
                                    content: const Text(
                                      'Please select a category.',
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
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    )
                                    : Text(
                                      'Confirm',
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
                              Constants.getVerticalGapBetweenMainAndSmallFont(
                                context,
                              ) *
                              30,
                        ),

                        Container(
                          height: MediaQuery.of(context).size.width * 0.16,
                          color: const Color(0xff6E78F70A).withOpacity(0.15),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/images/bigmic.svg'),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.04,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.width * 0.038,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Helpline Number',
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                            0.03,
                                        color: const Color(0xff08A1A7),
                                      ),
                                    ),
                                    Text(
                                      '091 589 1516',
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                            0.045,
                                        color: const Color(0xff6E78F7),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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

  Future<bool> registerComplaint() async {
    var data = {
      "CNIC": strCNIC,
      "Category": _selectedCategory,
      "Description": _descriptionController.text,
    };

    String auth = "Bearer $strToken";

    try {
      final responseBody = await NetworkHelper.registerComplaint(data, auth);
      var decodedResponseBody = json.decode(responseBody!);

      setState(() {
        _isLoading = false;
      });
      if (decodedResponseBody["statusCode"] == "200") {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              title: const Row(
                children: [
                  Icon(Icons.check_circle_outline, color: Colors.green),
                  SizedBox(width: 10.0),
                  Text('Success'),
                ],
              ),
              content: Text(decodedResponseBody["responseMessage"]),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();

                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                ProfilePageNew(strCNIC, cardDataJsonObject),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              title: const Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.red),
                  SizedBox(width: 10.0),
                  Text('Error'),
                ],
              ),
              content: Text(decodedResponseBody["responseMessage"]),
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

      return false;
    } catch (e) {
      // print(e);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            title: const Row(
              children: [
                Icon(Icons.error_outline, color: Colors.red),
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('_selectedCategory', _selectedCategory));
  }
}
