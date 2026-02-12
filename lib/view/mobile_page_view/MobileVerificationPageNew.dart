import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth/signup_provider.dart';
import '../../util/Constants.dart';
import 'mobile_page_view_widgets.dart';

/// OTP verification screen for signup
/// Step 3 in the signup flow (after mobile registration)
class MobileVerificationPageNew extends StatefulWidget {
  final Map<String, dynamic>? values; // Optional for backward compatibility

  const MobileVerificationPageNew({super.key, this.values});

  @override
  _MobileVerificationPageNewState createState() =>
      _MobileVerificationPageNewState();
}

class _MobileVerificationPageNewState extends State<MobileVerificationPageNew> {
  final TextEditingController _otpController = TextEditingController();
  String _currentOTP = "";
  bool _isCompleted = false;

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _handleVerify() async {
    if (!_isCompleted) {
      return;
    }

    final signupProvider = Provider.of<SignupProvider>(context, listen: false);

    // First verify OTP locally
    if (!signupProvider.verifyOTPLocally(_currentOTP)) {
      _showIncorrectOTPDialog();
      return;
    }

    // If OTP matches locally, verify with server
    final success = await signupProvider.verifyUserWithServer(context: context);

    if (success && mounted) {
      // Navigation is handled by the provider
      if (kDebugMode) {
        print('User verified successfully');
      }
    }
  }

  void _showIncorrectOTPDialog() {
    setState(() {
      _isCompleted = false;
    });

    MobileIncorrectOTPDialog.show(
      context: context,
      onClearOTP: () {
        setState(() {
          _currentOTP = "";
          _isCompleted = false;
        });
        _otpController.clear();
      },
    );
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
                const MobileBackButton(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Constants.getSymmetricHorizontalPadding(
                      context,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const MobileTitleText(text: 'Enter verification code'),
                      SizedBox(
                        height: Constants.getVerticalGapBetweenMainAndSmallFont(
                          context,
                        ),
                      ),
                      const MobileSubtitleText(
                        text:
                            'Enter 4-digits code that was just sent to your email',
                      ),
                      SizedBox(
                        height:
                            Constants.getVerticalGapBetweenSmallfontAndTextfield(
                              context,
                            ),
                      ),
                      MobileOTPField(
                        controller: _otpController,
                        onChanged: (value) {
                          setState(() {
                            _currentOTP = value;
                            if (_currentOTP.length < 4) {
                              _isCompleted = false;
                            }
                          });
                        },
                        onCompleted: () {
                          setState(() {
                            _isCompleted = true;
                          });
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                      ),
                      Consumer<SignupProvider>(
                        builder: (context, signupProvider, _) {
                          return MobileGradientButton(
                            text: 'Verify',
                            onPressed: _handleVerify,
                            isLoading: signupProvider.isLoadingVerification,
                            isEnabled:
                                _isCompleted &&
                                !signupProvider.isLoadingVerification,
                          );
                        },
                      ),
                    ],
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
