import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../util/AlertDialogueClass.dart';
import '../util/Constants.dart';
import '../util/NetworkHelperClass.dart';
import '../util/SecureStorage.dart';
import 'CFCPageNew.dart';
import 'DastakPageNew.dart';
import 'HEDPageNew.dart';
import 'login/LoginPageNew.dart';
import 'MoreServicesPageNew.dart';
import 'PaymentPageNew.dart';
import 'ProfilePageNew.dart';
import 'QRCodePageNew.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'VoucherNoPageNew.dart';

class HomePageNew extends StatefulWidget {
  const HomePageNew({super.key});

  @override
  _HomePageNewState createState() => _HomePageNewState();
}

class _HomePageNewState extends State<HomePageNew> {
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

  List<dynamic> pendingDues =
      []; //[{"arcid":77,"applicationTrackingNo":"RED-LRB-20220727-00002","cnic":"11111-1111111-1","serviceName":"Land Record and Boundary Identification (HadBarari)","serviceTypeName":"New Hadbarari Application","departmentName":"Revenue and Estate Department","feeAmount":1000.00,"status":"Pending","applicationGenerationDateTime":"2023-04-16T00:00:00","entryDateTime":"2023-04-17T00:00:00","responseStatus":true,"responseMessage":"Request entertained successfully"}];
  List<dynamic> doneTransactions =
      []; //[{"arcid":77,"applicationTrackingNo":"RED-LRB-20220727-00002","cnic":"11111-1111111-1","serviceName":"Land Record and Boundary Identification (HadBarari)","serviceTypeName":"New Hadbarari Application","departmentName":"Revenue and Estate Department","feeAmount":1000.00,"status":"Pending","applicationGenerationDateTime":"2023-04-16T00:00:00","entryDateTime":"2023-04-17T00:00:00","responseStatus":true,"responseMessage":"Request entertained successfully"}];

  Map<String, dynamic> cardDataJsonObject = {};
  Map<String, dynamic> profileDataJsonObject = {};

  String strCardHolderName = "Name";
  DateTime now = DateTime.now();

  String strExpiryDate = DateFormat('MM/yyyy')
      .format(
        DateTime(
          DateTime.now().year + 5,
          DateTime.now().month,
          DateTime.now().day,
        ),
      )
      .toString()
      .replaceRange(
        0,
        2,
        DateFormat('MM')
            .format(
              DateTime(
                DateTime.now().year + 5,
                DateTime.now().month,
                DateTime.now().day,
              ),
            )
            .toString(),
      );

  String strCardNumber = "****  ****  ****  ****";

