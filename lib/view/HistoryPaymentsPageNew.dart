// ignore_for_file: no_logic_in_create_state, library_private_types_in_public_api
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../util/Mediaquery_Constant.dart';
import '../util/NetworkHelperClass.dart';
import '../util/SecureStorage.dart';
import 'login/login_screen.dart';

class HistoryPaymentPageNew extends StatefulWidget {
  const HistoryPaymentPageNew();

  @override
  _HistoryPaymentPageNewState createState() => _HistoryPaymentPageNewState();
}

class _HistoryPaymentPageNewState extends State<HistoryPaymentPageNew> {
  _HistoryPaymentPageNewState();
  List<dynamic> doneTransactions =
      []; //[{"arcid":77,"applicationTrackingNo":"RED-LRB-20220727-00002","cnic":"11111-1111111-1","serviceName":"Land Record and Boundary Identification (HadBarari)","serviceTypeName":"New Hadbarari Application","departmentName":"Revenue and Estate Department","feeAmount":1000.00,"status":"Pending","applicationGenerationDateTime":"2023-04-16T00:00:00","entryDateTime":"2023-04-17T00:00:00","responseStatus":true,"responseMessage":"Request entertained successfully"}];
  List<dynamic> items = []; //doneTransactions;
  final List<String> logos = [
    'assets/images/jazzcashlogo.png',
    'assets/images/easypaisalogo.png',
    'assets/images/raastlogo.png',
    'assets/images/onelinklogo.jfif',
  ];
  List<dynamic> filteredItems = [];
  List<String> filteredLogos = [];

  List<Map<String, String>> _list = [
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

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    filteredItems = doneTransactions;
    filteredLogos = logos;

    fetchSecureStorageData();
    setState(() {
      _isLoading = true;
    });

    Future.delayed(Duration(milliseconds: 2900), () {
      loadDoneApplicationDetails();

      setState(() {
        _isLoading = false;
      });
    });
  }

