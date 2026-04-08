import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../util/SecureStorage.dart';
import '../login/login_screen.dart';
import '../main/main_screen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  String strToken = "";
  String strTokenExpiry = "";
  DateTime expirationDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  /// Initialize app: request permissions, fetch token, then navigate
  Future<void> _initializeApp() async {
    // Request permissions (non-blocking)
    requestPermissions();

    // Fetch token data from SecureStorage
    await fetchSecureStorageData();

    // Wait for splash screen display (3 seconds)
    await Future.delayed(const Duration(seconds: 3));

    // Check if widget is still mounted before navigating
    if (!mounted) return;

    // Check token validity and navigate
    final bool isTokenValid =
        strToken.isNotEmpty && expirationDate.isAfter(DateTime.now());

    if (kDebugMode) {
      debugPrint('🚀 Splash: Navigation decision - Token valid: $isTokenValid');
      debugPrint('   Token empty: ${strToken.isEmpty}');
      debugPrint('   Expired: ${expirationDate.isBefore(DateTime.now())}');
    }

    if (!isTokenValid) {
      // Token is missing or expired - go to login
      if (kDebugMode) {
        debugPrint('➡️ Splash: Navigating to LoginScreen');
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } else {
      // Token is valid - go to home
      if (kDebugMode) {
        debugPrint('➡️ Splash: Navigating to MainScreen');
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    }
  }

  Future<void> requestPermissions() async {
    await [Permission.storage, Permission.camera, Permission.photos].request();
  }

  Future<void> fetchSecureStorageData() async {
    try {
      strToken = await SecureStorage().getToken() ?? '';
      strTokenExpiry = await SecureStorage().getTokenExpiry() ?? '';

      if (kDebugMode) {
        debugPrint(
          '🔑 Splash: Token loaded: ${strToken.isNotEmpty ? "✅ Found" : "❌ Empty"}',
        );
        debugPrint('📅 Splash: Expiry loaded: $strTokenExpiry');
      }

      if (strTokenExpiry.isNotEmpty) {
        expirationDate = DateTime.parse(strTokenExpiry);

        if (kDebugMode) {
          debugPrint('📅 Splash: Parsed expiration: $expirationDate');
          debugPrint('⏰ Splash: Current time: ${DateTime.now()}');
          debugPrint(
            '✅ Splash: Token valid: ${expirationDate.isAfter(DateTime.now())}',
          );
        }
      } else {
        expirationDate = DateTime.now(); // Expired if no expiry date
        if (kDebugMode) {
          debugPrint('⚠️ Splash: No expiry date found, treating as expired');
        }
      }
    } catch (e) {
      // If there's an error parsing, treat as expired
      strToken = '';
      expirationDate = DateTime.now();
      if (kDebugMode) {
        debugPrint('❌ Splash: Error fetching token data: $e');
      }
    }
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
