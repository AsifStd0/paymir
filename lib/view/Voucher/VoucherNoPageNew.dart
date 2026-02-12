import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:paymir_new_android/core/theme/app_colors.dart';

import '../../util/AlertDialogueClass.dart';
import '../../util/Constants.dart';
import '../../util/MyValidation.dart';
import '../../util/NetworkHelperClass.dart';
import '../../util/SecureStorage.dart';
import '../PaymentPageNew.dart';

class VoucherNoPageNew extends StatefulWidget {
  const VoucherNoPageNew({super.key});

  @override
  _VoucherNoPageNewState createState() => _VoucherNoPageNewState();
}

class _VoucherNoPageNewState extends State<VoucherNoPageNew> {
  int _selectedIndex = 0;

  bool _isLoading = false;

  late var textController =
      new TextEditingController(); //= MaskedTextController(mask: 'xxxx-0000-00-000000');

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
  String cnicString = "";

  Future<String?> loadApplicationDetails(String dtpPaymentID) async {
    var data = {
      "DPTPaymentID": dtpPaymentID,
      "CNIC": cnicString,
      "Using": "DPTPayID",
      "PaymentPlatform": "Jazz Cash",
      "PaymentMode": "MobileWallet",
    };

    String auth = "Bearer $strToken";

    try {
      final responseBody = await NetworkHelper.getPendingTransactions(
        data,
        auth,
      );

      if (kDebugMode) {
        print("response: " + responseBody.toString());
      }

      setState(() {
        _isLoading = false;
      });

      try {
        if (responseBody!.contains("false")) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("No record found!"),
                actions: [
                  TextButton(
                    child: const Text("OK"),
                    onPressed: () {
                      setState(() {
                        _isLoading = false;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
          return "false";
        } else {
          String jsonString = responseBody;

          Map<String, dynamic> data2 = jsonDecode(jsonString);

          //serviceCharges = data2['serviceProviderTaxesConfigurations'];

          // Accessing the pendingDues array
          setState(() {
            pendingDues = data2['pendingDues'];
            serviceCharges = data2['serviceProviderTaxesConfigurations'];
          });

          // for (var element in pendingDues) {
          // }

          for (var i = 0; i < serviceCharges.length; i++) {
            List<dynamic> paymentServiceCharges =
                serviceCharges[i]['paymentServiceCharges'];

            for (var j = 0; j < paymentServiceCharges.length; j++) {}
          }

          try {
            await Future.delayed(const Duration(seconds: 1), () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => PaymentPageNew(pendingDues[0], serviceCharges),
                ),
              );
            });
          } catch (e) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("No record found!"),
                  actions: [
                    TextButton(
                      child: const Text("OK"),
                      onPressed: () {
                        setState(() {
                          _isLoading = false;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );
            Navigator.pop(context);
          }

          return "false";
        }
      } //try end
      catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("No record found!"),
              actions: [
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    setState(() {
                      _isLoading = false;
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );

        Navigator.pop(context);
      }
    } catch (e) {
      // print(e);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text("Server is down and cannot be accessed!"),
            actions: [
              TextButton(
                child: const Text("Close"),
                onPressed: () {
                  setState(() {
                    _isLoading = false;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    return "false";
  }

  Future<void> fetchSecureStorageData() async {
    strToken = await _secureStorage.getToken() ?? '';
    strTokenExpiry = await _secureStorage.getTokenExpiry() ?? '';
    cnicString = await _secureStorage.getCNIC() ?? '';
    // _passwordController.text = await _secureStorage.getPassWord() ?? '';
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // TODO SAVE DATA
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSecureStorageData();
    Future.delayed(const Duration(milliseconds: 2900), () {});

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
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
        // You can add your logic or show a dialog here if needed
        Navigator.of(context).pop();
        return false; // Prevent the default back navigation
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
                  //     Padding(
                  //       padding: EdgeInsets.only(
                  //           top:Constants.getHomePageMainTextTopPadding(context),
                  //           left: Constants.getHomePageMainTextLeftPadding(context),
                  //           right: Constants.getHomePageMainTextRightPadding(context),
                  //           bottom:Constants.getHomePageMainTextBottomPadding(context)
                  //       ),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Text(
                  //               'HED',
                  //               style: TextStyle(
                  //                   fontSize:Constants.getHomePageMainFontSize(context),
                  //                   color: const Color(0xff474747),
                  //                   fontFamily: 'Metropolis',
                  //                   fontWeight:FontWeight.bold
                  //               )
                  //           ),
                  //           Text(
                  //               'Higher Education Department',
                  //               style: TextStyle(
                  //
                  //                   fontSize:MediaQuery.sizeOf(context).width*0.032,
                  //                   color: const Color(0xff474747),
                  //                   fontFamily: 'Metropolis',
                  //                   fontWeight:FontWeight.w600
                  //               )
                  //           ),
                  //
                  // GestureDetector(
                  //   onTap: () {
                  //
                  //   },
                  //   child: _image != null ? ClipRRect(
                  //     borderRadius: BorderRadius.circular(Constants.getVerticalGapBetweenTwoTextformfields(context)*10),
                  //     child: Image.file(
                  //       _image!,
                  //       width: Constants.getVerticalGapBetweenTwoTextformfields(context)*40,
                  //       height: Constants.getVerticalGapBetweenTwoTextformfields(context)*40,
                  //     ),
                  //   ) : ClipRRect(
                  //     borderRadius: BorderRadius.circular(Constants.getVerticalGapBetweenTwoTextformfields(context)*10),
                  //     child: SvgPicture.asset(
                  //       'assets/images/hedlogo.svg',
                  //       width: Constants.getVerticalGapBetweenTwoTextformfields(context) * 40,
                  //       height: Constants.getVerticalGapBetweenTwoTextformfields(context) * 40,
                  //     ),
                  //   ),
                  // ),
                  // ],
                  //       ),
                  //     ),// First Row
                  Padding(
                    padding: EdgeInsets.only(
                      top:
                          Constants.getVerticalGapBetweenTwoTextformfields(
                            context,
                          ) *
                          50,
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
                          'Enter your voucher number',
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
                      SizedBox(
                        height: Constants.getTextFormFieldHeight(context),
                        width: MediaQuery.of(context).size.width * 0.79,
                        child: TextFormField(
                          maxLength: 19,
                          textAlign: TextAlign.start,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            hintText: "",
                            hintStyle: TextStyle(
                              fontSize: Constants.getTextformfieldHintFont(
                                context,
                              ),
                              color: AppColors.secondaryColor(),
                              fontFamily: 'Visby',
                              fontWeight: FontWeight.normal,
                            ),
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
                              bottom: Constants.getTextformfieldContentPadding(
                                context,
                              ),
                            ),
                          ),
                          controller: textController,
                          // keyboardType: TextInputType.number,
                          validator:
                              (value) =>
                                  MyValidationClass.validateVoucher(value),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height:
                        Constants.getVerticalGapBetweenTwoTextformfields(
                          context,
                        ) *
                        1,
                  ),

                  // SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  Center(
                    child: TextButton(
                      onPressed: () async {
                        _submit();
                        if (MyValidationClass.validateVoucher(
                              textController.text,
                            ) ==
                            null) {
                          //enquirePSID();
                          setState(() {
                            _isLoading = true;
                          });
                          if (await NetworkHelper.checkInternetConnection()) {
                            loadApplicationDetails(textController.text);
                          } else {
                            ShowAlertDialogueClass.showAlertDialogue(
                              context: context,
                              title: "No Internet",
                              message: "Check your internet connection!",
                              buttonText: "OK",
                              iconData: Icons.error,
                            );
                          }
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width:
                            Constants.getButtonHeight(context) *
                            5, //double.infinity,
                        height: Constants.getButtonHeight(context),

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(Constants.getButtonRadius(context)),
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
                                  'Check Payment Details',
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

                  //                     Padding(
                  //                       padding: EdgeInsets.only(
                  //                           top:Constants.getVerticalGapBetweenTwoTextformfields(context)*15,
                  //                           left:Constants.getVerticalGapBetweenTwoTextformfields(context),
                  //                           right:Constants.getVerticalGapBetweenTwoTextformfields(context),
                  //
                  //                       ),
                  //                       child: Container(
                  //                         color: const Color(0xffFAFCFF),
                  //
                  //                         child: DefaultTabController(
                  //
                  //                           length: 3,
                  //
                  //                           child: SizedBox(
                  //                             height: MediaQuery.sizeOf(context).width * 0.505,//MediaQuery.of(context).size.height * 0.39,
                  //                             child: Column(
                  //                               children: <Widget>[
                  //                                     TabBar(
                  //                                        // indicatorSize: TabBarIndicatorSize.tab,
                  //                                         indicatorColor: const Color(0xff3F3F3F),
                  //                                         labelColor: const Color(0xff3F3F3F),
                  //                                         labelPadding: const EdgeInsets.only(bottom: 0),
                  //
                  //                                         indicator: UnderlineTabIndicator(
                  //                                           borderSide: BorderSide(
                  //                                               width: Constants.getVerticalGapBetweenTwoTextformfields(context)*4,
                  //                                               color: const Color(0xff6045FF)
                  //                                           ),
                  //                                           insets: EdgeInsets.symmetric(
                  //                                               horizontal:Constants.getVerticalGapBetweenTwoTextformfields(context)*20
                  //                                           ),
                  //                                         ),
                  //
                  //                                         labelStyle: TextStyle(
                  //                                             fontSize:Constants.getTabSelectedFontSize(context),
                  //                                             color: const Color(0xff3F3F3F).withOpacity(1),
                  //                                             fontFamily: 'Metropolis',
                  //                                             fontWeight:FontWeight.w800
                  //                                         ), //For Selected tab
                  //                                         unselectedLabelStyle: TextStyle(
                  //                                             fontSize:Constants.getTabUnSelectedFontSize(context),
                  //                                             color: const Color(0xff3F3F3F).withOpacity(0.55),
                  //                                             fontFamily: 'Metropolis',
                  //                                             fontWeight:FontWeight.w400
                  //                                         ), //For Un-selected Tabs
                  //                                   tabs: [
                  //                                       Column(
                  //                                         children: [
                  //
                  //                                           Row(
                  //                                             children: [
                  //                                               Padding(
                  //                                                 padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width * 0.034),
                  //                                                 child: const Tab(
                  //                                                   text: "Due Payment",
                  //                                                 ),
                  //                                               ),
                  //                                               SizedBox(width: MediaQuery.of(context).size.width * 0.055),
                  //                                               Container(
                  //                                                 height: MediaQuery.of(context).size.height * 0.025,
                  //                                                 width: MediaQuery.of(context).size.width * 0.004,
                  //                                                 color: const Color(0xff707070).withOpacity(0.70),
                  //                                               ),
                  //                                             ],
                  //                                           )
                  //                                         ],
                  //                                       ),
                  //                                    //VerticalDivider(),
                  //                                     Column(
                  //                                       children: [
                  //
                  //                                         Row(
                  //                                           children: [
                  //                                             Padding(
                  //                                               padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width * 0.07),
                  //                                               child: const Tab(
                  //                                                 text: "My Paymir",
                  //                                               ),
                  //                                             ),
                  //                                             SizedBox(width: MediaQuery.of(context).size.width * 0.07),
                  //                                             Container(
                  //                                               height: MediaQuery.of(context).size.height * 0.025,
                  //                                               width: MediaQuery.of(context).size.width * 0.004,
                  //                                               color: const Color(0xff707070).withOpacity(0.70),
                  //                                             ),
                  //                                           ],
                  //                                         )
                  //                                       ],
                  //                                     ),
                  //
                  //                                       const Column(
                  //                                         children: [
                  //                                           Tab(
                  //                                             text: "Repay",
                  //                                           ),
                  //                                         ],
                  //                                       ),
                  //                                   ],
                  //                                 ),
                  //
                  //                                 Expanded(
                  //                                     child: TabBarView(
                  //                                       children: <Widget>[
                  //                                         RefreshIndicator(
                  //                                           onRefresh: () async {
                  //                                             // Your code here
                  //                                             if (kDebugMode) {
                  //                                               print("You refreshed the listview");
                  //                                             }
                  //                                             loadApplicationDetails();
                  //                                             loadDoneApplicationDetails();
                  //                                             loadCardDetails();
                  //                                           },
                  //                                           child: ListView.builder(
                  //                                             itemCount: pendingDues.length,
                  //                                             itemBuilder: (BuildContext context, int index) {
                  //                                               return
                  //                                                 InkWell( onTap: () {
                  //                                                   if (kDebugMode) {
                  //                                                     print("you clicked on: $index\n${pendingDues[index]}");
                  //
                  //                                                   }
                  //                                                   print("Pendingdues object: " +pendingDues[index].toString());
                  //                                                   Navigator.push(context, MaterialPageRoute(builder: (_)=>PaymentPageNew(pendingDues[index],serviceCharges)));
                  //                                                 },
                  //                                                   child: Card(
                  //                                                       color: const Color(0xffFFFFFF),
                  //                                                     elevation: 0,
                  //                                                     shape: RoundedRectangleBorder(
                  //                                                       borderRadius: BorderRadius.circular(0.0),
                  //                                                     ),
                  //                                                     child: Padding(
                  //                                                       padding: EdgeInsets.only(
                  //                                                           top: Constants.getVerticalGapBetweenTwoTextformfields(context)*10,
                  //                                                           left:Constants.getVerticalGapBetweenTwoTextformfields(context)*20,
                  //                                                           right:Constants.getVerticalGapBetweenTwoTextformfields(context)*20,
                  //                                                           bottom:Constants.getVerticalGapBetweenTwoTextformfields(context)*6
                  //                                                       ),
                  //                                                       child:
                  //
                  //                                                       Container(
                  //                                                         decoration: BoxDecoration(
                  //                                                           borderRadius: BorderRadius.circular(15.0),
                  //                                                           boxShadow: const [
                  //                                                             BoxShadow(
                  //                                                               color: Color(0xff0000000a),
                  //                                                               blurRadius: 21,
                  //                                                               offset: Offset(0, 4), // changes position of shadow
                  //                                                             ),
                  //                                                           ],
                  //                                                         ),
                  //                                                         child: Row(
                  //                                                           children: [
                  //                                                             Container(
                  //                                                               width: Constants.getVerticalGapBetweenTwoTextformfields(context)*40,
                  //                                                               height: Constants.getVerticalGapBetweenTwoTextformfields(context)*40,
                  //                                                               decoration: BoxDecoration(
                  //                                                                 color: const Color(0xff4B2A7A).withOpacity(1),
                  //                                                                 shape: BoxShape.circle,
                  //                                                               ),
                  //                                                               child: Padding(
                  //                                                                 padding: EdgeInsets.all(Constants.getVerticalGapBetweenTwoTextformfields(context)*4),
                  //                                                                 child: SvgPicture.asset(
                  //                                                                   _list[index]['image']!,
                  //                                                                   //height: Constants.getVerticalGapBetweenTwoTextformfields(context)*4,
                  //                                                                   //width: Constants.getVerticalGapBetweenTwoTextformfields(context)*4,
                  //                                                                 ),
                  //                                                               ),
                  //                                                             ),
                  //                                                             SizedBox(width: Constants.getVerticalGapBetweenTwoTextformfields(context)*25),
                  //                                                             Expanded(
                  //                                                               child: RichText(
                  //                                                                 text: TextSpan(
                  //                                                                   children: [
                  //                                                                     TextSpan(
                  //                                                                       text:  pendingDues[index]['serviceName'],
                  //                                                                       style: TextStyle(
                  //                                                                           fontSize:Constants.getGeneralFontSize(context)*0.016,
                  //                                                                           color: const Color(0xff424242),
                  //                                                                           fontFamily: 'Metropolis',
                  //                                                                           fontWeight:FontWeight.w700
                  //                                                                       ),
                  //                                                                     ),
                  //                                                                     TextSpan(
                  //
                  //                                                                       text: "\nPending",//"\n"+pendingDues[index]['status']==Null?"Pending":pendingDues[index]['status'],
                  //                                                                       style: TextStyle(
                  //                                                                           fontSize:Constants.getGeneralFontSize(context)*0.015,
                  //                                                                           color: const Color(0xff424242).withOpacity(0.8),
                  //                                                                           fontFamily: 'Metropolis',
                  //                                                                           fontWeight:FontWeight.w400
                  //                                                                       ),
                  //                                                                     ),
                  //                                                                   ],
                  //                                                                 ),
                  //                                                               ),
                  //                                                             ),
                  //                                                             SizedBox(width: Constants.getVerticalGapBetweenTwoTextformfields(context)*8),
                  //                                                             Expanded(
                  //                                                               child: RichText(
                  //                                                                 textAlign: TextAlign.right,
                  //                                                                 text: TextSpan(
                  //                                                                   children: [
                  //                                                                     TextSpan(
                  //                                                                       text:  "+Rs ${pendingDues[index]['feeAmount']}",
                  //                                                                       style: TextStyle(
                  //                                                                           fontSize:Constants.getGeneralFontSize(context)*0.021,
                  //                                                                           color: const Color(0xff45C232),
                  //                                                                           fontFamily: 'Metropolis',
                  //                                                                           fontWeight:FontWeight.w700
                  //                                                                       ),
                  //                                                                     ),
                  //                                                                     TextSpan(
                  //                                                                       text:  "\n${DateFormat('dd/MM/yyyy').format(DateTime.parse(pendingDues[index]['entryDateTime']))}",
                  //                                                                       style: TextStyle(
                  //                                                                           fontSize:Constants.getGeneralFontSize(context)*0.015,
                  //                                                                           color: const Color(0xff424242).withOpacity(0.8),
                  //                                                                           fontFamily: 'Metropolis',
                  //                                                                           fontWeight:FontWeight.w400
                  //                                                                       ),
                  //                                                                     ),
                  //                                                                   ],
                  //                                                                 ),
                  //                                                               ),
                  //                                                             ),
                  //                                                           ],
                  //                                                         ),
                  //                                                       ),
                  //                                                     ),
                  //                                                   ),
                  //                                                 );
                  //                                             },
                  //                                           ),
                  //                                         ),
                  //                                         RefreshIndicator(
                  //                                           onRefresh: () async {
                  //                                             // Your code here
                  //                                             if (kDebugMode) {
                  //                                               print("You refreshed the listview");
                  //                                             }
                  //                                             loadApplicationDetails();
                  //                                             loadDoneApplicationDetails();
                  //                                             loadCardDetails();
                  //                                           },
                  //                                           child: ListView.builder(
                  //                                             itemCount: doneTransactions.length,
                  //                                             itemBuilder: (BuildContext context, int index) {
                  //                                               return
                  //                                                 InkWell( onTap: () {
                  //                                                   if (kDebugMode) {
                  //                                                     print("you clicked on: $index\n${doneTransactions[index]}");
                  //                                                   }
                  //                                                   //Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>PaymentPageNew(pendingDues[index],serviceCharges)));
                  //
                  //                                                   doneTransactions[index].forEach((key, value) {
                  //                                                     if (kDebugMode) {
                  //                                                       print('$key: $value');
                  //                                                     }
                  //                                                   });
                  //
                  //                                                   String formatDate(String date) {
                  //                                                     DateTime dateTime = DateTime.parse(date);
                  //                                                     String formattedDate = DateFormat('dd MMMM yyyy hh:mm a').format(dateTime);
                  //                                                     return formattedDate;
                  //                                                   }
                  //
                  //                                                   String output = '';
                  //                                                   doneTransactions[index].forEach((key, value) {
                  //                                                     switch (key) {
                  //                                                       case 'dptPaymentID':
                  //                                                         key = 'Payment Id';
                  //                                                         break;
                  //                                                       case 'serviceName':
                  //                                                         key = 'Service Name';
                  //                                                         break;
                  //                                                       case 'cnic':
                  //                                                         key = 'CNIC';
                  //                                                         break;
                  //                                                       case 'feeAmount':
                  //                                                         key = 'Fee amount';
                  //                                                         break;
                  //                                                       case 'paymentDate':
                  //                                                         key = 'Payment date';
                  //                                                         value = formatDate(value);
                  //                                                         break;
                  //                                                       case 'serviceTypeName':
                  //                                                         key = 'Service Type Name';
                  //                                                         break;
                  //                                                       case 'departmentName':
                  //                                                         key = 'Department name';
                  //                                                         break;
                  //                                                       case 'ePayExpireDate':
                  //                                                         key = 'Expiry date';
                  //                                                         value = formatDate(value);
                  //                                                         break;
                  //                                                       case 'serviceKey':
                  //                                                         key = 'Service Key';
                  //                                                         break;
                  //                                                       case 'serviceProviderName':
                  //                                                         key = 'Service provider name';
                  //                                                         break;
                  //                                                       case 'paymentMode':
                  //                                                         key = 'Payment Mode';
                  //                                                         break;
                  //                                                       case 'usedMobileAccount':
                  //                                                         key = 'Mobile account used';
                  //                                                         break;
                  //                                                       case 'serviceFee':
                  //                                                         key = 'Service fee';
                  //                                                         break;
                  //                                                       case 'serviceCharges':
                  //                                                         key = 'Service fee';
                  //                                                         break;
                  //                                                       case 'totalAmountPaidByCitizen':
                  //                                                         key = 'Total amount paid';
                  //                                                         break;
                  //                                                     }
                  //                                                     output += '$key:\n$value\n\n';
                  //                                                   });
                  //
                  //                                                   showDialog(
                  //                                                     context: context,
                  //                                                     builder: (BuildContext context) {
                  //                                                       return AlertDialog(
                  //                                                         title: const Text('Done Transaction'),
                  //                                                         content: SingleChildScrollView(
                  //                                                           child: Text(output),
                  //                                                         ),
                  //                                                         actions: <Widget>[
                  //                                                           TextButton(
                  //                                                             onPressed: () => Navigator.pop(context),
                  //                                                             child: const Text('Close'),
                  //                                                           ),
                  //                                                         ],
                  //                                                       );
                  //                                                     },
                  //                                                   );
                  //                                                   //print(doneTransactions[index]{});
                  //                                                 },
                  //                                                   child: Card(
                  //                                                     color: const Color(0xffFFFFFF),
                  //                                                     elevation: 0,
                  //                                                     shape: RoundedRectangleBorder(
                  //                                                       borderRadius: BorderRadius.circular(0.0),
                  //                                                     ),
                  //                                                     child: Padding(
                  //                                                       padding:  EdgeInsets.only(
                  //                                                           top: Constants.getVerticalGapBetweenTwoTextformfields(context)*10,
                  //                                                           left:Constants.getVerticalGapBetweenTwoTextformfields(context)*20,
                  //                                                           right:Constants.getVerticalGapBetweenTwoTextformfields(context)*20,
                  //                                                           bottom:Constants.getVerticalGapBetweenTwoTextformfields(context)*6),
                  //                                                       child:
                  //
                  //                                                       Container(
                  //                                                         decoration: BoxDecoration(
                  //                                                           borderRadius: BorderRadius.circular(15.0),
                  //                                                           boxShadow: const [
                  //                                                             BoxShadow(
                  //                                                               color: Color(0xff0000000a),
                  //                                                               blurRadius: 21,
                  //                                                               offset: Offset(0, 4), // changes position of shadow
                  //                                                             ),
                  //                                                           ],
                  //                                                         ),
                  //                                                         child: Row(
                  //                                                           children: [
                  //                                                             Container(
                  //                                                               width: Constants.getVerticalGapBetweenTwoTextformfields(context)*40,
                  //                                                               height: Constants.getVerticalGapBetweenTwoTextformfields(context)*40,
                  //                                                               decoration: BoxDecoration(
                  //                                                                 color: const Color(0xff4B2A7A).withOpacity(1),
                  //                                                                 shape: BoxShape.circle,
                  //                                                               ),
                  //                                                               child: Padding(
                  //                                                                 padding: EdgeInsets.all(Constants.getVerticalGapBetweenTwoTextformfields(context)*4),
                  //
                  //                                                                 child: SvgPicture.asset(
                  //                                                                   _list[index]['image']!,
                  //                                                                 ),
                  //                                                               ),
                  //                                                             ),
                  //
                  //                                                             SizedBox(width: Constants.getVerticalGapBetweenTwoTextformfields(context)*25),
                  //
                  //                                                             Expanded(
                  //                                                               child: RichText(
                  //                                                                 text: TextSpan(
                  //                                                                   children: [
                  //                                                                     TextSpan(
                  //                                                                       text:  doneTransactions[index]['serviceName'],
                  //                                                                       style: TextStyle(
                  //                                                                           fontSize:Constants.getGeneralFontSize(context)*0.016,
                  //                                                                           color: const Color(0xff424242),
                  //                                                                           fontFamily: 'Metropolis',
                  //                                                                           fontWeight:FontWeight.w700
                  //                                                                       ),
                  //                                                                     ),
                  //                                                                     TextSpan(
                  //
                  //                                                                       text: "\nPaid",//"\n"+pendingDues[index]['status']==Null?"Pending":pendingDues[index]['status'],
                  //                                                                       style: TextStyle(
                  //                                                                           fontSize:Constants.getGeneralFontSize(context)*0.015,
                  //                                                                           color: Colors.green,
                  //                                                                           fontFamily: 'Metropolis',
                  //                                                                           fontWeight:FontWeight.w400
                  //                                                                       ),
                  //                                                                     ),
                  //                                                                   ],
                  //                                                                 ),
                  //                                                               ),
                  //                                                             ),
                  //                                                             SizedBox(width: Constants.getVerticalGapBetweenTwoTextformfields(context)*8),
                  //
                  //                                                             Expanded(
                  //                                                               child: RichText(
                  //                                                                 textAlign: TextAlign.right,
                  //                                                                 text: TextSpan(
                  //                                                                   children: [
                  //                                                                     TextSpan(
                  //                                                                       text:  "+Rs ${doneTransactions[index]['feeAmount']}",
                  //                                                                       style: TextStyle(
                  //                                                                           fontSize:Constants.getGeneralFontSize(context)*0.021,
                  //                                                                           color: const Color(0xff45C232),
                  //                                                                           fontFamily: 'Metropolis',
                  //                                                                           fontWeight:FontWeight.w700
                  //                                                                       ),
                  //                                                                     ),
                  //                                                                     TextSpan(
                  //                                                                       text:  "\n${DateFormat('dd/MM/yyyy').format(DateTime.parse(doneTransactions[index]['paymentDate']))}",
                  // //                                                                text:  "\n" +doneTransactions[index]['paymentDate'],//+ (DateFormat('dd/MM/yyyy').format(DateTime.parse(doneTransactions[index]['paymentDate']))).toString(),
                  //
                  //                                                                       style: TextStyle(
                  //                                                                           fontSize:Constants.getGeneralFontSize(context)*0.015,
                  //                                                                           color: const Color(0xff424242).withOpacity(0.8),
                  //                                                                           fontFamily: 'Metropolis',
                  //                                                                           fontWeight:FontWeight.w400
                  //                                                                       ),
                  //                                                                     ),
                  //                                                                   ],
                  //                                                                 ),
                  //                                                               ),
                  //                                                             ),
                  //                                                           ],
                  //                                                         ),
                  //                                                       ),
                  //                                                     ),
                  //                                                   ),
                  //                                                 );
                  //                                             },
                  //                                           ),
                  //                                         ),
                  //                                         const Text('Oftenly used transactions will be displayed here'),
                  //                                       ],
                  //                                     ),
                  //
                  //                                 ),
                  //                               ],
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ),
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
                      color: AppColors.gradientColor1(),
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
