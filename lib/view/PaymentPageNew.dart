// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:number_to_words_english/number_to_words_english.dart';
import 'package:paymir_new_android/core/theme/app_colors.dart';

import '../util/AlertDialogueClass.dart';
import '../util/Constants.dart';
import 'OneLinkPayment/OneLinkPaymentPageNew.dart';
import 'SearchPageNew.dart';
import 'easypaisa/EasyPaisaPaymentPageNew.dart';
import 'jazzcash/JazzCashPaymentPageNew.dart';

class PaymentPageNew extends StatefulWidget {
  final Map<String, dynamic> values;
  final List<dynamic> serviceCharges;

  const PaymentPageNew(this.values, this.serviceCharges, {super.key});
  @override
  // ignore: no_logic_in_create_state
  _PaymentPageNewState createState() =>
      _PaymentPageNewState(values, serviceCharges);
}

class _PaymentPageNewState extends State<PaymentPageNew> {
  Map<String, dynamic> values;
  List<dynamic> serviceCharges;
  _PaymentPageNewState(this.values, this.serviceCharges);

  String _serviceName = "";
  String _serviceTypeName = "";
  String _departmentName = "";
  String _feeAmount = "";
  String _ePayExpiryDateTime = "";

  bool _isEncircled1 = false;
  bool _isEncircled2 = false;
  bool _isEncircled3 = false;
  bool _isEncircled4 = false;

  @override
  void initState() {
    super.initState();

    _serviceName = values['serviceName'].toString();
    _serviceTypeName = values['serviceTypeName'].toString();
    _departmentName = values['departmentName'].toString();
    _feeAmount = values['feeAmount'].toString();
    _ePayExpiryDateTime = values['ePayExpireDate'].toString();
  }

