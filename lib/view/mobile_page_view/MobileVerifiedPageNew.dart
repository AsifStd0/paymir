import 'package:flutter/material.dart';

import '../../util/Constants.dart';
import '../login/login_screen.dart';
import 'mobile_page_view_widgets.dart';

/// Success screen after mobile verification
/// Step 4 in the signup flow (after OTP verification)
class MobileVerifiedPageNew extends StatefulWidget {
  const MobileVerifiedPageNew({super.key});

  @override
  _MobileVerifiedPageNewState createState() => _MobileVerifiedPageNewState();
}

class _MobileVerifiedPageNewState extends State<MobileVerifiedPageNew> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                MobileBackButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  },
                ),
                const MobileSuccessImage(),
                const MobileSuccessTitle(text: "You're verified!"),
                SizedBox(
                  height: Constants.getVerticalGapBetweenMainAndSmallFont(
                    context,
                  ),
                ),
                const MobileSuccessMessage(
                  text:
                      'You have successfully been verified\n                   and registered',
                ),
                SizedBox(
                  height:
                      Constants.getVerticalGapBetweenTwoTextformfields(
                        context,
                      ) *
                      60,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Constants.getSymmetricHorizontalPadding(
                      context,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.1,
                        bottom: MediaQuery.of(context).size.height * 0.02,
                      ),
                      child: MobileGradientButton(
                        text: 'Done',
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
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
      ),
    );
  }
}
