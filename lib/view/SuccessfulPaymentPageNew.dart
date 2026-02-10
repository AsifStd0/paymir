import 'dart:io';
import 'dart:ui' as ui;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import '../view/HomePageNew.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../util/Constants.dart';

class SuccessfulPaymentPageNew extends StatefulWidget {
  final Map<String, dynamic> values;
  final double taxPercentage;
  final String totalAmount;
  final String mobileNumber;
  final String payingThrough;//if you have multiple v0alues add here
  const SuccessfulPaymentPageNew(this.values, this.taxPercentage, this.totalAmount, this.mobileNumber, this.payingThrough, {super.key});

  @override
  _SuccessfulPaymentPageNewState createState() => _SuccessfulPaymentPageNewState(values, taxPercentage, totalAmount, mobileNumber, payingThrough);
}
class _SuccessfulPaymentPageNewState extends State<SuccessfulPaymentPageNew> {
  Map<String, dynamic> values;
  double taxPercentage;
  String totalAmount;
  String mobileNumber;
  String payingThrough;
  _SuccessfulPaymentPageNewState(this.values, this.taxPercentage, this.totalAmount, this.mobileNumber, this.payingThrough);

  final GlobalKey _globalKey = GlobalKey();

  Future<void> _sharePng() async {
    try {
      // Capture the widget as an image
      RenderRepaintBoundary boundary =
      _globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
      final box = context.findRenderObject() as RenderBox?;

      if (boundary == null || box == null) {
        print("RenderBoundary or Box is null!");
        return;
      }

      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) {
        print("Failed to convert image to byte data.");
        return;
      }

      Uint8List pngBytes = byteData.buffer.asUint8List();

      // Share directly from memory (no need to save first)
      await Share.shareXFiles(
        [
          XFile.fromData(
            pngBytes,
            name: 'payment_details.png',
            mimeType: 'image/png',
          ),
        ],
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
      );

      print("Sharing completed!");

    } catch (e) {
      print("Error: $e");
      Fluttertoast.showToast(
        msg: "An error occurred while sharing!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> _capturePng() async {
    try {
      RenderRepaintBoundary boundary =
      _globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);

      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Save the image using image_gallery_saver_plus
      final result = await ImageGallerySaverPlus.saveImage(pngBytes);

      if (kDebugMode) {
        print("Result of saving image to gallery: $result");
      }

      if (result['isSuccess'] == true) {
        Fluttertoast.showToast(
          msg: "Saved Image to Gallery!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Failed to save image!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> _savePDF() async {
    try {
      final boundary = _globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) {
        print("Failed to find render boundary!");
        return;
      }

      // Convert widget to image
      ui.Image image = await boundary.toImage(pixelRatio: 2.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Create a PDF document
      final doc = pw.Document();
      final pdfImage = pw.MemoryImage(pngBytes);

      doc.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Image(pdfImage),
            );
          },
        ),
      );

      // Save and share the PDF
      final pdfBytes = await doc.save();
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/payment_details.pdf';
      final file = File(filePath);
      await file.writeAsBytes(pdfBytes);

      // Share the PDF file
      await Share.shareXFiles([XFile(filePath)], text: 'Payment Details');

      print("PDF saved successfully: $filePath");
    } catch (e) {
      if (kDebugMode) {
        print("Error saving PDF: $e");
      }
    }
  }

  Future<bool> checkStoragePermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
      Permission.photos,
    ].request();

    return statuses.values.every((status) => status.isGranted);
  }


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()  async{

        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            HomePageNew()), (Route<dynamic> route) => false);
        return true;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:
           Scaffold(
            backgroundColor: const Color(0xffFAFCFF),
            body: SafeArea(
              child: RepaintBoundary(
                key: _globalKey,
                child: Container(
                  color: Colors.white,
                  child: Builder(
                    builder: (BuildContext context) {
                      final mediaQueryData = MediaQuery.of(context);
                      return Stack(
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            right:0,

                              child: Container(
                                width: mediaQueryData.size.width,
                                height: mediaQueryData.size.height/4.1,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Constants.gradientColor2(),
                                      Constants.gradientColor1(),

                                    ],
                                  ),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(MediaQuery.of(context).size.width * 0.1),
                                    bottomRight: Radius.circular(MediaQuery.of(context).size.width * 0.1),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: MediaQuery.of(context).size.width * 0.04,
                                        top: MediaQuery.of(context).size.height * 0.015,
                                        right: MediaQuery.of(context).size.width * 0.16,
                                        bottom: MediaQuery.of(context).size.height * 0.05,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          IconButton(
                                            onPressed: () {

                                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                                  HomePageNew()), (Route<dynamic> route) => false);
                                            },
                                            icon: const Icon(Icons.arrow_back_ios_new_rounded),
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),

                          ),
                          Positioned(
                            bottom: mediaQueryData.size.width * 0.12,
                            left: mediaQueryData.size.width * 0.055,
                            right: mediaQueryData.size.width * 0.055,
                            height: mediaQueryData.size.height/1.255,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.only(
                                    topLeft:  Radius.circular(MediaQuery.of(context).size.width * 0.1),
                                    topRight:  Radius.circular(MediaQuery.of(context).size.width * 0.1),
                                ),
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [

                                    Container(

                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Color(0xffffeeeeee),
                                            Color(0xffFFEEEEEE),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topLeft:  Radius.circular(MediaQuery.of(context).size.width * 0.025),
                                          topRight:  Radius.circular(MediaQuery.of(context).size.width * 0.025),
                                        ),
                                      ),
                                      height:  MediaQuery.of(context).size.height*0.2,
                                      //color: Colors.grey[200],
                                      child: Stack(
                                       children: [
                                         Positioned(
                                           top: MediaQuery.of(context).size.height * 0.027,
                                           left: MediaQuery.of(context).size.width * 0.15,
                                           right: MediaQuery.of(context).size.width * 0.15,
                                           child: SvgPicture.asset(
                                             'assets/images/tick_successful_payment_page.svg',
                                             width: MediaQuery.of(context).size.width * 0.065,
                                             height: MediaQuery.of(context).size.height * 0.065,
                                             // color: Colors.green,
                                           ),
                                         ),


                                         Padding(
                                           padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.06),
                          child: Center(
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Transaction Successful\n',
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width * 0.055,
                                    color: const Color(0xff03110A),
                                    fontFamily: 'Visby',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                WidgetSpan(
                                  child: Baseline(
                                    baselineType: TextBaseline.alphabetic,
                                    baseline: 0,
                                    child: Text(
                                      'You have sent the money!',
                                      style: TextStyle(

                                          fontFamily: 'Visby',
                                          color: const Color(0xff949494),
                                          fontSize: MediaQuery.of(context).size.width * 0.03,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              ),
                            ),
                          ),
                        ),

                      ]),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: MediaQuery.of(context).size.height * 0.025,
                                        left: MediaQuery.of(context).size.width * 0.05,
                                      ),
                                child: Row(
                                children: [
                                Expanded(
                                child: RichText(
                                  text: TextSpan(
                                  children: [
                                  TextSpan(
                                  text: "${DateFormat('d MMMM yyyy   |   h:mm a').format(DateTime.parse(values['entryDateTime']))}\n",//'10 April 2023   |   4:32 PM\n',
                                  style: TextStyle(
                                    color: const Color(0xff424242).withOpacity(0.60),
                                    fontFamily: 'Metropolis',
                                    fontSize: MediaQuery.of(context).size.width * 0.032,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: 'ID#21148794037',
                                  style: TextStyle(
                                    color: const Color(0xff424242).withOpacity(0.60),
                                    fontFamily: 'Metropolis',
                                    fontSize: MediaQuery.of(context).size.width * 0.032,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                              ),

                                    SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.02,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only( left: MediaQuery.of(context).size.width * 0.05,),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Funding Source',
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context).size.width * 0.04,
                                              fontFamily: 'Metropolis',
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xff424242),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    (payingThrough=="Jazz")?
                                    Padding(
                                      padding: EdgeInsets.only( left: MediaQuery.of(context).size.width * 0.05,),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/jazzcashicon.jpg',
                                            height: MediaQuery.of(context).size.height * 0.035,
                                            width: MediaQuery.of(context).size.width * 0.035,
                                          ),
                                          SizedBox(width: MediaQuery.of(context).size.width * 0.01),

                                          Text(
                                            'JazzCash Mobile Account',
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context).size.width * 0.03,
                                              fontFamily: 'Metroplis',
                                              color: const Color(0xff747474).withOpacity(0.80),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ):
                                    Padding(
                                      padding: EdgeInsets.only( left: MediaQuery.of(context).size.width * 0.05,),

                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/easypaisalogo.jpg',
                                            height: MediaQuery.of(context).size.height * 0.035,
                                            width: MediaQuery.of(context).size.width * 0.035,
                                          ),
                                          SizedBox(width: MediaQuery.of(context).size.width * 0.01),

                                          Text(
                                            'EasyPaisa Mobile Account',
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context).size.width * 0.03,
                                              fontFamily: 'Metroplis',
                                              color: const Color(0xff747474).withOpacity(0.80),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),


                                    SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.02,
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: MediaQuery.of(context).size.width * 0.05
                                      ),

                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Paid from\n',
                                                    style: TextStyle(
                                                      color: const Color(0xff424242).withOpacity(.5),
                                                      fontSize: MediaQuery.of(context).size.width / 32,
                                                      fontFamily: 'Metropolis',
                                                      fontWeight: FontWeight.w800,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: mobileNumber,
                                                    style: TextStyle(
                                                      color: const Color(0xff424242).withOpacity(1),
                                                      fontSize: MediaQuery.of(context).size.width / 30,
                                                      fontFamily: 'Metropolis',
                                                      fontWeight: FontWeight.w800,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                      SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.02,
                                      ),

                                      Padding(
                                      padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width * 0.05
                                      ),

                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Department\n',
                                                    style: TextStyle(
                                                      color: const Color(0xff424242).withOpacity(.5),
                                                      fontSize: MediaQuery.of(context).size.width / 32,
                                                      fontFamily: 'Metropolis',
                                                      fontWeight: FontWeight.w800,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: values['departmentName'],
                                                    style: TextStyle(
                                                      color: const Color(0xff424242).withOpacity(1),
                                                      fontSize: MediaQuery.of(context).size.width / 30,
                                                      fontFamily: 'Metropolis',
                                                      fontWeight: FontWeight.w800,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.02,
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context).size.width * 0.05
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Service name\n',
                                                    style: TextStyle(
                                                      color: const Color(0xff424242).withOpacity(.5),
                                                      fontSize: MediaQuery.of(context).size.width / 32,
                                                      fontFamily: 'Metropolis',
                                                      fontWeight: FontWeight.w800,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: values['serviceName'],
                                                    style: TextStyle(
                                                      color: const Color(0xff424242).withOpacity(1),
                                                      fontSize: MediaQuery.of(context).size.width / 30,
                                                      fontFamily: 'Metropolis',
                                                      fontWeight: FontWeight.w800,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),


                                    SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.02,
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context).size.width * 0.05
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [

                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Amount\n',
                                                  style: TextStyle(
                                                    color: const Color(0xff424242).withOpacity(.5),
                                                    fontSize: MediaQuery.of(context).size.width / 32,
                                                    fontFamily: 'Metropolis',
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: "Rs. ${values['feeAmount']}",
                                                  style: TextStyle(
                                                    color: const Color(0xff424242).withOpacity(1),
                                                    fontSize: MediaQuery.of(context).size.width / 30,
                                                    fontFamily: 'Metropolis',
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),

                                    SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.02,
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context).size.width * 0.05
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Service Charges\n',
                                                    style: TextStyle(
                                                      color: const Color(0xff424242).withOpacity(.5),
                                                      fontSize: MediaQuery.of(context).size.width / 32,
                                                      fontFamily: 'Metropolis',
                                                      fontWeight: FontWeight.w800,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: "${taxPercentage.toStringAsFixed(2)}%",
                                                      style: TextStyle(
                                                        color: const Color(0xff424242).withOpacity(1),
                                                        fontSize: MediaQuery.of(context).size.width / 30,
                                                        fontFamily: 'Metropolis',
                                                        fontWeight: FontWeight.w800,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),


                                    SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.02,
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context).size.width * 0.05
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [

                                          RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Total Amount\n',
                                                    style: TextStyle(
                                                      color: const Color(0xff45C232),
                                                      fontSize: MediaQuery.of(context).size.width / 28,
                                                      fontFamily: 'Metropolis',
                                                      fontWeight: FontWeight.w800,

                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: "Rs. $totalAmount",
                                                    style: TextStyle(
                                                      color: const Color(0xff424242).withOpacity(1),
                                                      fontSize: MediaQuery.of(context).size.width / 28,
                                                      fontFamily: 'Metropolis',
                                                      fontWeight: FontWeight.w800,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),


                                                Padding(
                                                padding: EdgeInsets.only(right: MediaQuery.of(context).size.width / 20),
                      child: Container(
                      height: MediaQuery.of(context).size.width / 11,
                      width: MediaQuery.of(context).size.width / 3,
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width / 20),
                      border: Border.all(color: Colors.green),
                      color: Colors.green,
                      ),
                      child: TextButton(
                      onPressed: () {},
                      child: Text(
                      "Paid",
                      style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width / 35,
                      fontFamily: 'Metropolis',
                      fontWeight: FontWeight.bold,
                      ),
                      ),
                      ),
                      ),
                      ),

                      ],
                                      ),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.width / 30),                                        child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            children: [
                                              IconButton(
                                                onPressed: () async {

                                                  if (true) {
                                                    // Good to go!
                                                    _sharePng();
                                                  } else {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return AlertDialog(
                                                          title: const Text("Error"),
                                                          content: const Text("Permissions not granted"),
                                                          actions: [
                                                            TextButton(
                                                              child: const Text("OK"),
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
                                                icon:  SvgPicture.asset(
                                                  'assets/images/share.svg',
                                                  width: MediaQuery.of(context).size.width / 20,
                                                  height: MediaQuery.of(context).size.width / 20,
                                                ),

                                              ),
                                              Text(
                                                'Share',
                                                style: TextStyle(
                                                  color: const Color(0xff424242).withOpacity(.7),
                                                  fontSize: MediaQuery.of(context).size.width / 32,
                                                  fontFamily: 'Metropolis',
                                                  fontWeight: FontWeight.w800,

                                                ),
                                              ),
                                            ],
                                          ),

                                          Column(
                                            children: [
                                              IconButton(
                                                onPressed: () async {


                                                  // Only check for storage < Android 13
                                                  // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
                                                  // AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
                                                  // if (androidInfo.version.sdkInt >= 33) {
                                                  //   videos = await Permission.videos.request().isGranted;
                                                  //   photos = await Permission.photos.request().isGranted;
                                                  // } else {
                                                  //   storage = await Permission.storage.request().isGranted;
                                                  // }

                                                  if (true) {
                                                    // Good to go!
                                                    _capturePng();
                                                  } else {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return AlertDialog(
                                                          title: const Text("Error"),
                                                          content: const Text("Permissions not granted"),
                                                          actions: [
                                                            TextButton(
                                                              child: const Text("OK"),
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
                                                icon:  SvgPicture.asset(
                                                  'assets/images/gallery.svg',
                                                  width: MediaQuery.of(context).size.width / 20,
                                                  height: MediaQuery.of(context).size.width / 20,
                                                ),
                                              ),
                                              Text('Save to Gallery',style: TextStyle(
                                                color: const Color(0xff424242).withOpacity(.7),
                                                fontSize: MediaQuery.of(context).size.width / 32,
                                                fontFamily: 'Metropolis',
                                                fontWeight: FontWeight.w800,

                                              ),),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              IconButton(
                                                onPressed: () async {

                                                  // bool storage = true;
                                                  // bool videos = true;
                                                  // bool photos = true;
                                                  //
                                                  // // Only check for storage < Android 13
                                                  // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
                                                  // AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
                                                  // if (androidInfo.version.sdkInt >= 33) {
                                                  //   videos = await Permission.videos.request().isGranted;
                                                  //   photos = await Permission.photos.request().isGranted;
                                                  // } else {
                                                  //   storage = await Permission.storage.request().isGranted;
                                                  // }

                                                  if (true) {
                                                    // Good to go!
                                                    _savePDF();
                                                  } else {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return AlertDialog(
                                                          title: const Text("Error"),
                                                          content: const Text("Permissions not granted"),
                                                          actions: [
                                                            TextButton(
                                                              child: const Text("OK"),
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
                                                icon:  SvgPicture.asset(
                                                  'assets/images/pdf.svg',
                                                  width: MediaQuery.of(context).size.width / 20,
                                                  height: MediaQuery.of(context).size.width / 20,
                                                ),
                                              ),
                                              Text('Save as PDF',style: TextStyle(
                                                color: const Color(0xff424242).withOpacity(.7),
                                                fontSize: MediaQuery.of(context).size.width / 32,
                                                fontFamily: 'Metropolis',
                                                fontWeight: FontWeight.w800,
                                              ),),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),

      ),
    );
  }
}