  String convertDecimalToWords(String number) {
    List<String> parts = number.toString().split('.');
    String wholeNumber = NumberToWordsEnglish.convert(int.parse(parts[0]));
    String decimalNumber = NumberToWordsEnglish.convert(int.parse(parts[1]));
    return '${wholeNumber[0].toUpperCase()}${wholeNumber.substring(1)} point $decimalNumber rupees only';
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xffFAFCFF),
        body: Builder(
          builder: (BuildContext context) {
            final mediaQueryData = MediaQuery.of(context);
            return SafeArea(
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,

                    child: Container(
                      width: mediaQueryData.size.width,
                      height: mediaQueryData.size.height / 3.8,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            AppColors.gradientColor1(),
                            AppColors.gradientColor2(),
                          ],
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                            Constants.getScreenWidth(context) * 0.1,
                          ),
                          bottomRight: Radius.circular(
                            Constants.getScreenWidth(context) * 0.1,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: Constants.getScreenWidth(context) * 0.009,
                              top: Constants.getScreenHeight(context) * 0.02,
                              right: Constants.getScreenWidth(context) * 0.08,
                              bottom: Constants.getScreenHeight(context) * 0.03,
                            ),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                  ),
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    'Payment',
                                    style: TextStyle(
                                      fontSize:
                                          Constants.getHomePageMainFontSize(
                                            context,
                                          ),
                                      color: const Color(0xffFAFCFF),
                                      fontFamily: 'Metropolis',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            //  left: mediaQueryData.size.width * 0.05,
                            //right: mediaQueryData.size.width * 0.05,
                            padding: EdgeInsets.only(
                              left: Constants.getScreenWidth(context) * 0.065,
                              top: Constants.getScreenHeight(context) * 0.007,
                              right: Constants.getScreenWidth(context) * 0.065,
                              bottom: Constants.getScreenHeight(context) * 0.02,
                            ),

                            child: SizedBox(
                              height: Constants.getScreenHeight(context) * 0.05,
                              width: Constants.getScreenWidth(context),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) => SearchPageNew(
                                            values,
                                            serviceCharges,
                                          ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width * 0.02,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 30,
                                      child: Icon(
                                        Icons.search,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      'Search payment options',
                                      style: TextStyle(
                                        fontSize:
                                            Constants.getTextformfieldHintFont(
                                              context,
                                            ),
                                        color: const Color(0xff929BA1),
                                        fontFamily: 'Metropolis',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.03,
                    left: Constants.getScreenWidth(context) * 0.065,
                    right: Constants.getScreenWidth(context) * 0.065,
                    height: mediaQueryData.size.height / 1.37,

                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            MediaQuery.of(context).size.width * 0.03,
                          ),
                          topRight: Radius.circular(
                            MediaQuery.of(context).size.width * 0.03,
                          ),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.03,
                                left: MediaQuery.of(context).size.width * 0.04,
                                right: MediaQuery.of(context).size.width * 0.04,
                              ),

                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Service Name\n',
                                            style: TextStyle(
                                              fontSize:
                                                  Constants.getGeneralFontSize(
                                                    context,
                                                  ) *
                                                  0.014,
                                              color: const Color(
                                                0xff424242,
                                              ).withOpacity(.80),
                                              fontFamily: 'Metropolis',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '$_serviceName\n',
                                            style: TextStyle(
                                              fontSize:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  0.04,
                                              color: const Color(0xff424242),
                                              fontFamily: 'Metropolis',
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Expanded(
                                    child: RichText(
                                      textAlign: TextAlign.right,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "+Rs $_feeAmount\n",
                                            style: TextStyle(
                                              fontSize:
                                                  Constants.getGeneralFontSize(
                                                    context,
                                                  ) *
                                                  0.025,
                                              color: const Color(0xff45C232),
                                              fontFamily: 'Metropolis',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                (DateFormat(
                                                  'dd/MM/yyyy',
                                                ).format(
                                                  DateTime.parse(
                                                    _ePayExpiryDateTime,
                                                  ),
                                                )).toString(),
                                            style: TextStyle(
                                              fontSize:
                                                  Constants.getGeneralFontSize(
                                                    context,
                                                  ) *
                                                  0.015,
                                              color: const Color(
                                                0xff424242,
                                              ).withOpacity(0.80),
                                              fontFamily: 'Metropolis',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(
                                right: MediaQuery.of(context).size.width * 0.04,
                              ),

                              child: Row(
                                children: [
                                  const Spacer(),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height *
                                        0.035,
                                    width:
                                        MediaQuery.of(context).size.width *
                                        0.28,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                          0xffFA6363,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(
                                              MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  0.05,
                                            ),
                                          ),
                                        ),
                                        minimumSize: Size(
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                        ),
                                      ),
                                      child: Text(
                                        'Unpaid',
                                        style: TextStyle(
                                          fontSize:
                                              Constants.getGeneralFontSize(
                                                context,
                                              ) *
                                              0.012,
                                          color: Colors.white,
                                          fontFamily: 'Metropolis',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      //flex: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.04,
                                right: MediaQuery.of(context).size.width * 0.03,
                              ),

                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Service Type\n',
                                            style: TextStyle(
                                              fontSize:
                                                  Constants.getGeneralFontSize(
                                                    context,
                                                  ) *
                                                  0.014,
                                              color: const Color(
                                                0xff424242,
                                              ).withOpacity(.80),
                                              fontFamily: 'Metropolis',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          TextSpan(
                                            text: _serviceTypeName,
                                            style: TextStyle(
                                              fontSize:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  0.04,
                                              color: const Color(0xff424242),
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

                            Padding(
                              padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width * 0.04,
                              ),

                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Department',
                                          style: TextStyle(
                                            fontSize:
                                                Constants.getGeneralFontSize(
                                                  context,
                                                ) *
                                                0.014,
                                            color: const Color(
                                              0xff424242,
                                            ).withOpacity(.80),
                                            fontFamily: 'Metropolis',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          _departmentName,
                                          style: TextStyle(
                                            fontSize:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                0.04,
                                            color: const Color(0xff424242),
                                            fontFamily: 'Metropolis',
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              MediaQuery.of(
                                                context,
                                              ).size.height *
                                              0.02,
                                        ),
                                        Text(
                                          'Status',
                                          style: TextStyle(
                                            fontSize:
                                                Constants.getGeneralFontSize(
                                                  context,
                                                ) *
                                                0.014,
                                            color: const Color(
                                              0xff424242,
                                            ).withOpacity(.80),
                                            fontFamily: 'Metropolis',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "Not paid",
                                          style: TextStyle(
                                            fontSize:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                0.04,
                                            color: const Color(0xff424242),
                                            fontFamily: 'Metropolis',
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SvgPicture.asset(
                                    'assets/images/qr-code-scan.svg',
                                    height:
                                        MediaQuery.of(context).size.height *
                                        0.08,
                                    width:
                                        MediaQuery.of(context).size.width *
                                        0.15,
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.04,
                                top: MediaQuery.of(context).size.height * 0.02,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Pay via',
                                            style: TextStyle(
                                              fontSize:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  0.04,
                                              color: const Color(0xff424242),
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

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isEncircled1 = true;
                                      _isEncircled2 = false;
                                      _isEncircled3 = false;
                                      _isEncircled4 = false;
                                      values['paymentVia'] = "JazzCash";
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border:
                                          _isEncircled1
                                              ? const Border(
                                                bottom: BorderSide(
                                                  width: 5.0,
                                                  color: Color(0xff32C774),
                                                ),
                                              )
                                              : null,
                                      boxShadow:
                                          _isEncircled1
                                              ? [
                                                BoxShadow(
                                                  color: Colors.green
                                                      .withOpacity(0.5),
                                                  spreadRadius: 2,
                                                  blurRadius: 80,
                                                  offset: const Offset(0, 3),
                                                ),
                                              ]
                                              : null,
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.of(
                                                context,
                                              ).size.width /
                                              6,
                                          height:
                                              MediaQuery.of(
                                                context,
                                              ).size.width /
                                              6,
                                          decoration:
                                              _isEncircled1
                                                  ? BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: const Color(
                                                      0xff00D95F,
                                                    ).withOpacity(.12),
                                                  )
                                                  : BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: const Color(
                                                      0xff608DE2,
                                                    ).withOpacity(.12),
                                                  ),
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                              MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  0.04,
                                            ),
                                            child: Image.asset(
                                              'assets/images/jazzcashlogo.png',
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top:
                                                MediaQuery.of(
                                                  context,
                                                ).size.height *
                                                0.008,
                                            bottom:
                                                MediaQuery.of(
                                                  context,
                                                ).size.height *
                                                0.005,
                                          ),
                                          child: Text(
                                            'JazzCash',
                                            style: TextStyle(
                                              fontSize:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  0.032,
                                              fontFamily: 'Metropolis',
                                              color: const Color(0xff3F3F3F),
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isEncircled1 = false;
                                      _isEncircled2 = true;
                                      _isEncircled3 = false;
                                      _isEncircled4 = false;
                                      values['paymentVia'] = "EasyPaisa";
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border:
                                          _isEncircled2
                                              ? const Border(
                                                bottom: BorderSide(
                                                  width: 5.0,
                                                  color: Color(0xff32C774),
                                                ),
                                              )
                                              : null,
                                      boxShadow:
                                          _isEncircled2
                                              ? [
                                                BoxShadow(
                                                  color: Colors.green
                                                      .withOpacity(0.5),
                                                  spreadRadius: 2,
                                                  blurRadius: 80,
                                                  offset: const Offset(0, 3),
                                                ),
                                              ]
                                              : null,
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.of(
                                                context,
                                              ).size.width /
                                              6,
                                          height:
                                              MediaQuery.of(
                                                context,
                                              ).size.width /
                                              6,
                                          decoration:
                                              _isEncircled2
                                                  ? BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: const Color(
                                                      0xff00D95F,
                                                    ).withOpacity(.12),
                                                  )
                                                  : BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: const Color(
                                                      0xff608DE2,
                                                    ).withOpacity(.12),
                                                  ),
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                              MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  0.04,
                                            ),
                                            child: Image.asset(
                                              'assets/images/easypaisalogo.png',
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top:
                                                MediaQuery.of(
                                                  context,
                                                ).size.height *
                                                0.008,
                                            bottom:
                                                MediaQuery.of(
                                                  context,
                                                ).size.height *
                                                0.005,
                                          ),
                                          child: Text(
                                            'EasyPaisa',
                                            style: TextStyle(
                                              fontSize:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  0.032,
                                              fontFamily: 'Metropolis',
                                              color: const Color(0xff3F3F3F),
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isEncircled1 = false;
                                      _isEncircled2 = false;
                                      _isEncircled3 = true;
                                      _isEncircled4 = false;
                                      values['paymentVia'] = "Raast";
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border:
                                          _isEncircled3
                                              ? const Border(
                                                bottom: BorderSide(
                                                  width: 5.0,
                                                  color: Color(0xff32C774),
                                                ),
                                              )
                                              : null,
                                      boxShadow:
                                          _isEncircled3
                                              ? [
                                                BoxShadow(
                                                  color: Colors.green
                                                      .withOpacity(0.5),
                                                  spreadRadius: 2,
                                                  blurRadius: 80,
                                                  offset: const Offset(0, 3),
                                                ),
                                              ]
                                              : null,
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.of(
                                                context,
                                              ).size.width /
                                              6,
                                          height:
                                              MediaQuery.of(
                                                context,
                                              ).size.width /
                                              6,
                                          decoration:
                                              _isEncircled3
                                                  ? BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: const Color(
                                                      0xff00D95F,
                                                    ).withOpacity(.12),
                                                  )
                                                  : BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: const Color(
                                                      0xff608DE2,
                                                    ).withOpacity(.12),
                                                  ),
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                              MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  0.04,
                                            ),
                                            child: Image.asset(
                                              'assets/images/raastlogo.png',
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top:
                                                MediaQuery.of(
                                                  context,
                                                ).size.height *
                                                0.008,
                                            bottom:
                                                MediaQuery.of(
                                                  context,
                                                ).size.height *
                                                0.005,
                                          ),
                                          child: Text(
                                            'Raast',
                                            style: TextStyle(
                                              fontSize:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  0.032,
                                              fontFamily: 'Metropolis',
                                              color: const Color(0xff3F3F3F),
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isEncircled1 = false;
                                      _isEncircled2 = false;
                                      _isEncircled3 = false;
                                      _isEncircled4 = true;
                                      values['paymentVia'] = "1Link";
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border:
                                          _isEncircled4
                                              ? const Border(
                                                bottom: BorderSide(
                                                  width: 5.0,
                                                  color: Color(0xff32C774),
                                                ),
                                              )
                                              : null,
                                      boxShadow:
                                          _isEncircled4
                                              ? [
                                                BoxShadow(
                                                  color: Colors.green
                                                      .withOpacity(0.5),
                                                  spreadRadius: 2,
                                                  blurRadius: 80,
                                                  offset: const Offset(0, 3),
                                                ),
                                              ]
                                              : null,
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.of(
                                                context,
                                              ).size.width /
                                              6,
                                          height:
                                              MediaQuery.of(
                                                context,
                                              ).size.width /
                                              6,
                                          decoration:
                                              _isEncircled4
                                                  ? BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: const Color(
                                                      0xff00D95F,
                                                    ).withOpacity(.12),
                                                  )
                                                  : BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: const Color(
                                                      0xff608DE2,
                                                    ).withOpacity(.12),
                                                  ),
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                              MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  0.04,
                                            ),
                                            child: Image.asset(
                                              'assets/images/onelinklogo.jfif',
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top:
                                                MediaQuery.of(
                                                  context,
                                                ).size.height *
                                                0.008,
                                            bottom:
                                                MediaQuery.of(
                                                  context,
                                                ).size.height *
                                                0.005,
                                          ),
                                          child: Text(
                                            '1Link',
                                            style: TextStyle(
                                              fontSize:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  0.032,
                                              fontFamily: 'Metropolis',
                                              color: const Color(0xff3F3F3F),
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            Padding(
                              // Use a fraction of the screen width for each side of the padding
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.04,
                                top: MediaQuery.of(context).size.width * 0.06,
                              ),

                              child: const Row(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [],
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.09,
                                right: MediaQuery.of(context).size.width * 0.07,
                                top: MediaQuery.of(context).size.height * 0.025,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(0),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffFFFFFF),
                                        borderRadius: BorderRadius.circular(0),
                                      ),
                                      child: Text(
                                        convertDecimalToWords(_feeAmount),
                                        style: TextStyle(
                                          fontSize:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.04,
                                          color: const Color(0xff929BA1),
                                          fontFamily: 'Metropolis',
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.05,
                                right: MediaQuery.of(context).size.width * 0.05,
                                top: MediaQuery.of(context).size.width * 0.01,
                                bottom:
                                    MediaQuery.of(context).size.width * 0.05,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  // Your onPressed() function here
                                  if (_isEncircled1 == false &&
                                      _isEncircled2 == false &&
                                      _isEncircled3 == false &&
                                      _isEncircled4 == false) {
                                    ShowAlertDialogueClass.showAlertDialogue(
                                      context: context,
                                      title: "Payment Option!",
                                      message:
                                          "Please Select a payment option!",
                                      buttonText: "Okay!",
                                      iconData: Icons.error,
                                    );
                                  } else if (values['paymentVia'] ==
                                      "JazzCash") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (_) => JazzCashPaymentPageNew(
                                              values,
                                              serviceCharges,
                                            ),
                                      ),
                                    );
                                  } else if (values['paymentVia'] ==
                                      "EasyPaisa") {
                                    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => EasyPaisaPaymentPageNew(values)));
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (_) => EasyPaisaPaymentPageNew(
                                              values,
                                              serviceCharges,
                                            ),
                                      ),
                                    );
                                  } else if (values['paymentVia'] == "1Link") {
                                    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => EasyPaisaPaymentPageNew(values)));
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (_) => OneLinkPaymentPageNew(
                                              values,
                                              serviceCharges,
                                            ),
                                      ),
                                    );
                                  } else {
                                    // Navigator.push(context, MaterialPageRoute(builder: (_)=>OneLinkInQuiryPaymentPageNew(values, serviceCharges)));

                                    ShowAlertDialogueClass.showAlertDialogue(
                                      context: context,
                                      title: "Don't Worry!",
                                      message:
                                          "InshaAllah, will be implemented soon!",
                                      buttonText: "Okay!",
                                      iconData: Icons.error,
                                    );
                                  }
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: Constants.getButtonHeight(
                                          context,
                                        ),

                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(
                                              Constants.getButtonRadius(
                                                context,
                                              ),
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

                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top:
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.width *
                                                    0.02,
                                                left:
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.width *
                                                    0.1,
                                                bottom:
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.width *
                                                    0.03,
                                              ),
                                              child: Text(
                                                'Pay Rs. $_feeAmount',
                                                style: TextStyle(
                                                  fontFamily: 'Metropolis',
                                                  fontSize:
                                                      Constants.getButtonFont(
                                                        context,
                                                      ),
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