  void filterList(String query) {
    setState(() {
      filteredItems =
          doneTransactions
              .where(
                (element) => element['serviceName'].toLowerCase().contains(
                  query.toLowerCase(),
                ),
              )
              .toList();
      // filteredLogos = logos
      //     .where((element) =>
      // items[logos.indexOf(element)]
      //     .toLowerCase()
      //     .contains(query.toLowerCase()))
      // .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body:
            _isLoading
                ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.22,
                        height: MediaQuery.of(context).size.width * 0.22,
                        child: CircularProgressIndicator(),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Text(
                        'Loading data...',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Visby',
                        ),
                      ),
                    ],
                  ),
                )
                : SafeArea(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: MediaQueryConstant.getBackArrowLeftPadding(
                                context,
                              ),
                              top: MediaQueryConstant.getBackArrowTopPadding(
                                context,
                              ),
                              bottom:
                                  MediaQueryConstant.getBackArrowBottomPadding(
                                    context,
                                  ),
                            ),
                            child: IconButton(
                              icon: SvgPicture.asset(
                                "assets/images/back_arrow.svg",
                              ),
                              onPressed:
                                  () => {
                                    Navigator.pop(context),
                                  }, //Navigator.pop(context),
                            ),
                          ),
                        ],
                      ),

                      Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.01,
                          left: MediaQuery.of(context).size.width * 0.05,
                          right: MediaQuery.of(context).size.width * 0.05,
                        ),

                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width,
                          child: TextField(
                            onChanged: (value) => filterList(value),
                            decoration: InputDecoration(
                              hintText: 'Search payment here',
                              hintStyle: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                                color: const Color(0xff929BA1),
                                fontFamily: 'Metropolis',
                                fontWeight: FontWeight.w500,
                              ),
                              prefixIcon: const Icon(Icons.search),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width * 0.02,
                                ),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 20,
                            right: MediaQuery.of(context).size.width / 20,
                            //left:MediaQuery.of(context).size.width / 20
                          ),
                          child: RefreshIndicator(
                            onRefresh: () async {
                              // Your code here
                              if (kDebugMode) {
                                print("You refreshed the listview");
                              }
                              loadDoneApplicationDetails();
                            },
                            child: ListView.builder(
                              itemCount: filteredItems.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    if (kDebugMode) {
                                      print(
                                        "you clicked on: " +
                                            index.toString() +
                                            "\n" +
                                            filteredItems[index].toString(),
                                      );
                                    }
                                    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>PaymentPageNew(pendingDues[index],serviceCharges)));

                                    filteredItems[index].forEach((key, value) {
                                      print('$key: $value');
                                    });

                                    String formatDate(String date) {
                                      DateTime dateTime = DateTime.parse(date);
                                      String formattedDate = DateFormat(
                                        'dd MMMM yyyy hh:mm a',
                                      ).format(dateTime);
                                      return formattedDate;
                                    }

                                    String output = '';
                                    filteredItems[index].forEach((key, value) {
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
                                          key = 'Service provider name';
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
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Done Transaction'),
                                          content: SingleChildScrollView(
                                            child: Text(output),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed:
                                                  () => Navigator.pop(context),
                                              child: const Text('Close'),
                                            ),
                                          ],
                                        );
                                      },
                                    );

                                    //print(doneTransactions[index]{});
                                  },
                                  child: Card(
                                    color: Color(0xffFFFFFF),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top:
                                            MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
                                              context,
                                            ) *
                                            10,
                                        left:
                                            MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
                                              context,
                                            ) *
                                            20,
                                        right:
                                            MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
                                              context,
                                            ) *
                                            20,
                                        bottom:
                                            MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
                                              context,
                                            ) *
                                            6,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            15.0,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xff0000000A),
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
                                                  MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
                                                    context,
                                                  ) *
                                                  40,
                                              height:
                                                  MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
                                                    context,
                                                  ) *
                                                  40,
                                              decoration: BoxDecoration(
                                                color: Color(
                                                  0xff4B2A7A,
                                                ).withOpacity(1),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(
                                                  MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
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
                                                  MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
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
                                                          filteredItems[index]['serviceName'],
                                                      style: TextStyle(
                                                        fontSize:
                                                            MediaQueryConstant.getGeneralFontSize(
                                                              context,
                                                            ) *
                                                            0.016,
                                                        color: Color(
                                                          0xff424242,
                                                        ),
                                                        fontFamily:
                                                            'Metropolis',
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          "\nPaid", //"\n"+pendingDues[index]['status']==Null?"Pending":pendingDues[index]['status'],
                                                      style: TextStyle(
                                                        fontSize:
                                                            MediaQueryConstant.getGeneralFontSize(
                                                              context,
                                                            ) *
                                                            0.015,
                                                        color: Colors.green,
                                                        fontFamily:
                                                            'Metropolis',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
                                                    context,
                                                  ) *
                                                  8,
                                            ),

                                            Expanded(
                                              child: RichText(
                                                textAlign: TextAlign.right,
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          "+Rs " +
                                                          filteredItems[index]['feeAmount']
                                                              .toString(),
                                                      style: TextStyle(
                                                        fontSize:
                                                            MediaQueryConstant.getGeneralFontSize(
                                                              context,
                                                            ) *
                                                            0.021,
                                                        color: Color(
                                                          0xff45C232,
                                                        ),
                                                        fontFamily:
                                                            'Metropolis',
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          "\n" +
                                                          (DateFormat(
                                                            'dd/MM/yyyy',
                                                          ).format(
                                                            DateTime.parse(
                                                              filteredItems[index]['paymentDate'],
                                                            ),
                                                          )).toString(),
                                                      //                                                                text:  "\n" +doneTransactions[index]['paymentDate'],//+ (DateFormat('dd/MM/yyyy').format(DateTime.parse(doneTransactions[index]['paymentDate']))).toString(),
                                                      style: TextStyle(
                                                        fontSize:
                                                            MediaQueryConstant.getGeneralFontSize(
                                                              context,
                                                            ) *
                                                            0.015,
                                                        color: Color(
                                                          0xff424242,
                                                        ).withOpacity(0.8),
                                                        fontFamily:
                                                            'Metropolis',
                                                        fontWeight:
                                                            FontWeight.w400,
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
                        ),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }

  String strToken = "";
  String strTokenExpiry = "";
  String strCNIC = "";

  final SecureStorage _secureStorage = SecureStorage();

  Future<void> fetchSecureStorageData() async {
    strToken = await _secureStorage.getToken() ?? '';
    strTokenExpiry = await _secureStorage.getTokenExpiry() ?? '';
    strCNIC = await _secureStorage.getCNIC() ?? '';
    // _passwordController.text = await _secureStorage.getPassWord() ?? '';
  }

  Future<bool> loadDoneApplicationDetails() async {
    var data = {"CNIC": strCNIC};

    String auth = "Bearer " + strToken;

    try {
      final responseBody = await NetworkHelper.loadDoneApplicationDetails(
        data,
        auth,
      );

      print("Just before actual print...");
      print(responseBody.toString());

      String jsonString = responseBody!;

      if (responseBody.contains(
        "Authorization has been denied for this request",
      )) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Error"),
              content: const Text("Session Expired. Please login again!"),
              actions: [
                TextButton(
                  child: const Text("Close"),
                  onPressed: () {
                    _secureStorage.deleteToken();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => LoginScreen()),
                    );
                  },
                ),
              ],
            );
          },
        );
      } else {
        Map<String, dynamic> data2 = jsonDecode(jsonString);
        setState(() {
          doneTransactions = data2['receivedData'];
          filteredItems = doneTransactions;
        });

        for (var element in doneTransactions) {
          print(element["serviceName"]);
        }
      }
      // print("Service Charges: " + serviceCharges.toString());
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
                  Navigator.pop(context);
                  //_secureStorage.deleteToken();
                  //Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPageNew()));
                },
              ),
            ],
          );
        },
      );
    }

    return false;
  }
}
