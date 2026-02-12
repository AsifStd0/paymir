import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth/signup_provider.dart';
import '../../util/Constants.dart';
import 'mobile_page_view_widgets.dart';

/// Mobile number entry screen for signup
/// Step 2 in the signup flow (after CNIC verification)
class MobilePageNew extends StatefulWidget {
  final Map<String, dynamic>? values; // Optional for backward compatibility

  const MobilePageNew({super.key, this.values});

  @override
  _MobilePageNewState createState() => _MobilePageNewState();
}

class _MobilePageNewState extends State<MobilePageNew> {
  final TextEditingController _mobileNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String phoneNumber = '';

  @override
  void dispose() {
    _mobileNumberController.dispose();
    super.dispose();
  }

  Future<void> _handleContinue() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (phoneNumber.isEmpty ||
        !RegExp(r'^\+923[0-9]{9}$').hasMatch(phoneNumber)) {
      MobileErrorDialog.show(
        context: context,
        title: 'Error',
        message: 'Invalid phone number. Valid format is +923XXXXXXXXX',
      );
      return;
    }

    final signupProvider = Provider.of<SignupProvider>(context, listen: false);

    final success = await signupProvider.registerUserWithMobile(
      mobileNo: phoneNumber,
      context: context,
    );

    if (success && mounted) {
      // Navigation is handled by the provider via alert dialog
      if (kDebugMode) {
        print('Registration successful, OTP: ${signupProvider.otp}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const MobileBackButton(),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Constants.getSymmetricHorizontalPadding(context),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const MobileTitleText(text: 'Set up 2-step verification'),
                      SizedBox(
                        height: Constants.getVerticalGapBetweenMainAndSmallFont(
                          context,
                        ),
                      ),
                      const MobileSubtitleText(
                        text:
                            'Enter your phone number so that we can send you verification code',
                      ),
                      SizedBox(
                        height:
                            Constants.getVerticalGapBetweenSmallfontAndTextfield(
                              context,
                            ),
                      ),
                      MobilePhoneField(
                        controller: _mobileNumberController,
                        onChanged: (value) {
                          setState(() {
                            phoneNumber = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.41,
                      ),
                      Consumer<SignupProvider>(
                        builder: (context, signupProvider, _) {
                          return MobileGradientButton(
                            text: 'Continue',
                            onPressed: _handleContinue,
                            isLoading: signupProvider.isLoadingRegistration,
                            isEnabled: !signupProvider.isLoadingRegistration,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
