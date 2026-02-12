import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paymir_new_android/core/theme/app_colors.dart';

import '../util/AlertDialogueClass.dart';
import '../util/Constants.dart';
import '../util/MyValidation.dart';
import '../util/NetworkHelperClass.dart';
import '../util/SecureStorage.dart';
import 'login/login_screen.dart';

class OneLinkInQuiryPaymentPageNew extends StatefulWidget {
  final Map<String, dynamic> values;
  final List<dynamic> serviceCharges;
  //if you have multiple values add here
  const OneLinkInQuiryPaymentPageNew(
    this.values,
    this.serviceCharges, {
    super.key,
  }); //add also..example this.abc,this...

  @override
  _OneLinkInQuiryPaymentPageNewState createState() =>
      _OneLinkInQuiryPaymentPageNewState(values, serviceCharges);
}

class _OneLinkInQuiryPaymentPageNewState
    extends State<OneLinkInQuiryPaymentPageNew> {
  Map<String, dynamic> values;
  List<dynamic> serviceCharges;

  _OneLinkInQuiryPaymentPageNewState(this.values, this.serviceCharges);

  // final TextEditingController _mobileNumberController =
  // MaskedTextController(mask: '00000000000');

  //final textController = TextEditingController(text: generatePSID());

  // final TextEditingController _CNICController =
  // MaskedTextController(mask: '00000-0000000-0');

  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // TODO SAVE DATA
    }
  } //_submit()

  late var textController = TextEditingController();
  List<dynamic> paymentServiceCharges = [
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
  ];

  final SecureStorage _secureStorage = SecureStorage();

  String strToken = "";
  String totalAmountString = "";
  double taxAmount = 0.00;
  double taxPercentage = 0.00;
  double totalAmount = 0.00;

  double platformChargesPercentage = 0.00;
  double platformChargesAmount = 0.00;

  double paymentChargesPercentage = 0.00;
  double paymentChargesAmount = 0.00;

  @override
  void initState() {
    super.initState();
    //fetchSecureStorageData();

    textController = TextEditingController(text: "");

    fetchSecureStorageData();
    //Future.delayed(const Duration(milliseconds: 2900), () {
    //PSID();
    //});

    try {
      paymentServiceCharges = serviceCharges[0]['paymentServiceCharges'];
      //tax percentage
      platformChargesPercentage = values['platformChargesPercentage'];
      paymentChargesPercentage =
          paymentServiceCharges[0]['paymentChargesPercentage'];
      taxPercentage = platformChargesPercentage + paymentChargesPercentage;
      //tax amount
      platformChargesAmount =
          platformChargesPercentage * 0.01 * values['feeAmount'];
      paymentChargesAmount =
          paymentChargesPercentage * 0.01 * values['feeAmount'];

      taxAmount = ((taxPercentage * 0.01 * values['feeAmount']));
      totalAmount = values['feeAmount'] + taxAmount;
      totalAmountString =
          "${values['feeAmount']} + ${taxAmount.toStringAsFixed(2)} = ${(totalAmount).toStringAsFixed(2)}";
    } catch (e) {
      ShowAlertDialogueClass.showAlertDialogue(
        context: context,
        title: "Server Error",
        message: "Error from Server: $e",
        buttonText: "Okay!",
        iconData: Icons.warning_outlined,
      );
    }
  }

  Future<void> fetchSecureStorageData() async {
    strToken = await _secureStorage.getToken() ?? '';
    // _passwordController.text = await _secureStorage.getPassWord() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
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
                        top: Constants.getBackArrowTopPadding(context),
                        bottom: Constants.getBackArrowBottomPadding(context),
                      ),

                      child: IconButton(
                        icon: SvgPicture.asset("assets/images/back_arrow.svg"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
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
                          "", //values['departmentName'],
                          style: TextStyle(
                            color: AppColors.primaryColor(),
                            fontFamily: 'Visby',
                            fontWeight: FontWeight.bold,
                            fontSize:
                                Constants.getGeneralFontSize(context) * 0.025,
                          ),
                        ),

                        SizedBox(
                          height:
                              Constants.getVerticalGapBetweenMainAndSmallFont(
                                context,
                              ),
                        ),

                        Text(
                          "", //'Application No:   ${values['trackingNumber']}',
                          style: TextStyle(
                            color: AppColors.secondaryColor(),
                            fontFamily: 'Visby',
                            fontWeight: FontWeight.w500,
                            fontSize: Constants.getSmallFontSize(context),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "", //'Total Amount\n',
                                    style: TextStyle(
                                      color: const Color(0xff45C232),
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                          0.05,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Visby',
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        "", //"Rs. ${totalAmount.toStringAsFixed(2)}",
                                    style: TextStyle(
                                      color: const Color(0xff3F3F3F),
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                          0.045,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Metropolis',
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        "", //"\n(Amount + Tax) $totalAmountString",
                                    style: TextStyle(
                                      color: const Color(0xff929BA1),
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                          0.027,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Metropolis',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.1,
                        ),

                        Row(
                          children: [
                            Text(
                              'Funding Source',
                              style: TextStyle(
                                color: const Color(0xff424242),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.045,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Metropolis',
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Image.asset(
                              'assets/images/onelinklogo.jfif',
                              height: MediaQuery.of(context).size.width * 0.05,
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),

                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01,
                            ),

                            Text(
                              'One Link Payment',
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.035,
                                color: const Color(
                                  0xff747474,
                                ).withOpacity(0.80),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Metropolis',
                              ),
                            ),
                          ],
                        ),

                        Padding(
                          // padding: const EdgeInsets.only(top:10),
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.04,
                            top: MediaQuery.of(context).size.height * 0.04,
                            bottom: MediaQuery.of(context).size.height * 0.01,
                          ),

                          child: Text(
                            'Enquire Your PSID',
                            textAlign: TextAlign.left,
                            //overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.029,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff207797),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: Constants.getTextFormFieldHeight(context),
                          width: MediaQuery.of(context).size.width * 0.79,
                          child: TextFormField(
                            maxLength: 20,
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
                                bottom:
                                    Constants.getTextformfieldContentPadding(
                                      context,
                                    ),
                              ),
                            ),
                            controller: textController,
                            keyboardType: TextInputType.number,
                            validator:
                                (value) =>
                                    MyValidationClass.validatePSID(value),
                          ),
                        ),

                        Padding(
                          // padding: const EdgeInsets.only(top:10),
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.04,
                            top:
                                Constants.getVerticalGapBetweenTwoTextformfields(
                                  context,
                                ),
                            bottom: MediaQuery.of(context).size.height * 0.01,
                          ),
                        ),

                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        TextButton(
                          onPressed: () async {
                            _submit();
                            if (MyValidationClass.validatePSID(
                                  textController.text,
                                ) ==
                                null) {
                              enquirePSID();
                              setState(() {
                                _isLoading = true;
                              });
                              if (await NetworkHelper.checkInternetConnection()) {
                                //      performJazzMWalletTransactionNew();
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
                                      'Check Status',
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

  String hashHmac(String data, String secret) {
    String returnString = "";
    var key = utf8.encode(secret);
    var bytes = utf8.encode(data);
    var hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
    var digest = hmacSha256.convert(bytes);
    returnString = digest.toString();
    if (kDebugMode) {
      print("HMAC digest as bytes: ${digest.bytes}");
    }
    if (kDebugMode) {
      print("HMAC digest as hex string: $digest");
    }

    return returnString;
  }

  showLoaderDialog(BuildContext context, String textStr) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(textStr),
            ),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<bool> performJazzMWalletTransactionNew() async {
    String CNIC = values['citizenCNIC']; //"12345-1234567-3";
    String ApplicationTrackingNo = values['dptPaymentID'];
    String FeeAmount = values['feeAmount'].toStringAsFixed(2).toString();
    String strforhash = "$CNIC&$ApplicationTrackingNo&$FeeAmount";

    if (kDebugMode) {
      print("String to be hashed: $strforhash");
    }

    String hsh = hashHmac(strforhash, "kpitb2023paymirpaymentgateway");

    if (kDebugMode) {
      print("The value of Hash: $hsh");
    }
    var data = {
      "MobileNo": "03123456789", //use only this number for testing
      "CNIC": "11201-5734567-8", //use only this cnic for testing
      "CNIC_LoginAcct": values['citizenCNIC'],
      "PaymentMode": "Mobile",
      "ServiceProviderName": "JazzCash",
      "serviceKey": values['serviceKey'],
      "ApplicationNo": values['dptPaymentID'], // This is DPTPaymentID
      "ServiceFee": values['feeAmount'].toStringAsFixed(2).toString(),
      "ServiceCharges": double.parse(
        taxAmount.toStringAsFixed(2),
      ), //10.00,//total tax amount not percentage
      "KPITBPercentage": platformChargesPercentage,
      "KPITBCharges": platformChargesAmount,
      "PaymentPlatformPercentage": paymentChargesPercentage,
      "PaymentPlatformCharges": paymentChargesAmount,
      "TotalAmount":
          100.00, //double.parse(totalAmount.toStringAsFixed(2)),//taxamount + fee amount
      "transactionAmount": "0",
      "orderId": "",
      "storeId": "",
      "transactionType": "",
      "mobileAccountNo": "",
      "emailAddress": "",
      "DuesExtration": "Server",
      "EncData": hsh,
    };

    String auth = "Bearer $strToken";

    try {
      final responseBody = await NetworkHelper.BillPayment(data, auth);
      var decodedResponseBody = json.decode(responseBody!);
      setState(() {
        _isLoading = false;
      });
      if (kDebugMode) {
        print("Response from server: $responseBody");
      }
      if (decodedResponseBody["responseCode"] == "200") {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (_) =>
        //             SuccessfulPaymentPageNew(
        //                 values,
        //                 taxPercentage,
        //                 (totalAmount).toStringAsFixed(2).toString(),
        //                 textController.text,
        //                 "Jazz")));
      } else {
        ShowAlertDialogueClass.showAlertDialogue(
          context: context,
          title: "Response: Failed",
          message: decodedResponseBody["responseMessage"],
          buttonText: "Okay!",
          iconData: Icons.error,
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(e.toString()),
            actions: [
              TextButton(
                child: const Text("Close"),
                onPressed: () {
                  _secureStorage.deleteToken();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
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

  Future<String> enquirePSID() async {
    var data = {
      "PSID": textController.text, //values["DPTPaymentID"],
    };

    String auth = "Bearer $strToken";

    try {
      final responseBody = await NetworkHelper.enquirePSIDApi(data, auth);

      if (kDebugMode) {
        print("responseBody from server: " + responseBody.toString());
      }

      // Parse the JSON
      List<dynamic> jsonList = jsonDecode(responseBody!);

      // Extract the "psid"
      if (jsonList.isNotEmpty) {
        String psidStatus = jsonList[0]['psidStatus'];
        print('Psid Status: $psidStatus');
        setState(() {
          _isLoading = false;
        });
        // Show a dialog with the psidStatus
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0), // Rounded edges
              ),
              title: Text('PSID Status'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.payment, // Payment icon
                    size: 48.0,
                    color: Colors.blue, // You can use your desired icon color
                  ),
                  SizedBox(height: 16.0), // Add some spacing
                  Text(psidStatus),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        print('JSON response is empty or not in the expected format.');
      }

      return "";
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text("PSID does not exist!"),
            actions: [
              TextButton(
                child: const Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    _isLoading = false;
                  });
                  //_secureStorage.deleteToken();
                  //Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPageNew()));
                },
              ),
            ],
          );
        },
      );
    }
    return "";
  }
}
