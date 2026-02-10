// import 'dart:async';
// import 'dart:convert';
// import 'package:extended_masked_text/extended_masked_text.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import '../util/AlertDialogueClass.dart';
// import '../util/Constants.dart';
// import '../util/MyValidation.dart';
// import '../util/NetworkHelperClass.dart';
// import '../util/SecureStorage.dart';
//
// class DastakPageNew extends StatefulWidget {
//   const DastakPageNew({super.key});
//
//   @override
//   _DastakPageNewState createState() => _DastakPageNewState();
// }
//
// class _DastakPageNewState extends State<DastakPageNew> {
//
//   late  List<Map<String, dynamic>> responseData = [
//     // {
//     //   "psid": "10121000101901241",
//     //   "status": "Paid",
//     //   "amount": 5.00
//     // },
//     // {
//     //   "psid": "10121000101901242",
//     //   "status": "Unpaid",
//     //   "amount": 10.00
//     // }
//   ];
//
//   final TextEditingController _CNICController = MaskedTextController(mask: '00000-0000000-0');
//
//   bool _isLoading = false;
//
//
//   final _formKey = GlobalKey<FormState>();
//
//   final SecureStorage _secureStorage = SecureStorage();
//
//
//   String strToken="";
//   String strTokenExpiry="";
//   String strCNIC="";
//
//
//
//   Future<void> fetchSecureStorageData() async {
//     strToken = await _secureStorage.getToken() ?? '';
//     strTokenExpiry = await _secureStorage.getTokenExpiry() ?? '';
//     strCNIC = await _secureStorage.getCNIC() ?? '';
//
//     // _passwordController.text = await _secureStorage.getPassWord() ?? '';
//   }
//
//   void _submit() {
//     if (_formKey.currentState!.validate()) {
//       // TODO SAVE DATA
//     }
//   }
//
//
//   Future<bool> loadApplicationDetails() async {
//     var data =  {
//    //   "DPTPaymentID": "NULL",
//       "CNIC" : _CNICController.text,
//      // "Using" : "MobileNo"
//
//     };
//
//     String auth = "Bearer $strToken";
//
//     try {
//       final responseBody = await NetworkHelper.getArmsLicensePSID(data, auth);
//
//       if (kDebugMode) {
//         print("Just before actual print...Pending Dues");
//         print(responseBody.toString());
//       }
//
//       String jsonString = responseBody!;
//       Map<String, dynamic> data2 = jsonDecode(jsonString);
//
//       setState(() {
//         _isLoading = false;
//         // Check if 'pSIDs' exists and is of the correct type
//         if (data2['pSIDs'] != null && data2['pSIDs'] is List<dynamic>) {
//           // Convert List<dynamic> to List<Map<String, dynamic>>
//           responseData = List<Map<String, dynamic>>.from(data2['pSIDs']);
//         } else {
//           // Handle the case when 'pSIDs' is null or of incorrect type
//           responseData = [];
//         }
//       });
//
//     } catch (e) {
//       // Handle errors here, for example:
//       print('Error occurred: $e');
//       setState(() {
//         _isLoading = false;
//         // Set responseData to empty list or null depending on your logic
//         responseData = [];
//       });
//     }
//
//
//     catch (e) {
//       // showDialog(
//       //   context: context,
//       //   builder: (BuildContext context) {
//       //     return AlertDialog(
//       //       title: const Text("Session Expired!"),
//       //       content:
//       //       Text("Please login again!"),
//       //       actions: [
//       //         TextButton(
//       //           child: const Text("Close"),
//       //           onPressed: () {
//       //             _secureStorage.deleteToken();
//       //             Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const LoginPageNew()));
//       //
//       //           },
//       //         ),
//       //       ],
//       //     );
//       //   },
//       // );
//     }
//
//     return false;
//   }
//
//   Future<void> loadApplicationDetailsUpdated() async {
//     // Check if the widget is still mounted before proceeding
//     if (!mounted) return;
//
//     var data = {
//       "CNIC": strCNIC,
//     };
//
//     String auth = "Bearer $strToken";
//
//     try {
//       final responseBody = await NetworkHelper.getArmsLicensePSID(data, auth);
//
//       if (kDebugMode) {
//         print("Just before actual print...Pending Dues");
//         print(responseBody.toString());
//       }
//
//       String jsonString = responseBody!;
//       Map<String, dynamic> data2 = jsonDecode(jsonString);
//
//       if (!mounted) return; // Check again if widget is still mounted
//
//       setState(() {
//         _isLoading = false;
//         if (data2['pSIDs'] != null && data2['pSIDs'] is List<dynamic>) {
//           responseData = List<Map<String, dynamic>>.from(data2['pSIDs']);
//         } else {
//           responseData = [];
//         }
//       });
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error occurred: $e');
//       }
//       if (!mounted) {
//         setState(() {
//           _isLoading = false;
//           responseData = [];
//         });
//       }
//     }
//   }
//
//
//
//   @override
//   void initState() {
//     super.initState();
//     fetchSecureStorageData();
//     Future.delayed(const Duration(milliseconds: 3000), () {
//       //loadCardDetails();
//       //loadCardDetails();
//       //loadData();
//       loadApplicationDetailsUpdated();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         // You can add your logic or show a dialog here if needed
//         Navigator.of(context).pop();
//         return false; // Prevent the default back navigation
//       },
//       child: Scaffold(
//         backgroundColor: const Color(0xffFAFCFF),
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(
//                         top: Constants.getHomePageMainTextTopPadding(context),
//                         left: Constants.getHomePageMainTextLeftPadding(context),
//                         right: Constants.getHomePageMainTextRightPadding(context),
//                         bottom:Constants.getHomePageMainTextBottomPadding(context)
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                             'DASTAK',
//                             style: TextStyle(
//                                 fontSize:Constants.getHomePageMainFontSize(context),
//                                 color: const Color(0xff474747),
//                                 fontFamily: 'Metropolis',
//                                 fontWeight:FontWeight.bold
//                             )
//                         ),
//                         Text(
//                             'Arms License',
//                             style: TextStyle(
//                                 fontSize:MediaQuery.sizeOf(context).width*0.032,
//                                 color: const Color(0xff474747),
//                                 fontFamily: 'Metropolis',
//                                 fontWeight:FontWeight.w600
//                             )
//                         ),
//                       ],
//                     ),
//                   ), // First Row
//                   SizedBox(height: Constants.getVerticalGapBetweenTwoTextformfields(context)*1),
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: SizedBox(
//                       height: Constants.getTextFormFieldHeight(context),
//                       child: TextFormField(
//                         textAlign: TextAlign.start,
//                         controller: _CNICController,
//                         keyboardType: TextInputType.number,
//                         validator: (value) => MyValidationClass.validateCNIC(value),
//                         decoration: InputDecoration(
//                           hintStyle:
//                           TextStyle(
//                               fontSize: Constants.getTextformfieldHintFont(context),
//                               color: Constants.secondaryColor(),
//                               fontFamily: 'Visby',
//                               fontWeight: FontWeight.normal
//                           ), //hint text style
//                           hintText: 'CNIC',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(
//                                 Radius.circular(Constants.getTextformfieldBorderRadius(context)
//                                 )),
//                           ),
//                           counterText: '',
//                           contentPadding: EdgeInsets.only(
//                             top: Constants.getTextformfieldContentPadding(context),
//                             left: Constants.getTextformfieldContentPadding(context),
//                             bottom: Constants.getTextformfieldContentPadding(context),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: Constants.getVerticalGapBetweenTwoTextformfields(context)*1),
//                   Center(
//                     child: TextButton(
//                       onPressed: ()  async {
//                         _submit();
//                         if(MyValidationClass.validateCNIC(_CNICController.text)==null)
//                         {
//                           setState(() {
//                             _isLoading = true;
//                           });
//                           if(await NetworkHelper.checkInternetConnection())
//                           {
//                             loadApplicationDetails();
//                             if (kDebugMode) {
//                               print("button pressed");
//                             }
//                           }
//                           else
//                           {
//                             ShowAlertDialogueClass.showAlertDialogue(context: context, title: "No Internet", message: "Check your internet connection!", buttonText: "OK", iconData:Icons.error);
//                           }
//                         }
//                       },
//                       child: Container(
//                         alignment: Alignment.center,
//                         width: Constants.getButtonHeight(context)*5,//double.infinity,
//                         height: Constants.getButtonHeight(context),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(Constants.getButtonRadius(context))),
//                           gradient: LinearGradient(
//                             begin: Alignment.centerLeft,
//                             end: Alignment.centerRight,
//                             colors: [
//                               Constants.gradientColor1(),
//                               Constants.gradientColor2(),
//                             ],
//                           ),
//                         ),
//                         child: _isLoading
//                             ? const CircularProgressIndicator(
//                           valueColor:
//                           AlwaysStoppedAnimation<Color>(Colors.white),
//                         )
//                             : Text('Check Payment Details',
//                             style: TextStyle(
//                                 color:Colors.white,
//                                 fontSize:Constants.getButtonFont(context),
//                                 fontFamily: 'Visby',
//                                 fontWeight:FontWeight.bold
//                             )
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: Constants.getVerticalGapBetweenTwoTextformfields(context)*1),
//                   ListView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: responseData.length + 1,
//                     itemBuilder: (BuildContext context, int index) {
//                       if (index < responseData.length) {
//                         return PSIDCard(
//                           psidData: responseData[index],
//                         );
//                       } else {
//                         return Container(
//                           padding: EdgeInsets.all(10),
//                           child: Text(
//                             'Note: Amount can be paid through OneBill',
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.normal,
//                             ),
//                           ),
//                         );
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
// }
//
// class PSIDCard extends StatelessWidget {
//   final Map<String, dynamic> psidData;
//
//   PSIDCard({required this.psidData});
//
//   @override
//   Widget build(BuildContext context) {
//     Color statusColor = psidData['status'] == 'Paid' ? Colors.green : Colors.red;
//     bool isUnpaid = psidData['status'] == 'Unpaid';
//
//     return Card(
//       margin: EdgeInsets.all(10),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0), // Rounded edges
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(15), // Added padding
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'PSID: ${psidData['psid']}',
//                   style: TextStyle(
//                     color: Theme.of(context).primaryColor,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//                 Text(
//                   'Status: ${psidData['status']}',
//                   style: TextStyle(
//                     color: statusColor,
//                     fontSize: 14,
//                   ),
//                 ),
//                 Text(
//                   'Amount: PKR ${psidData['amount']}',
//                   style: TextStyle(
//                     color: Colors.blue, // Change amount color
//                     fontSize: 14,
//                   ),
//                 ),
//               ],
//             ),
//             ElevatedButton(
//               onPressed: isUnpaid
//                   ? () {
//                 _copyPSIDToClipboard(context, psidData['psid']);
//               }
//                   : null, // Null onPressed disables the button
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Theme.of(context).hintColor, // Button color
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20.0), // Rounded edges
//                 ),
//               ),
//               child: Text('Copy PSID'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _copyPSIDToClipboard(BuildContext context, String psid) {
//     Clipboard.setData(ClipboardData(text: psid));
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('PSID copied to clipboard')),
//     );
//   }
// }

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import '../util/Constants.dart';
import '../util/SecureStorage.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'VoucherNoPageNew.dart';