  List<dynamic> serviceCharges = [
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
          "totalTaxPercentage": 2.32,
        },
        {
          "paymentChargesId": 2,
          "serviceProviderId": 1,
          "paymentModeId": 2,
          "paymentModeTitle": "OTC",
          "paymentChargesPercentage": 1.50,
          "platformChargesPercentage": 0.0,
          "totalTaxPercentage": 2.32,
        },
        {
          "paymentChargesId": 3,
          "serviceProviderId": 1,
          "paymentModeId": 3,
          "paymentModeTitle": "CreditCard/DebitCard",
          "paymentChargesPercentage": 2.00,
          "platformChargesPercentage": 0.0,
          "totalTaxPercentage": 2.32,
        },
      ],
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
          "totalTaxPercentage": 2.32,
        },
      ],
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
          "totalTaxPercentage": 2.32,
        },
        {
          "paymentChargesId": 6,
          "serviceProviderId": 3,
          "paymentModeId": 2,
          "paymentModeTitle": "OTC",
          "paymentChargesPercentage": 1.00,
          "platformChargesPercentage": 0.0,
          "totalTaxPercentage": 2.32,
        },
        {
          "paymentChargesId": 7,
          "serviceProviderId": 3,
          "paymentModeId": 3,
          "paymentModeTitle": "CreditCard/DebitCard",
          "paymentChargesPercentage": 1.50,
          "platformChargesPercentage": 0.0,
          "totalTaxPercentage": 3.50,
        },
      ],
    },
  ];

  String strToken = "";
  String strTokenExpiry = "";
  String strCNIC = "";

  Future<void> fetchSecureStorageData() async {
    strToken = await _secureStorage.getToken() ?? '';
    strTokenExpiry = await _secureStorage.getTokenExpiry() ?? '';
    strCNIC = await _secureStorage.getCNIC() ?? '';

    // Other actions that depend on the token can be chained here.
    loadCardDetails();
    loadApplicationDetails();
    loadDoneApplicationDetails();
    loadData();
  }

  Future<bool> loadCardDetails() async {
    var data = {"CNIC": strCNIC};

    String auth = "Bearer $strToken";

    try {
      final responseBody = await NetworkHelper.getCardDetail(data, auth);

      String jsonString = responseBody!;

      cardDataJsonObject = jsonDecode(jsonString);

      if (cardDataJsonObject.toString().contains("true")) {
        setState(() {
          strCardHolderName = cardDataJsonObject['fullName'].toString();
          strCardNumber = RegExp(r'\d{1,4}')
              .allMatches(cardDataJsonObject['ePaymentNo'].toString())
              .map((match) => match.group(0))
              .join('  ');
        });
      } else {
        SimpleDialog(
          title: const Row(
            children: [
              Text('Could not load data!'),
              Spacer(),
              Icon(Icons.check_circle_outline_rounded, color: Colors.green),
            ],
          ),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                _secureStorage.deleteToken();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPageNew()),
                );
              },
              child: const Row(
                children: [
                  Icon(Icons.close),
                  SizedBox(width: 10),
                  Text('Close'),
                ],
              ),
            ),
          ],
        );
      }

      if (kDebugMode) {
        print("card checking: ${cardDataJsonObject['fullName']}");
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Session Expired!"),
            content: Text("Please login again!:\n" + e.toString()),
            actions: [
              TextButton(
                child: const Text("Close"),
                onPressed: () {
                  _secureStorage.deleteToken();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPageNew()),
                  );
                },
              ),
            ],
          );
        },
      );
    }
    return false;
  }

  Future<bool> loadApplicationDetails() async {
    var data1 = {
      "DPTPaymentID": "NULL",
      "CNIC": strCNIC,
      "Using": "CNICNo",
      "PaymentPlatform": "Jazz Cash",
      "PaymentMode": "MobileWallet",
    };

    String auth = "Bearer $strToken";

    try {
      final responseBody = await NetworkHelper.getPendingTransactions(
        data1,
        auth,
      );

      if (kDebugMode) {
        print("Just before actual print...Pending Dues");
      }
      if (kDebugMode) {
        print(responseBody.toString());
      }

      String jsonString = responseBody!;

      // if(!jsonString.contains('{"'http_response":{"version":{"major":1,)'){
      //
      // }

      Map<String, dynamic> data2 = jsonDecode(jsonString);

      if (jsonString.contains("404")) {
        pendingDues = [];
      } else {
        setState(() {
          pendingDues = data2['pendingDues'];
          print("Pending Dues new print now: " + pendingDues.toString());
          serviceCharges = data2['serviceProviderTaxesConfigurations'];
        });

        if (kDebugMode) {
          print("Service Charges: $serviceCharges");
        }

        for (var i = 0; i < serviceCharges.length; i++) {
          if (kDebugMode) {
            print(
              'serviceProviderId: ${serviceCharges[i]['serviceProviderId']}',
            );
          }
          if (kDebugMode) {
            print(
              'serviceProviderTitle: ${serviceCharges[i]['serviceProviderTitle']}',
            );
          }

          List<dynamic> paymentServiceCharges =
              serviceCharges[i]['paymentServiceCharges'];

          for (var j = 0; j < paymentServiceCharges.length; j++) {
            if (kDebugMode) {
              print(
                'paymentChargesId: ${paymentServiceCharges[j]['paymentChargesId']}',
              );
            }
            if (kDebugMode) {
              print(
                'serviceProviderId: ${paymentServiceCharges[j]['serviceProviderId']}',
              );
            }
            if (kDebugMode) {
              print(
                'paymentModeId: ${paymentServiceCharges[j]['paymentModeId']}',
              );
            }
            if (kDebugMode) {
              print(
                'paymentModeTitle: ${paymentServiceCharges[j]['paymentModeTitle']}',
              );
            }
            if (kDebugMode) {
              print(
                'paymentChargesPercentage: ${paymentServiceCharges[j]['paymentChargesPercentage']}',
              );
            }
            if (kDebugMode) {
              print(
                'platformChargesPercentage: ${paymentServiceCharges[j]['platformChargesPercentage']}',
              );
            }
            if (kDebugMode) {
              print(
                'totalTaxPercentage: ${paymentServiceCharges[j]['totalTaxPercentage']}',
              );
            }
            if (kDebugMode) {
              print('');
            }
          }

          if (kDebugMode) {
            print('\n');
          }
        }
      }
      //else
    } catch (e) {
      pendingDues = [];

      if (e.toString().contains(
        "Authorization has been denied for this request",
      )) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                "Authorization has been denied for this request.!",
              ),
              content: Text("Session Expired. Please login again!:\n"),

              actions: [
                TextButton(
                  child: const Text("Close"),
                  onPressed: () {
                    _secureStorage.deleteToken();

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginPageNew()),
                      (Route<dynamic> route) => false, // Remove all routes
                    );

                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      } else {}
    }

    return false;
  }

  Future<bool> loadDoneApplicationDetails() async {
    var data = {"CNIC": strCNIC};

    String auth = "Bearer $strToken";

    try {
      final responseBody = await NetworkHelper.loadDoneApplicationDetails(
        data,
        auth,
      );

      if (kDebugMode) {
        print("Just before actual print...Done Applications...");
      }
      if (kDebugMode) {
        print(responseBody.toString());
      }

      String jsonString = responseBody!;

      Map<String, dynamic> data2 = jsonDecode(jsonString);

      //serviceCharges = data2['serviceProviderTaxesConfigurations'];

      // Accessing the pendingDues array
      setState(() {
        doneTransactions = data2['receivedData'];
      });

      for (var element in doneTransactions) {
        if (kDebugMode) {
          print(element["serviceName"]);
        }
      }

      // print("Service Charges: " + serviceCharges.toString());
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Session Expired!"),
            content: Text("Please login again!:"),

            actions: [
              TextButton(
                child: const Text("Close"),
                onPressed: () {
                  _secureStorage.deleteToken();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPageNew()),
                  );
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
  void initState() {
    super.initState();
    fetchSecureStorageData().then((_) async {
      // This block will execute once the token retrieval is complete.
      // You can place additional actions here.
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
        return (await ShowAlertDialogueClass.exitAppDialog(context));
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
                  Padding(
                    padding: EdgeInsets.only(
                      top: Constants.getHomePageMainTextTopPadding(context),
                      left: Constants.getHomePageMainTextLeftPadding(context),
                      right: Constants.getHomePageMainTextRightPadding(context),
                      bottom: Constants.getHomePageMainTextBottomPadding(
                        context,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Paymir',
                          style: TextStyle(
                            fontSize: Constants.getHomePageMainFontSize(
                              context,
                            ),
                            color: const Color(0xff474747),
                            fontFamily: 'Metropolis',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Digital Payment Platform (D2P)',
                          style: TextStyle(
                            fontSize: MediaQuery.sizeOf(context).width * 0.032,
                            color: const Color(0xff474747),
                            fontFamily: 'Metropolis',
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                    'Are you sure you want to logout?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        // Your code here
                                        _secureStorage
                                            .deleteToken()
                                            .then((_) {
                                              Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (_) =>
                                                          const LoginPageNew(),
                                                ),
                                                (route) => false,
                                              );
                                            })
                                            .catchError((error) {
                                              // Handle error here, if needed

                                              if (kDebugMode) {
                                                print(
                                                  "Error occurred while deleting token: $error",
                                                );
                                              }
                                            });
                                      },
                                      child: const Text('Yes'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('No'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child:
                              _image != null
                                  ? ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      Constants.getVerticalGapBetweenTwoTextformfields(
                                            context,
                                          ) *
                                          10,
                                    ),
                                    child: Image.file(
                                      _image!,
                                      width:
                                          Constants.getVerticalGapBetweenTwoTextformfields(
                                            context,
                                          ) *
                                          40,
                                      height:
                                          Constants.getVerticalGapBetweenTwoTextformfields(
                                            context,
                                          ) *
                                          40,
                                    ),
                                  )
                                  : ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      Constants.getVerticalGapBetweenTwoTextformfields(
                                            context,
                                          ) *
                                          10,
                                    ),
                                    child: Image.asset(
                                      'assets/images/homepageicon.png',
                                      width:
                                          Constants.getVerticalGapBetweenTwoTextformfields(
                                            context,
                                          ) *
                                          40,
                                      height:
                                          Constants.getVerticalGapBetweenTwoTextformfields(
                                            context,
                                          ) *
                                          40,
                                    ),
                                  ),
                        ),
                      ],
                    ),
                  ), // First Row
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: Constants.getCardLeftPadding(context),
                            right: Constants.getCardRightPadding(context),
                            bottom: Constants.getCardBottomPadding(context),
                          ),

                          child: Container(
                            height: Constants.getCardHeight(context),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(
                                    Constants.getVerticalGapBetweenTwoTextformfields(
                                      context,
                                    ),
                                  ),
                                  spreadRadius:
                                      Constants.getVerticalGapBetweenTwoTextformfields(
                                        context,
                                      ) *
                                      2,
                                  blurRadius:
                                      Constants.getVerticalGapBetweenTwoTextformfields(
                                        context,
                                      ) *
                                      20,
                                  offset: const Offset(
                                    0,
                                    2,
                                  ), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  Constants.getCardBorderRadius(context),
                                ),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: [
                                  Constants.gradientColor1(),
                                  Constants.gradientColor2(),
                                ],
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(
                                Constants.getCardInsidePadding(context),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Balance\n',
                                              style: TextStyle(
                                                fontSize:
                                                    Constants.getCardSmallFontSize(
                                                      context,
                                                    ),
                                                color: const Color(0xffD3DDE5),
                                                fontFamily: 'Metropolis',
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            TextSpan(
                                              text: '-------- ',
                                              style: TextStyle(
                                                fontSize:
                                                    Constants.getCardMediumFontSize(
                                                      context,
                                                    ),
                                                color:
                                                    Colors
                                                        .white, //Color(0xffD3DDE5),
                                                fontFamily: 'Metropolis',
                                                fontWeight: FontWeight.bold,
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
                                            81,
                                        width:
                                            Constants.getVerticalGapBetweenTwoTextformfields(
                                              context,
                                            ) *
                                            81,
                                        child: SvgPicture.asset(
                                          "assets/images/cardpamirlogo.svg",
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height:
                                        Constants.getVerticalGapBetweenTwoTextformfields(
                                          context,
                                        ) *
                                        15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            strCardNumber,
                                            style: const TextStyle(
                                              //fontSize: 2,//Constants.getCardNumberFontSize(context),
                                              color: Colors.white,
                                              fontFamily: 'OCRAEXTENDED',
                                              fontWeight: FontWeight.normal,
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
                                        ) *
                                        25.5,
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,

                                          children: [
                                            Text(
                                              'CARD HOLDER',
                                              style: TextStyle(
                                                fontSize:
                                                    Constants.getGeneralFontSize(
                                                      context,
                                                    ) *
                                                    0.0130,
                                                color: const Color(0xffD3DDE5),
                                                fontFamily: 'Helvetica',
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            SizedBox(
                                              height:
                                                  Constants.getVerticalGapBetweenTwoTextformfields(
                                                    context,
                                                  ) *
                                                  6,
                                            ),
                                            FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                strCardHolderName,
                                                style: TextStyle(
                                                  color: const Color(
                                                    0xffFFFFFF,
                                                  ),
                                                  fontFamily: 'OCRAEXTENDED',
                                                  fontWeight: FontWeight.normal,
                                                  fontSize:
                                                      Constants.getScreenWidth(
                                                        context,
                                                      ) *
                                                      0.04,
                                                  shadows: const <Shadow>[
                                                    Shadow(
                                                      offset: Offset(0.0, 1.0),
                                                      blurRadius: 1.0,
                                                      color: Color(
                                                        0xff00000080,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              'EXPIRES',
                                              style: TextStyle(
                                                fontSize:
                                                    Constants.getGeneralFontSize(
                                                      context,
                                                    ) *
                                                    0.0128,

                                                color: const Color(0xffD3DDE5),
                                                fontFamily: 'Helvetica',
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            SizedBox(
                                              height:
                                                  Constants.getVerticalGapBetweenTwoTextformfields(
                                                    context,
                                                  ) *
                                                  6,
                                            ),
                                            Text(
                                              strExpiryDate,
                                              style: TextStyle(
                                                fontSize:
                                                    Constants.getGeneralFontSize(
                                                      context,
                                                    ) *
                                                    0.0161,
                                                color: const Color(0xffFFFFFF),
                                                fontFamily: 'OCRAEXTENDED',
                                                fontWeight: FontWeight.normal,
                                                shadows: const <Shadow>[
                                                  Shadow(
                                                    offset: Offset(0.0, 1.0),
                                                    blurRadius: 1.0,
                                                    color: Color(0xff00000080),
                                                  ),
                                                ],
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
                                            55,
                                        width:
                                            Constants.getVerticalGapBetweenTwoTextformfields(
                                              context,
                                            ) *
                                            55,
                                        child: SvgPicture.asset(
                                          "assets/images/cardgovtlogo.svg",
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top:
                          Constants.getVerticalGapBetweenTwoTextformfields(
                            context,
                          ) *
                          7,
                      left:
                          Constants.getHomePageMainTextLeftPadding(context) *
                          2.3,
                      right: Constants.getVerticalGapBetweenTwoTextformfields(
                        context,
                      ),
                      bottom:
                          Constants.getVerticalGapBetweenTwoTextformfields(
                            context,
                          ) *
                          9,
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Services',
                          style: TextStyle(
                            color: const Color(0xff3F3F3F),
                            fontFamily: 'Metropolis',
                            fontWeight: FontWeight.w700,
                            fontSize: Constants.getServiceFontSize(context),
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
                              //showMyGeneraDialog();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DastakPageNew(),
                                ),
                              );
                            },
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.2,
                              height: MediaQuery.sizeOf(context).width * 0.22,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: const Color(0xffF4F6F9),
                                borderRadius: BorderRadius.circular(
                                  MediaQuery.sizeOf(context).width * 0.03,
                                ),
                                border: Border.all(
                                  color: const Color(0xffEBEBEB),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(
                                  MediaQuery.sizeOf(context).width * 0.015,
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(
                                        Constants.getVerticalGapBetweenTwoTextformfields(
                                              context,
                                            ) *
                                            10,
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/images/dastaklogo.svg',
                                        height:
                                            Constants.getSmallFontSize(
                                              context,
                                            ) *
                                            2,
                                        // width: Constants.getSmallFontSize(context) * 3,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top:
                                            Constants.getVerticalGapBetweenTwoTextformfields(
                                              context,
                                            ) *
                                            2,
                                      ),
                                      child: Text(
                                        'Dastak',
                                        style: TextStyle(
                                          color: const Color(0xff3F3F3F),
                                          fontFamily: 'Metropolis',
                                          fontSize: Constants.getSmallFontSize(
                                            context,
                                          ),
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
                              //showMyGeneraDialog();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => VoucherNoPageNew(),
                                ),
                              );
                            },
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.2,
                              height: MediaQuery.sizeOf(context).width * 0.22,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: const Color(0xffF4F6F9),
                                borderRadius: BorderRadius.circular(
                                  MediaQuery.sizeOf(context).width * 0.03,
                                ),
                                border: Border.all(
                                  color: const Color(0xffEBEBEB),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(
                                  MediaQuery.sizeOf(context).width * 0.015,
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(
                                        Constants.getVerticalGapBetweenTwoTextformfields(
                                              context,
                                            ) *
                                            10,
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/images/sidblogo.svg',
                                        height:
                                            Constants.getSmallFontSize(
                                              context,
                                            ) *
                                            2,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top:
                                            Constants.getVerticalGapBetweenTwoTextformfields(
                                              context,
                                            ) *
                                            2,
                                      ),
                                      child: Text(
                                        'SIDB',
                                        style: TextStyle(
                                          color: const Color(0xff3F3F3F),
                                          fontFamily: 'Metropolis',
                                          fontSize: Constants.getSmallFontSize(
                                            context,
                                          ),
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

                              //showMyGeneraDialog();
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => CFCPageNew()),
                              );
                            },
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.2,
                              height: MediaQuery.sizeOf(context).width * 0.22,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: const Color(0xffF4F6F9),
                                borderRadius: BorderRadius.circular(
                                  MediaQuery.sizeOf(context).width * 0.03,
                                ),
                                border: Border.all(
                                  color: const Color(0xffEBEBEB),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(
                                  MediaQuery.sizeOf(context).width * 0.015,
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(
                                        Constants.getVerticalGapBetweenTwoTextformfields(
                                              context,
                                            ) *
                                            10,
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/images/cfclogo.svg',
                                        height:
                                            Constants.getSmallFontSize(
                                              context,
                                            ) *
                                            2,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top:
                                            Constants.getVerticalGapBetweenTwoTextformfields(
                                              context,
                                            ) *
                                            2,
                                      ),
                                      child: Text(
                                        'CFC',
                                        style: TextStyle(
                                          color: const Color(0xff3F3F3F),
                                          fontFamily: 'Metropolis',
                                          fontSize: Constants.getSmallFontSize(
                                            context,
                                          ),
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
                              //showMyGeneraDialog();
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => HEDPageNew()),
                              );
                            },
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.2,
                              height: MediaQuery.sizeOf(context).width * 0.22,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: const Color(0xffF4F6F9),
                                borderRadius: BorderRadius.circular(
                                  MediaQuery.sizeOf(context).width * 0.03,
                                ),
                                border: Border.all(
                                  color: const Color(0xffEBEBEB),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(
                                  MediaQuery.sizeOf(context).width * 0.015,
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(
                                        Constants.getVerticalGapBetweenTwoTextformfields(
                                              context,
                                            ) *
                                            10,
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/images/hedlogo.svg',
                                        height:
                                            Constants.getSmallFontSize(
                                              context,
                                            ) *
                                            2,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top:
                                            Constants.getVerticalGapBetweenTwoTextformfields(
                                              context,
                                            ) *
                                            2,
                                      ),
                                      child: Text(
                                        'HED',
                                        style: TextStyle(
                                          color: const Color(0xff3F3F3F),
                                          fontFamily: 'Metropolis',
                                          fontSize: Constants.getSmallFontSize(
                                            context,
                                          ),
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
                  SizedBox(
                    height:
                        Constants.getVerticalGapBetweenTwoTextformfields(
                          context,
                        ) *
                        15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              // your code here

                              //showMyGeneraDialog();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => VoucherNoPageNew(),
                                ),
                              );
                            },
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.2,
                              height: MediaQuery.sizeOf(context).width * 0.22,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: const Color(0xffF4F6F9),
                                borderRadius: BorderRadius.circular(
                                  MediaQuery.sizeOf(context).width * 0.03,
                                ),
                                border: Border.all(
                                  color: const Color(0xffEBEBEB),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(
                                  MediaQuery.sizeOf(context).width * 0.015,
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(
                                        Constants.getVerticalGapBetweenTwoTextformfields(
                                              context,
                                            ) *
                                            10,
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/images/sportslogo.svg',
                                        height:
                                            Constants.getSmallFontSize(
                                              context,
                                            ) *
                                            2,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top:
                                            Constants.getVerticalGapBetweenTwoTextformfields(
                                              context,
                                            ) *
                                            2,
                                      ),
                                      child: Text(
                                        'Sports',
                                        style: TextStyle(
                                          color: const Color(0xff3F3F3F),
                                          fontFamily: 'Metropolis',
                                          fontSize: Constants.getSmallFontSize(
                                            context,
                                          ),
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
                              //showMyGeneraDialog();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => VoucherNoPageNew(),
                                ),
                              );
                            },
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.2,
                              height: MediaQuery.sizeOf(context).width * 0.22,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: const Color(0xffF4F6F9),
                                borderRadius: BorderRadius.circular(
                                  MediaQuery.sizeOf(context).width * 0.03,
                                ),
                                border: Border.all(
                                  color: const Color(0xffEBEBEB),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(
                                  MediaQuery.sizeOf(context).width * 0.015,
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(
                                        Constants.getVerticalGapBetweenTwoTextformfields(
                                              context,
                                            ) *
                                            10,
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/images/pgmilogo.svg',
                                        height:
                                            Constants.getSmallFontSize(
                                              context,
                                            ) *
                                            2,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top:
                                            Constants.getVerticalGapBetweenTwoTextformfields(
                                              context,
                                            ) *
                                            2,
                                      ),
                                      child: Text(
                                        'PGMI',
                                        style: TextStyle(
                                          color: const Color(0xff3F3F3F),
                                          fontFamily: 'Metropolis',
                                          fontSize: Constants.getSmallFontSize(
                                            context,
                                          ),
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
                              //  showMyGeneraDialog();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => VoucherNoPageNew(),
                                ),
                              );
                            },
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.2,
                              height: MediaQuery.sizeOf(context).width * 0.22,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: const Color(0xffF4F6F9),
                                borderRadius: BorderRadius.circular(
                                  MediaQuery.sizeOf(context).width * 0.03,
                                ),
                                border: Border.all(
                                  color: const Color(0xffEBEBEB),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(
                                  MediaQuery.sizeOf(context).width * 0.015,
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(
                                        Constants.getVerticalGapBetweenTwoTextformfields(
                                              context,
                                            ) *
                                            10,
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/images/assamilogo.svg',
                                        height:
                                            Constants.getSmallFontSize(
                                              context,
                                            ) *
                                            2,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top:
                                            Constants.getVerticalGapBetweenTwoTextformfields(
                                              context,
                                            ) *
                                            2,
                                      ),
                                      child: Text(
                                        'Assami',
                                        style: TextStyle(
                                          color: const Color(0xff3F3F3F),
                                          fontFamily: 'Metropolis',
                                          fontSize: Constants.getSmallFontSize(
                                            context,
                                          ),
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
                              //showMyGeneraDialog();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => MoreServicesPageNew(),
                                ),
                              );
                            },
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.2,
                              height: MediaQuery.sizeOf(context).width * 0.22,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: const Color(0xffF4F6F9),
                                borderRadius: BorderRadius.circular(
                                  MediaQuery.sizeOf(context).width * 0.03,
                                ),
                                border: Border.all(
                                  color: const Color(0xffEBEBEB),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(
                                  MediaQuery.sizeOf(context).width * 0.015,
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(
                                        Constants.getVerticalGapBetweenTwoTextformfields(
                                              context,
                                            ) *
                                            10,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          top:
                                              MediaQuery.sizeOf(context).width *
                                              0.055,
                                        ),
                                        child: SvgPicture.asset(
                                          'assets/images/threedotslogo.svg',
                                          height:
                                              Constants.getSmallFontSize(
                                                context,
                                              ) *
                                              0.5,
                                          width:
                                              Constants.getSmallFontSize(
                                                context,
                                              ) *
                                              0.5,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top:
                                            Constants.getVerticalGapBetweenTwoTextformfields(
                                              context,
                                            ) *
                                            2,
                                      ),
                                      child: Text(
                                        'More',
                                        style: TextStyle(
                                          color: const Color(0xff3F3F3F),
                                          fontFamily: 'Metropolis',
                                          fontSize: Constants.getSmallFontSize(
                                            context,
                                          ),
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
                  Padding(
                    padding: EdgeInsets.only(
                      top:
                          Constants.getVerticalGapBetweenTwoTextformfields(
                            context,
                          ) *
                          15,
                      left: Constants.getVerticalGapBetweenTwoTextformfields(
                        context,
                      ),
                      right: Constants.getVerticalGapBetweenTwoTextformfields(
                        context,
                      ),
                    ),
                    child: Container(
                      color: const Color(0xffFAFCFF),

                      child: DefaultTabController(
                        length: 3,

                        child: SizedBox(
                          height:
                              MediaQuery.sizeOf(context).width *
                              0.505, //MediaQuery.of(context).size.height * 0.39,
                          child: Column(
                            children: <Widget>[
                              TabBar(
                                // indicatorSize: TabBarIndicatorSize.tab,
                                indicatorColor: const Color(0xff3F3F3F),
                                labelColor: const Color(0xff3F3F3F),
                                labelPadding: const EdgeInsets.only(bottom: 0),

                                indicator: UnderlineTabIndicator(
                                  borderSide: BorderSide(
                                    width:
                                        Constants.getVerticalGapBetweenTwoTextformfields(
                                          context,
                                        ) *
                                        4,
                                    color: const Color(0xff6045FF),
                                  ),
                                  insets: EdgeInsets.symmetric(
                                    horizontal:
                                        Constants.getVerticalGapBetweenTwoTextformfields(
                                          context,
                                        ) *
                                        20,
                                  ),
                                ),

                                labelStyle: TextStyle(
                                  fontSize: Constants.getTabSelectedFontSize(
                                    context,
                                  ),
                                  color: const Color(0xff3F3F3F).withOpacity(1),
                                  fontFamily: 'Metropolis',
                                  fontWeight: FontWeight.w800,
                                ), //For Selected tab
                                unselectedLabelStyle: TextStyle(
                                  fontSize: Constants.getTabUnSelectedFontSize(
                                    context,
                                  ),
                                  color: const Color(
                                    0xff3F3F3F,
                                  ).withOpacity(0.55),
                                  fontFamily: 'Metropolis',
                                  fontWeight: FontWeight.w400,
                                ), //For Un-selected Tabs
                                tabs: [
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  0.028,
                                            ),
                                            child: const Tab(
                                              text: "Due Payment",
                                            ),
                                          ),
                                          SizedBox(
                                            width:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                0.055,
                                          ),
                                          Container(
                                            height:
                                                MediaQuery.of(
                                                  context,
                                                ).size.height *
                                                0.025,
                                            width:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                0.004,
                                            color: const Color(
                                              0xff707070,
                                            ).withOpacity(0.70),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  //VerticalDivider(),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  0.06,
                                            ),
                                            child: const Tab(text: "My Paymir"),
                                          ),
                                          SizedBox(
                                            width:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                0.07,
                                          ),
                                          Container(
                                            height:
                                                MediaQuery.of(
                                                  context,
                                                ).size.height *
                                                0.025,
                                            width:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                0.004,
                                            color: const Color(
                                              0xff707070,
                                            ).withOpacity(0.70),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  const Column(children: [Tab(text: "Repay")]),
                                ],
                              ),

                              Expanded(
                                child: TabBarView(
                                  children: <Widget>[
                                    RefreshIndicator(
                                      onRefresh: () async {
                                        // Your code here
                                        if (kDebugMode) {
                                          print("You refreshed the listview");
                                        }
                                        loadApplicationDetails();
                                        loadDoneApplicationDetails();
                                        loadCardDetails();
                                      },
                                      child: ListView.builder(
                                        itemCount: pendingDues.length,
                                        itemBuilder: (
                                          BuildContext context,
                                          int index,
                                        ) {
                                          return InkWell(
                                            onTap: () {
                                              if (kDebugMode) {
                                                print(
                                                  "you clicked on: $index\n${pendingDues[index]}",
                                                );
                                              }
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (_) => PaymentPageNew(
                                                        pendingDues[index],
                                                        serviceCharges,
                                                      ),
                                                ),
                                              );
                                            },
                                            child: Card(
                                              color: const Color(0xffFFFFFF),
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(0.0),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  top:
                                                      Constants.getVerticalGapBetweenTwoTextformfields(
                                                        context,
                                                      ) *
                                                      10,
                                                  left:
                                                      Constants.getVerticalGapBetweenTwoTextformfields(
                                                        context,
                                                      ) *
                                                      20,
                                                  right:
                                                      Constants.getVerticalGapBetweenTwoTextformfields(
                                                        context,
                                                      ) *
                                                      20,
                                                  bottom:
                                                      Constants.getVerticalGapBetweenTwoTextformfields(
                                                        context,
                                                      ) *
                                                      6,
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          15.0,
                                                        ),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: Color(
                                                          0xff0000000a,
                                                        ),
                                                        blurRadius: 21,
                                                        offset: Offset(
                                                          0,
                                                          4,
                                                        ), // changes position of shadow
                                                      ),
                                                    ],
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width:
                                                            Constants.getVerticalGapBetweenTwoTextformfields(
                                                              context,
                                                            ) *
                                                            40,
                                                        height:
                                                            Constants.getVerticalGapBetweenTwoTextformfields(
                                                              context,
                                                            ) *
                                                            40,
                                                        decoration:
                                                            BoxDecoration(
                                                              color:
                                                                  const Color(
                                                                    0xff4B2A7A,
                                                                  ).withOpacity(
                                                                    1,
                                                                  ),
                                                              shape:
                                                                  BoxShape
                                                                      .circle,
                                                            ),
                                                        child: Padding(
                                                          padding: EdgeInsets.all(
                                                            Constants.getVerticalGapBetweenTwoTextformfields(
                                                                  context,
                                                                ) *
                                                                4,
                                                          ),
                                                          child: SvgPicture.asset(
                                                            _list[index]['image']!,
                                                            //height: Constants.getVerticalGapBetweenTwoTextformfields(context)*4,
                                                            //width: Constants.getVerticalGapBetweenTwoTextformfields(context)*4,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            Constants.getVerticalGapBetweenTwoTextformfields(
                                                              context,
                                                            ) *
                                                            25,
                                                      ),
                                                      Expanded(
                                                        child: RichText(
                                                          text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text:
                                                                    pendingDues[index]['serviceName'],
                                                                style: TextStyle(
                                                                  fontSize:
                                                                      Constants.getGeneralFontSize(
                                                                        context,
                                                                      ) *
                                                                      0.016,
                                                                  color: const Color(
                                                                    0xff424242,
                                                                  ),
                                                                  fontFamily:
                                                                      'Metropolis',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text:
                                                                    "\nPending", //"\n"+pendingDues[index]['status']==Null?"Pending":pendingDues[index]['status'],
                                                                style: TextStyle(
                                                                  fontSize:
                                                                      Constants.getGeneralFontSize(
                                                                        context,
                                                                      ) *
                                                                      0.015,
                                                                  color: const Color(
                                                                    0xff424242,
                                                                  ).withOpacity(
                                                                    0.8,
                                                                  ),
                                                                  fontFamily:
                                                                      'Metropolis',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            Constants.getVerticalGapBetweenTwoTextformfields(
                                                              context,
                                                            ) *
                                                            8,
                                                      ),
                                                      Expanded(
                                                        child: RichText(
                                                          textAlign:
                                                              TextAlign.right,
                                                          text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text:
                                                                    "+Rs ${pendingDues[index]['feeAmount']}",
                                                                style: TextStyle(
                                                                  fontSize:
                                                                      Constants.getGeneralFontSize(
                                                                        context,
                                                                      ) *
                                                                      0.021,
                                                                  color: const Color(
                                                                    0xff45C232,
                                                                  ),
                                                                  fontFamily:
                                                                      'Metropolis',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text:
                                                                    "\n${DateFormat('dd/MM/yyyy').format(DateTime.parse(pendingDues[index]['entryDateTime']))}",
                                                                style: TextStyle(
                                                                  fontSize:
                                                                      Constants.getGeneralFontSize(
                                                                        context,
                                                                      ) *
                                                                      0.015,
                                                                  color: const Color(
                                                                    0xff424242,
                                                                  ).withOpacity(
                                                                    0.8,
                                                                  ),
                                                                  fontFamily:
                                                                      'Metropolis',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
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
                                        },
                                      ),
                                    ),
                                    RefreshIndicator(
                                      onRefresh: () async {
                                        // Your code here
                                        if (kDebugMode) {
                                          print("You refreshed the listview");
                                        }
                                        loadApplicationDetails();
                                        loadDoneApplicationDetails();
                                        loadCardDetails();
                                      },
                                      child: ListView.builder(
                                        itemCount: doneTransactions.length,
                                        itemBuilder: (
                                          BuildContext context,
                                          int index,
                                        ) {
                                          return InkWell(
                                            onTap: () {
                                              if (kDebugMode) {
                                                print(
                                                  "you clicked on: $index\n${doneTransactions[index]}",
                                                );
                                              }
                                              //Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>PaymentPageNew(pendingDues[index],serviceCharges)));

                                              doneTransactions[index].forEach((
                                                key,
                                                value,
                                              ) {
                                                if (kDebugMode) {
                                                  print('$key: $value');
                                                }
                                              });

                                              String formatDate(String date) {
                                                DateTime dateTime =
                                                    DateTime.parse(date);
                                                String formattedDate =
                                                    DateFormat(
                                                      'dd MMMM yyyy hh:mm a',
                                                    ).format(dateTime);
                                                return formattedDate;
                                              }

                                              String output = '';
                                              doneTransactions[index].forEach((
                                                key,
                                                value,
                                              ) {
                                                switch (key) {
                                                  case 'dptPaymentID':
                                                    key = 'Payment Id';
                                                    break;
                                                  case 'serviceName':
                                                    key = 'Service Name';
                                                    break;
                                                  case 'cnic':
                                                    key = 'CNIC';
                                                    break;
                                                  case 'feeAmount':
                                                    key = 'Fee amount';
                                                    break;
                                                  case 'paymentDate':
                                                    key = 'Payment date';
                                                    value = formatDate(value);
                                                    break;
                                                  case 'serviceTypeName':
                                                    key = 'Service Type Name';
                                                    break;
                                                  case 'departmentName':
                                                    key = 'Department name';
                                                    break;
                                                  case 'ePayExpireDate':
                                                    key = 'Expiry date';
                                                    value = formatDate(value);
                                                    break;
                                                  case 'serviceKey':
                                                    key = 'Service Key';
                                                    break;
                                                  case 'serviceProviderName':
                                                    key =
                                                        'Service provider name';
                                                    break;
                                                  case 'paymentMode':
                                                    key = 'Payment Mode';
                                                    break;
                                                  case 'usedMobileAccount':
                                                    key = 'Mobile account used';
                                                    break;
                                                  case 'serviceFee':
                                                    key = 'Service fee';
                                                    break;
                                                  case 'serviceCharges':
                                                    key = 'Service fee';
                                                    break;
                                                  case 'totalAmountPaidByCitizen':
                                                    key = 'Total amount paid';
                                                    break;
                                                }
                                                output += '$key:\n$value\n\n';
                                              });

                                              showDialog(
                                                context: context,
                                                builder: (
                                                  BuildContext context,
                                                ) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                      'Done Transaction',
                                                    ),
                                                    content:
                                                        SingleChildScrollView(
                                                          child: Text(output),
                                                        ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed:
                                                            () => Navigator.pop(
                                                              context,
                                                            ),
                                                        child: const Text(
                                                          'Close',
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                              //print(doneTransactions[index]{});
                                            },
                                            child: Card(
                                              color: const Color(0xffFFFFFF),
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(0.0),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  top:
                                                      Constants.getVerticalGapBetweenTwoTextformfields(
                                                        context,
                                                      ) *
                                                      10,
                                                  left:
                                                      Constants.getVerticalGapBetweenTwoTextformfields(
                                                        context,
                                                      ) *
                                                      20,
                                                  right:
                                                      Constants.getVerticalGapBetweenTwoTextformfields(
                                                        context,
                                                      ) *
                                                      20,
                                                  bottom:
                                                      Constants.getVerticalGapBetweenTwoTextformfields(
                                                        context,
                                                      ) *
                                                      6,
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          15.0,
                                                        ),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: Color(
                                                          0xff0000000a,
                                                        ),
                                                        blurRadius: 21,
                                                        offset: Offset(
                                                          0,
                                                          4,
                                                        ), // changes position of shadow
                                                      ),
                                                    ],
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width:
                                                            Constants.getVerticalGapBetweenTwoTextformfields(
                                                              context,
                                                            ) *
                                                            40,
                                                        height:
                                                            Constants.getVerticalGapBetweenTwoTextformfields(
                                                              context,
                                                            ) *
                                                            40,
                                                        decoration:
                                                            BoxDecoration(
                                                              color:
                                                                  const Color(
                                                                    0xff4B2A7A,
                                                                  ).withOpacity(
                                                                    1,
                                                                  ),
                                                              shape:
                                                                  BoxShape
                                                                      .circle,
                                                            ),
                                                        child: Padding(
                                                          padding: EdgeInsets.all(
                                                            Constants.getVerticalGapBetweenTwoTextformfields(
                                                                  context,
                                                                ) *
                                                                4,
                                                          ),

                                                          child: SvgPicture.asset(
                                                            _list[index]['image']!,
                                                          ),
                                                        ),
                                                      ),

                                                      SizedBox(
                                                        width:
                                                            Constants.getVerticalGapBetweenTwoTextformfields(
                                                              context,
                                                            ) *
                                                            25,
                                                      ),

                                                      Expanded(
                                                        child: RichText(
                                                          text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text:
                                                                    doneTransactions[index]['serviceName'],
                                                                style: TextStyle(
                                                                  fontSize:
                                                                      Constants.getGeneralFontSize(
                                                                        context,
                                                                      ) *
                                                                      0.016,
                                                                  color: const Color(
                                                                    0xff424242,
                                                                  ),
                                                                  fontFamily:
                                                                      'Metropolis',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text:
                                                                    "\nPaid", //"\n"+pendingDues[index]['status']==Null?"Pending":pendingDues[index]['status'],
                                                                style: TextStyle(
                                                                  fontSize:
                                                                      Constants.getGeneralFontSize(
                                                                        context,
                                                                      ) *
                                                                      0.015,
                                                                  color:
                                                                      Colors
                                                                          .green,
                                                                  fontFamily:
                                                                      'Metropolis',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            Constants.getVerticalGapBetweenTwoTextformfields(
                                                              context,
                                                            ) *
                                                            8,
                                                      ),

                                                      Expanded(
                                                        child: RichText(
                                                          textAlign:
                                                              TextAlign.right,
                                                          text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text:
                                                                    "+Rs ${doneTransactions[index]['feeAmount']}",
                                                                style: TextStyle(
                                                                  fontSize:
                                                                      Constants.getGeneralFontSize(
                                                                        context,
                                                                      ) *
                                                                      0.021,
                                                                  color: const Color(
                                                                    0xff45C232,
                                                                  ),
                                                                  fontFamily:
                                                                      'Metropolis',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text:
                                                                    "\n${DateFormat('dd/MM/yyyy').format(DateTime.parse(doneTransactions[index]['paymentDate']))}",

                                                                //                                                                text:  "\n" +doneTransactions[index]['paymentDate'],//+ (DateFormat('dd/MM/yyyy').format(DateTime.parse(doneTransactions[index]['paymentDate']))).toString(),
                                                                style: TextStyle(
                                                                  fontSize:
                                                                      Constants.getGeneralFontSize(
                                                                        context,
                                                                      ) *
                                                                      0.015,
                                                                  color: const Color(
                                                                    0xff424242,
                                                                  ).withOpacity(
                                                                    0.8,
                                                                  ),
                                                                  fontFamily:
                                                                      'Metropolis',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
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
                                        },
                                      ),
                                    ),
                                    const Text(
                                      'Oftenly used transactions will be displayed here',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xffFAFCFF),
          selectedItemColor: const Color(0xff424242),
          //unselectedItemColor: Colors.grey,
          selectedLabelStyle: TextStyle(
            color: const Color(0xff424242),
            fontFamily: 'Metropolis',
            fontSize: Constants.getGeneralFontSize(context) * 0.016,
            fontWeight: FontWeight.bold,
          ),

          unselectedLabelStyle: TextStyle(
            color: const Color(0xff424242).withOpacity(0.80),
            fontFamily: 'Metropolis',
            fontSize: Constants.getGeneralFontSize(context) * 0.014,
            fontWeight: FontWeight.w500,
          ),

          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SizedBox(
                width: MediaQuery.of(context).size.width * 0.07,
                height: MediaQuery.of(context).size.width * 0.07,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: SvgPicture.asset(
                    'assets/images/homeicon.svg',
                    color: Colors.grey,
                  ),
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: MediaQuery.of(context).size.width * 0.055,
                height: MediaQuery.of(context).size.width * 0.055,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: SvgPicture.asset(
                    'assets/images/paymentbottomlogo.svg',
                    color: Colors.grey,
                  ),
                ),
              ),
              label: 'Voucher no',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: MediaQuery.of(context).size.width * 0.055,
                height: MediaQuery.of(context).size.width * 0.055,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: SvgPicture.asset(
                    'assets/images/qrcodeicon.svg',
                    color: Colors.grey,
                  ),
                ),
              ),
              label: 'Qpay',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: MediaQuery.of(context).size.width * 0.055,
                height: MediaQuery.of(context).size.width * 0.055,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: SvgPicture.asset(
                    'assets/images/settingsicon.svg',
                    color: Colors.grey,
                  ),
                ),
              ),
              label: 'Setting',
            ),
          ],

          // selectedLabelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(fontFamily: 'Metropolis', fontWeight: FontWeight.bold),
          currentIndex: _selectedIndex,
          onTap: (int index) async {
            switch (index) {
              case 0:
                if (kDebugMode) {
                  print('Home pressed');
                }
                _onItemTapped(0);
                break;
              case 1:
                _onItemTapped(1);
                //Navigator.push(context, MaterialPageRoute(builder: (_)=>const HistoryPaymentPageNew()));
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => VoucherNoPageNew()),
                );

                break;
              case 2:
                _onItemTapped(2);
                final PermissionStatus permissionStatus =
                    await Permission.camera.request();
                if (permissionStatus == PermissionStatus.granted) {
                  if (kDebugMode) {
                    print('Camera permission granted');
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => QRCodeScanner(serviceCharges),
                    ),
                  );
                } else {
                  if (kDebugMode) {
                    print('Camera permission not granted');
                  }
                }
                break;
              case 3:
                _onItemTapped(3);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => ProfilePageNew(strCNIC, profileDataJsonObject),
                  ),
                );
                break;
            }
          },
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

  Future<bool> loadData() async {
    var data = {"CNIC": strCNIC};

    String auth = "Bearer $strToken";

    try {
      final responseBody = await NetworkHelper.getProfileDetail(data, auth);

      profileDataJsonObject = jsonDecode(responseBody!);

      if (kDebugMode) {
        print("Header: " + auth);
        print("data object: " + data.toString());
        print("CNIC used: " + strCNIC);
        print("Response: " + responseBody);
      }

      if (profileDataJsonObject["statusCode"] == "204") {
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
              content: Text(profileDataJsonObject["responseMessage"]),
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
      } else {
        {
          setState(() {
            //  _makeButtonEnabled = false;

            String fullName = profileDataJsonObject['fullName'].toString();
            List<String> names = fullName.split(' ');

            if (names.length > 2) {}
          });
        }
      }

      if (kDebugMode) {
        print(
          "profileDataJsonObject checking: ${profileDataJsonObject['fullName']}",
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Session Expired"),
            content: Text("Please login again!:\n" + e.toString()),

            actions: [
              TextButton(
                child: const Text("Close"),
                onPressed: () {
                  _secureStorage.deleteToken();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPageNew()),
                  );
                },
              ),
            ],
          );
        },
      );
    }
    return false;
  }

  void showMyGeneraDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (
        BuildContext buildContext,
        Animation animation,
        Animation secondaryAnimation,
      ) {
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
                    width: Constants.getButtonHeight(context) * 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Constants.gradientColor1(),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
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
