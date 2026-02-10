import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../util/SecureStorage.dart';
import '../HomePageNew.dart';
import '../login/LoginPageNew.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  final SecureStorage _secureStorage = SecureStorage();

  String strToken = "";
  String strTokenExpiry = "";
  DateTime expirationDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    requestPermissions();
    fetchSecureStorageData();

    Future.delayed(const Duration(seconds: 3), () {
      if (kDebugMode) {
        print("Token: $strToken");
        print("Expiry: $strTokenExpiry");
        print("Now Date: ${DateTime.now()}");
      }

      if (strToken.isEmpty || expirationDate.isBefore(DateTime.now())) {
        if (kDebugMode) {
          print('Token has expired.');
        }
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPageNew()),
        );
      } else {
        if (kDebugMode) {
          print('Token is still valid.');
        }
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePageNew()),
        );
      }
    });
  }

  Future<void> requestPermissions() async {
    await [Permission.storage, Permission.camera, Permission.photos].request();
  }

  Future<void> fetchSecureStorageData() async {
    strToken = await _secureStorage.getToken() ?? '';
    strTokenExpiry = await _secureStorage.getTokenExpiry() ?? '';
    expirationDate =
        (strTokenExpiry.isEmpty)
            ? DateTime.now()
            : DateTime.parse(strTokenExpiry);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              colors: [Color(0xff4B2A7A), Color(0xff08A1A7)],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/images/mainlogoupdated.svg'),
                    Text(
                      "Khyber Pakhtunkhwa\nDigital Payment Platform (D2P)",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SvgPicture.asset("assets/images/govt_logo.svg"),
              Text(
                "Approved by\nthe KP Government",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