class DastakPageNew extends StatefulWidget {
  const DastakPageNew({super.key});

  @override
  _DastakPageNewState createState() => _DastakPageNewState();
}

class _DastakPageNewState extends State<DastakPageNew> {

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
                      //left: Constants.getHomePageMainTextLeftPadding(context)*2.3,
                     // right: Constants.getVerticalGapBetweenTwoTextformfields(context),
                      bottom: Constants.getVerticalGapBetweenTwoTextformfields(context)*9,
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                          child: Text(
                              'Dastak Services',
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
                        //showMyGeneraDialog();

                        Navigator.push(context, MaterialPageRoute(builder: (_)=>VoucherNoPageNew()));


                      },
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * .5,
                        height: MediaQuery.sizeOf(context).width * 0.3, // Increased height slightly
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: const Color(0xffF4F6F9),
                          borderRadius: BorderRadius.circular(MediaQuery.sizeOf(context).width * 0.03),
                          border: Border.all(
                            color: const Color(0xffEBEBEB),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(MediaQuery.sizeOf(context).width * 0.015),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
                            children: [
                              Padding(
                                padding: EdgeInsets.all(Constants.getVerticalGapBetweenTwoTextformfields(context) * 5),
                                child: SvgPicture.asset(
                                  'assets/images/utilitieslogo.svg',
                                  height: Constants.getSmallFontSize(context) * 2.5,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: Constants.getVerticalGapBetweenTwoTextformfields(context) * 2),
                                child: SizedBox(
                                  width: MediaQuery.sizeOf(context).width * 0.5, // Restrict width
                                  child: Text(
                                    'Housing Foundation Membership',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: const Color(0xff3F3F3F),
                                      fontFamily: 'Metropolis',
                                      fontSize: Constants.getSmallFontSize(context),
                                      fontWeight: FontWeight.w600,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                    maxLines: 2, // Allow multi-line text
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