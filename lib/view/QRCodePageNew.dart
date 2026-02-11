// // ignore_for_file: no_logic_in_create_state, use_build_context_synchronously
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:permission_handler/permission_handler.dart';
// import '../util/Constants.dart';
// import '../util/NetworkHelperClass.dart';
// import '../util/SecureStorage.dart';
// import 'PaymentPageNew.dart';
//
// class QRCodeScanner extends StatefulWidget {
//   final List<dynamic> serviceCharges;//if you have multiple v0alues add here
//
//   const QRCodeScanner(this.serviceCharges, {super.key});
//
//   @override
//   // ignore: library_private_types_in_public_api
//   _QRCodeScannerState createState() => _QRCodeScannerState(serviceCharges);
// }
//
// class _QRCodeScannerState extends State<QRCodeScanner> {
//
//   List<dynamic> serviceCharges;//if you have multiple v0alues add here
//   _QRCodeScannerState(this.serviceCharges);
//
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   late QRViewController controller;
//   String qrText = "";
//
//   final SecureStorage _secureStorage = SecureStorage();
//
//   List<dynamic> pendingDues = [];//[{"arcid":77,"applicationTrackingNo":"RED-LRB-20220727-00002","cnic":"11111-1111111-1","serviceName":"Land Record and Boundary Identification (HadBarari)","serviceTypeName":"New Hadbarari Application","departmentName":"Revenue and Estate Department","feeAmount":1000.00,"status":"Pending","applicationGenerationDateTime":"2023-04-16T00:00:00","entryDateTime":"2023-04-17T00:00:00","responseStatus":true,"responseMessage":"Request entertained successfully"}];
//
//   String strToken="";
//   String strTokenExpiry="";
//   String cnicString ="";
//
//   Future<void> _requestCameraPermission() async {
//     final PermissionStatus permissionStatus = await Permission.camera.request();
//     if (permissionStatus == PermissionStatus.granted) {
//     } else {
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _requestCameraPermission();
//     fetchSecureStorageData();
//     Future.delayed(const Duration(seconds: 3), () {
//       //loadApplicationDetails("LGD-WCB-230404-0004-U01");
//     });
//   }
//
//   String qrCodeResult = "Not Yet Scanned";
//   Future<void> scanQRCode() async {
//     String qrCode = await FlutterBarcodeScanner.scanBarcode(
//         "#ff6666", "Cancel", true, ScanMode.QR);
//     if (qrCode == "-1") {
//       setState(() {
//         qrCodeResult = "Not Yet Scanned";
//       });
//     } else {
//       setState(() {
//         qrCodeResult = qrCode;
//       });
//       if (qrCodeResult != "Not Yet Scanned") {
//         loadApplicationDetails(qrCodeResult);
//       }
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children:[
//               Row(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(
//                       left: Constants.getBackArrowLeftPadding(context),
//                       top:  Constants.getBackArrowTopPadding(context),
//                       bottom: Constants.getBackArrowBottomPadding(context),
//                     ),
//
//                     child: IconButton(
//                       icon:
//                       SvgPicture.asset("assets/images/back_arrow.svg"),
//                       onPressed: () {
//                         Navigator.of(context, rootNavigator: true).pop();
//
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//
//             SizedBox(height: Constants.getVerticalGapBetweenTwoTextformfields(context)*300,),
//
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   qrCodeResult,
//                   style: TextStyle(
//                     color: AppColors.primaryColor(),
//                     fontFamily: 'Visby',
//                     fontWeight: FontWeight.bold,
//                     fontSize:Constants.getMainFontSize(context),
//                   ),
//                 ),
//
//                 SizedBox(height: Constants.getVerticalGapBetweenTwoTextformfields(context)*350,),
//
//                 Padding(
//               padding:  EdgeInsets.symmetric(
//               horizontal: Constants.getSymmetricHorizontalPadding(context)
//               ),
//                   child: Align(
//                     alignment: Alignment.center,
//                     child: TextButton(
//                       onPressed: () {
//                        // Navigator.push(context, MaterialPageRoute(builder: (_)=>QRCodeScanner(serviceCharges)));
//                         scanQRCode();
//                       },
//                       child: Container(
//                         alignment: Alignment.center,
//                         width: double.infinity,
//                         height: Constants.getButtonHeight(context),
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             begin: Alignment.centerLeft,
//                             end: Alignment.centerRight,
//                             colors: [
//                               AppColors.gradientColor1(),
//                               AppColors.gradientColor2(),
//                             ],
//                           ),
//                           borderRadius: BorderRadius.all(Radius.circular(Constants.getButtonRadius(context))),
//
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             SizedBox(
//                               height: Constants.getVerticalGapBetweenTwoTextformfields(context)*35,
//                               width: Constants.getVerticalGapBetweenTwoTextformfields(context)*35,
//                               child:
//                               SvgPicture.asset("assets/images/qrcodelogo1.svg"),
//                             ),
//                             SizedBox(
//                               width: Constants.getVerticalGapBetweenTwoTextformfields(context)*20,
//                             ),
//                             Text(
//                               'Scan QR Code',
//                               style: TextStyle(
//                                   color:Colors.white,
//                                   fontSize:Constants.getButtonFont(context),
//                                   fontFamily: 'Visby',
//                                   fontWeight:FontWeight.bold
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<String?> loadApplicationDetails(String dtpPaymentID) async {
//     var data =
//       {
//         "DPTPaymentID": dtpPaymentID,
//         "CNIC" : cnicString,
//         "Using" : "DPTPayID"
//       };
//
//     String auth = "Bearer $strToken";
//
//     try {
//       final responseBody = await NetworkHelper.getPendingTransactions(
//           data, auth);
//
//       try {
//
//         if (responseBody!.contains("false")) {
//           setState(() {
//             qrText = "No record found!";
//             qrCodeResult = "No record found!";
//           });
//
//           showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                 title: const Text("No record found!"),
//                 actions: [
//                   TextButton(
//                     child: const Text("OK"),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                 ],
//               );
//             },
//           );
//           return "false";
//         }
//
//         else {
//           String jsonString = responseBody;
//
//           Map<String, dynamic> data2 = jsonDecode(jsonString);
//
//           //serviceCharges = data2['serviceProviderTaxesConfigurations'];
//
//           // Accessing the pendingDues array
//           setState(() {
//             pendingDues = data2['pendingDues'];
//             serviceCharges = data2['serviceProviderTaxesConfigurations'];
//           });
//
//           // for (var element in pendingDues) {
//           // }
//
//
//           for (var i = 0; i < serviceCharges.length; i++) {
//
//             List<
//                 dynamic> paymentServiceCharges = serviceCharges[i]['paymentServiceCharges'];
//
//             for (var j = 0; j < paymentServiceCharges.length; j++) {
//             }
//
//           }
//
//           try {
//             await Future.delayed(const Duration(seconds: 1), () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) =>
//                     PaymentPageNew(pendingDues[0], serviceCharges)),
//               );
//             });
//           } catch (e) {
//             setState(() {
//               qrText = "No record found!";
//             });
//             Navigator.pop(context);
//           }
//
//           return "false";
//         }
//       } //try end
//       catch (e) {
//         setState(() {
//           qrText = "No record found!";
//         });
//
//         Navigator.pop(context);
//       }
//     }
//     catch (e) {
//       // print(e);
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text("Error"),
//             content:
//             const Text("Server is down and cannot be accessed!"),
//             actions: [
//               TextButton(
//                 child: const Text("Close"),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     }
//     return "false";
//   }
//
//   Future<void> fetchSecureStorageData() async {
//     strToken = await _secureStorage.getToken() ?? '';
//     strTokenExpiry = await _secureStorage.getTokenExpiry() ?? '';
//     cnicString = await _secureStorage.getCNIC() ?? '';
//     // _passwordController.text = await _secureStorage.getPassWord() ?? '';
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:paymir_new_android/util/app_colors.dart';
import 'package:permission_handler/permission_handler.dart';

import '../util/Constants.dart';
import '../util/NetworkHelperClass.dart';
import '../util/SecureStorage.dart';
import 'PaymentPageNew.dart';

class QRCodeScanner extends StatefulWidget {
  final List<dynamic> serviceCharges;

  const QRCodeScanner(this.serviceCharges, {super.key});

  @override
  _QRCodeScannerState createState() => _QRCodeScannerState(serviceCharges);
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  List<dynamic> serviceCharges;
  _QRCodeScannerState(this.serviceCharges);

  String qrCodeResult = "Not Yet Scanned";
  final SecureStorage _secureStorage = SecureStorage();
  List<dynamic> pendingDues = [];
  String strToken = "";
  String strTokenExpiry = "";
  String cnicString = "";

  Future<void> _requestCameraPermission() async {
    await Permission.camera.request();
  }

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
    fetchSecureStorageData();
  }

  void scanQRCode() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Scan QR Code"),
            content: SizedBox(
              height: 250,
              width: 250,
              child: MobileScanner(
                onDetect: (capture) {
                  final List<Barcode> barcodes = capture.barcodes;
                  if (barcodes.isNotEmpty) {
                    Navigator.pop(context);
                    setState(() {
                      qrCodeResult = barcodes.first.rawValue ?? "No Data";
                    });
                    Future.delayed(const Duration(seconds: 4), () {
                      setState(() {
                        qrCodeResult = "No record found!";
                      });
                    });
                    loadApplicationDetails(qrCodeResult);
                  }
                },
              ),
            ),
          ),
    );
  }

  Future<String?> loadApplicationDetails(String dtpPaymentID) async {
    var data = {
      "DPTPaymentID": dtpPaymentID,
      "CNIC": cnicString,
      "Using": "DPTPayID",
    };

    String auth = "Bearer $strToken";

    try {
      final responseBody = await NetworkHelper.getPendingTransactions(
        data,
        auth,
      );
      if (responseBody != null && responseBody.contains("false")) {
        Future.delayed(const Duration(seconds: 3), () {
          setState(() {
            qrCodeResult = "Not Yet Scanned";
          });
        });
        setState(() {
          qrCodeResult = "No record found!";
        });
        return "false";
      }
      Map<String, dynamic> data2 = jsonDecode(responseBody!);
      setState(() {
        pendingDues = data2['pendingDues'];
        serviceCharges = data2['serviceProviderTaxesConfigurations'];
      });
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PaymentPageNew(pendingDues[0], serviceCharges),
          ),
        );
      });
    } catch (e) {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text("Error"),
              content: const Text("Server is down and cannot be accessed!"),
              actions: [
                TextButton(
                  child: const Text("Close"),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
      );
    }
    return "false";
  }

  Future<void> fetchSecureStorageData() async {
    strToken = await _secureStorage.getToken() ?? '';
    strTokenExpiry = await _secureStorage.getTokenExpiry() ?? '';
    cnicString = await _secureStorage.getCNIC() ?? '';
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
                    child: IconButton(
                      icon: SvgPicture.asset("assets/images/back_arrow.svg"),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height:
                    Constants.getVerticalGapBetweenTwoTextformfields(context) *
                    300,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    qrCodeResult,
                    style: TextStyle(
                      color: AppColors.primaryColor(),
                      fontFamily: 'Visby',
                      fontWeight: FontWeight.bold,
                      fontSize: Constants.getMainFontSize(context),
                    ),
                  ),
                  SizedBox(
                    height:
                        Constants.getVerticalGapBetweenTwoTextformfields(
                          context,
                        ) *
                        350,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Constants.getSymmetricHorizontalPadding(
                        context,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: scanQRCode,
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: Constants.getButtonHeight(context),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                AppColors.gradientColor1(),
                                AppColors.gradientColor2(),
                              ],
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                Constants.getButtonRadius(context),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height:
                                    Constants.getVerticalGapBetweenTwoTextformfields(
                                      context,
                                    ) *
                                    35,
                                width:
                                    Constants.getVerticalGapBetweenTwoTextformfields(
                                      context,
                                    ) *
                                    35,
                                child: SvgPicture.asset(
                                  "assets/images/qrcodelogo1.svg",
                                ),
                              ),
                              SizedBox(
                                width:
                                    Constants.getVerticalGapBetweenTwoTextformfields(
                                      context,
                                    ) *
                                    20,
                              ),
                              Text(
                                'Scan QR Code',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Constants.getButtonFont(context),
                                  fontFamily: 'Visby',
                                  fontWeight: FontWeight.bold,
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
            ],
          ),
        ),
      ),
    );
  }
}
