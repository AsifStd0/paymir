import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import '../util/Constants.dart';
import '../util/SecureStorage.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


class MoreServicesPageNew extends StatefulWidget {
  const MoreServicesPageNew({super.key});

  @override
  _MoreServicesPageNewState createState() => _MoreServicesPageNewState();
}

class _MoreServicesPageNewState extends State<MoreServicesPageNew> {

  int _selectedIndex = 0;

  File? _image;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = 0;
    });
  }



  TextEditingController textEditingController = TextEditingController();
  String currentText = "";


  final List<Map<String, String>> _list = [
    {
      'image': 'assets/images/govt_logo.svg',
      'text1': 'Etea Test\n',
      'subtext1': 'Payment',
      'text2': '+Rs 500\n',
      'subtext2': '28/03/23',
    },
    {
      'image': 'assets/images/govt_logo.svg',
      'text1': 'Police Clearance\n',
      'subtext1': 'Payment',
      'text2': '+Rs 500\n',
      'subtext2': '28/03/23',
    },
    {
      'image': 'assets/images/govt_logo.svg',
      'text1': 'PESCO Bill\n',
      'subtext1': 'Payment',
      'text2': '+Rs 2345\n',
      'subtext2': '28/03/23',
    },
    {
      'image': 'assets/images/govt_logo.svg',
      'text1': 'eChallan Payment\n',
      'subtext1': 'Payment',
      'text2': '+Rs 550\n',
      'subtext2': '28/03/23',
    },
    {
      'image': 'assets/images/govt_logo.svg',
      'text1': 'Etea Test\n',
      'subtext1': 'Payment',
      'text2': '+Rs 500\n',
      'subtext2': '28/03/23',
    },
    {
      'image': 'assets/images/govt_logo.svg',
      'text1': 'Police Clearance\n',
      'subtext1': 'Payment',
      'text2': '+Rs 500\n',
      'subtext2': '28/03/23',
    },
    {
      'image': 'assets/images/govt_logo.svg',
      'text1': 'PESCO Bill\n',
      'subtext1': 'Payment',
      'text2': '+Rs 2345\n',
      'subtext2': '28/03/23',
    },
    {
      'image': 'assets/images/govt_logo.svg',
      'text1': 'eChallan Payment\n',
      'subtext1': 'Payment',
      'text2': '+Rs 550\n',
      'subtext2': '28/03/23',
    },
    {
      'image': 'assets/images/govt_logo.svg',
      'text1': 'Etea Test\n',
      'subtext1': 'Payment',
      'text2': '+Rs 500\n',
      'subtext2': '28/03/23',
    },
    {
      'image': 'assets/images/govt_logo.svg',
      'text1': 'Police Clearance\n',
      'subtext1': 'Payment',
      'text2': '+Rs 500\n',
      'subtext2': '28/03/23',
    },
    {
      'image': 'assets/images/govt_logo.svg',
      'text1': 'PESCO Bill\n',
      'subtext1': 'Payment',
      'text2': '+Rs 2345\n',
      'subtext2': '28/03/23',
    },
    {
      'image': 'assets/images/govt_logo.svg',
      'text1': 'eChallan Payment\n',
      'subtext1': 'Payment',
      'text2': '+Rs 550\n',
      'subtext2': '28/03/23',
    },
  ];

  final _formKey = GlobalKey<FormState>();

  final SecureStorage _secureStorage = SecureStorage();

   List<dynamic> pendingDues = [];//[{"arcid":77,"applicationTrackingNo":"RED-LRB-20220727-00002","cnic":"11111-1111111-1","serviceName":"Land Record and Boundary Identification (HadBarari)","serviceTypeName":"New Hadbarari Application","departmentName":"Revenue and Estate Department","feeAmount":1000.00,"status":"Pending","applicationGenerationDateTime":"2023-04-16T00:00:00","entryDateTime":"2023-04-17T00:00:00","responseStatus":true,"responseMessage":"Request entertained successfully"}];
   List<dynamic> doneTransactions = [];//[{"arcid":77,"applicationTrackingNo":"RED-LRB-20220727-00002","cnic":"11111-1111111-1","serviceName":"Land Record and Boundary Identification (HadBarari)","serviceTypeName":"New Hadbarari Application","departmentName":"Revenue and Estate Department","feeAmount":1000.00,"status":"Pending","applicationGenerationDateTime":"2023-04-16T00:00:00","entryDateTime":"2023-04-17T00:00:00","responseStatus":true,"responseMessage":"Request entertained successfully"}];

  Map<String, dynamic> cardDataJsonObject ={};
  Map<String, dynamic> profileDataJsonObject ={};

  String strCardHolderName ="Name";
  DateTime now = DateTime.now();

  String strExpiryDate = DateFormat('MM/yyyy').format(DateTime(DateTime.now().year + 5, DateTime.now().month, DateTime.now().day)).toString().replaceRange(0, 2, DateFormat('MM').format(DateTime(DateTime.now().year + 5, DateTime.now().month, DateTime.now().day)).toString());


  String strCardNumber ="****  ****  ****  ****";

  List<dynamic> serviceCharges =
   [
     {
       "serviceProviderId": 1,
       "serviceProviderTitle": "Jazz Cash",
       "paymentServiceCharges": [
         {
           "paymentChargesId": 1,
           "serviceProviderId": 1,
           "paymentModeId": 1,
           "paymentModeTitle": "MobileApp",
           "paymentChargesPercentage": 0.70,
           "platformChargesPercentage": 0.0,
           "totalTaxPercentage": 2.32
         },
         {
           "paymentChargesId": 2,
           "serviceProviderId": 1,
           "paymentModeId": 2,
           "paymentModeTitle": "OTC",
           "paymentChargesPercentage": 1.50,
           "platformChargesPercentage": 0.0,
           "totalTaxPercentage": 2.32
         },
         {
           "paymentChargesId": 3,
           "serviceProviderId": 1,
           "paymentModeId": 3,
           "paymentModeTitle": "CreditCard/DebitCard",
           "paymentChargesPercentage": 2.00,
           "platformChargesPercentage": 0.0,
           "totalTaxPercentage": 2.32
         }
       ]
     },
     {
       "serviceProviderId": 2,
       "serviceProviderTitle": "EasyPaisa",
       "paymentServiceCharges": [
         {
           "paymentChargesId": 4,
           "serviceProviderId": 2,
           "paymentModeId": 1,
           "paymentModeTitle": "MobileApp",
           "paymentChargesPercentage": 0.70,
           "platformChargesPercentage": 0.0,
           "totalTaxPercentage": 2.32
         }
       ]
     },
     {
       "serviceProviderId": 3,
       "serviceProviderTitle": "UBL Omni",
       "paymentServiceCharges": [
         {
           "paymentChargesId": 5,
           "serviceProviderId": 3,
           "paymentModeId": 1,
           "paymentModeTitle": "MobileApp",
           "paymentChargesPercentage": 0.50,
           "platformChargesPercentage": 0.0,
           "totalTaxPercentage": 2.32
         },
         {
           "paymentChargesId": 6,
           "serviceProviderId": 3,
           "paymentModeId": 2,
           "paymentModeTitle": "OTC",
           "paymentChargesPercentage": 1.00,
           "platformChargesPercentage": 0.0,
           "totalTaxPercentage": 2.32
         },
         {
           "paymentChargesId": 7,
           "serviceProviderId": 3,
           "paymentModeId": 3,
           "paymentModeTitle": "CreditCard/DebitCard",
           "paymentChargesPercentage": 1.50,
           "platformChargesPercentage": 0.0,
           "totalTaxPercentage": 3.50
         }
       ]
     }
   ];

  String strToken="";
  String strTokenExpiry="";
  String strCNIC="";

  Future<void> fetchSecureStorageData() async {
    strToken = await _secureStorage.getToken() ?? '';
    strTokenExpiry = await _secureStorage.getTokenExpiry() ?? '';
    strCNIC = await _secureStorage.getCNIC() ?? '';

    // _passwordController.text = await _secureStorage.getPassWord() ?? '';
  }


  @override
  void initState() {
    super.initState();
    fetchSecureStorageData();
    Future.delayed(const Duration(milliseconds: 2900), () {
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final appDir = await getApplicationDocumentsDirectory();
      const fileName = 'avatar.png';
      final file = File('${appDir.path}/$fileName');
      if (await file.exists()) {
        setState(() {
          _image = file;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        return true;//(await ShowAlertDialogueClass.exitAppDialog(context));
      },
      child: Scaffold(
        backgroundColor: const Color(0xffFAFCFF),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // First Row
                    Padding(
                      padding: EdgeInsets.only(
                          top:Constants.getVerticalGapBetweenTwoTextformfields(context)*40,
                          left: Constants.getHomePageMainTextLeftPadding(context)*2.3,
                          right: Constants.getVerticalGapBetweenTwoTextformfields(context),
                          bottom: Constants.getVerticalGapBetweenTwoTextformfields(context)*9,
                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                'More Services',
                                style: TextStyle(
                                  color: const Color(0xff3F3F3F),
                                  fontFamily: 'Metropolis',
                                  fontWeight: FontWeight.w700,
                                  fontSize:Constants.getServiceFontSize(context),
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                        children: [
                          InkWell(
                            onTap: () {
                              // your code here
                              showMyGeneraDialog();

                              //Navigator.push(context, MaterialPageRoute(builder: (_)=>DastakPageNew()));

                            },
                            child: Container(
                              width: MediaQuery.sizeOf(context).width *0.2,
                              height: MediaQuery.sizeOf(context).width *0.22,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: const Color(0xffF4F6F9),
                                borderRadius: BorderRadius.circular(MediaQuery.sizeOf(context).width *0.03),
                                border: Border.all(
                                  color: const Color(0xffEBEBEB),
                                ),
                              ),
                              child: Padding(
                                padding:  EdgeInsets.all(MediaQuery.sizeOf(context).width *0.015),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(Constants.getVerticalGapBetweenTwoTextformfields(context)*10),
                                      child: SvgPicture.asset(
                                        'assets/images/feelogo.svg',
                                        height: Constants.getSmallFontSize(context) * 2,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top:Constants.getVerticalGapBetweenTwoTextformfields(context)*2),
                                      child: Text(
                                        'Fee',
                                        style: TextStyle(
                                          color: const Color(0xff3F3F3F),
                                          fontFamily: 'Metropolis',
                                          fontSize: Constants.getSmallFontSize(context),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            // your code here

                            showMyGeneraDialog();

                          },
                          child: Container(
                            width: MediaQuery.sizeOf(context).width *0.2,
                            height: MediaQuery.sizeOf(context).width *0.22,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: const Color(0xffF4F6F9),
                              borderRadius: BorderRadius.circular(MediaQuery.sizeOf(context).width *0.03),
                              border: Border.all(
                                color: const Color(0xffEBEBEB),
                              ),
                            ),
                            child: Padding(
                              padding:  EdgeInsets.all(MediaQuery.sizeOf(context).width *0.015),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(Constants.getVerticalGapBetweenTwoTextformfields(context)*10),
                                    child: SvgPicture.asset(
                                      'assets/images/carlogo.svg',
                                      height: Constants.getSmallFontSize(context) * 2,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top:Constants.getVerticalGapBetweenTwoTextformfields(context)*2),
                                    child: Text(
                                      'MTag',
                                      style: TextStyle(
                                        color: const Color(0xff3F3F3F),
                                        fontFamily: 'Metropolis',
                                        fontSize: Constants.getSmallFontSize(context),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            // your code here
                            showMyGeneraDialog();
                          },
                          child: Container(
                            width: MediaQuery.sizeOf(context).width *0.2,
                            height: MediaQuery.sizeOf(context).width *0.22,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: const Color(0xffF4F6F9),
                              borderRadius: BorderRadius.circular(MediaQuery.sizeOf(context).width *0.03),
                              border: Border.all(
                                color: const Color(0xffEBEBEB),
                              ),
                            ),
                            child: Padding(
                              padding:  EdgeInsets.all(MediaQuery.sizeOf(context).width *0.015),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(Constants.getVerticalGapBetweenTwoTextformfields(context)*10),
                                    child: SvgPicture.asset(
                                      'assets/images/utilitieslogo.svg',
                                      height: Constants.getSmallFontSize(context) * 2,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top:Constants.getVerticalGapBetweenTwoTextformfields(context)*2),
                                    child: Text(
                                      'Utilities',
                                      style: TextStyle(
                                        color: const Color(0xff3F3F3F),
                                        fontFamily: 'Metropolis',
                                        fontSize: Constants.getSmallFontSize(context),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
                    SizedBox(height: Constants.getVerticalGapBetweenTwoTextformfields(context)*15),

                  ],
                ),
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
        if(strResponse.contains("successfully")) {
          Navigator.of(context, rootNavigator: true).pop();
          //Navigator.push(context, MaterialPageRoute(builder: (_)=>VerificationCodePage(cnicString)));
        }else {
          Navigator.of(context, rootNavigator: true).pop();
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Response"),
      content: Text(strResponse),
      actions: [
        okButton,

      ],

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
    String pattern =
        r"^([a-zA-Z]{3})+$";
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




  void showMyGeneraDialog(){
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
        return Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 50,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Coming soon!',
                      textStyle: const TextStyle(fontSize: 24),
                      speed: const Duration(milliseconds: 100),
                    ),
                  ],
                  totalRepeatCount: 10,
                  pause: const Duration(milliseconds: 600),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: Constants.getButtonHeight(context),
                    width: Constants.getButtonHeight(context)*2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Constants.gradientColor1(),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: const Center(
                      child: Text(
                        'Okay',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}