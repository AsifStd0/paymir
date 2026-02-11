// import 'package:extended_masked_text/extended_masked_text.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:provider/provider.dart';

// import '../../providers/auth/signup_provider.dart';
// import '../../util/MyValidation.dart';
// import '../../utils/app_strings.dart';
// import '../../utils/constants.dart';
// import '../../widget/PrivacyPolicyPageNew.dart';
// import '../../widget/custom/custom_button.dart';
// import '../../widget/custom/custom_text.dart';
// import '../../widget/custom/custom_textfield.dart';
// import 'login_screen.dart';
// import 'mobile_verification_screen.dart';

// /// Signup screen for user registration
// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});

//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   Map<String, String> values = {};
//   var _isChecked = false;
//   bool _passwordVisible = false;

//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _cnicController = MaskedTextController(
//     mask: '00000-0000000-0',
//   );
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   void _submit() {
//     if (_formKey.currentState!.validate()) {
//       // Form validation passed
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const LoginScreen()),
//         );
//         return false;
//       },
//       child: Scaffold(
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Column(children: [_buildBackButton(), _buildForm()]),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildBackButton() {
//     return Row(
//       children: [
//         Padding(
//           padding: EdgeInsets.only(
//             left: Constants.getBackArrowLeftPadding(context),
//             top: Constants.getBackArrowTopPadding(context),
//             bottom: Constants.getBackArrowBottomPadding(context),
//           ),
//           child: IconButton(
//             icon: SvgPicture.asset("assets/images/back_arrow.svg"),
//             onPressed: () {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const LoginScreen()),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildForm() {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         horizontal: Constants.getSymmetricHorizontalPadding(context),
//       ),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CustomText.mainTitle(
//               text: AppStrings.signUpTitle,
//               context: context,
//             ),
//             SizedBox(
//               height: Constants.getVerticalGapBetweenMainAndSmallFont(context),
//             ),
//             CustomText.subtitle(
//               text: AppStrings.signUpSubtitle,
//               context: context,
//             ),
//             SizedBox(
//               height: Constants.getVerticalGapBetweenSmallfontAndTextfield(
//                 context,
//               ),
//             ),
//             _buildNameFields(),
//             SizedBox(
//               height: Constants.getVerticalGapBetweenTwoTextformfields(context),
//             ),
//             CustomTextField.cnic(controller: _cnicController),
//             SizedBox(
//               height: Constants.getVerticalGapBetweenTwoTextformfields(context),
//             ),
//             CustomTextField.email(controller: _emailController),
//             SizedBox(
//               height: Constants.getVerticalGapBetweenTwoTextformfields(context),
//             ),
//             _buildPasswordField(),
//             SizedBox(
//               height: Constants.getVerticalGapBetweenTwoTextformfields(context),
//             ),
//             _buildTermsCheckbox(),
//             SizedBox(
//               height: Constants.getVerticalGapBetweenTwoTextformfields(context),
//             ),
//             _buildSignUpButton(),
//             SizedBox(
//               height:
//                   Constants.getVerticalGapBetweenTwoTextformfields(context) *
//                   20,
//             ),
//             _buildDivider(),
//             _buildGovIdentityButton(),
//             SizedBox(height: Constants.getVerticalGapAboveLastLine(context)),
//             _buildSignInLink(),
//             SizedBox(
//               height: Constants.getLoginVerticalGapBelowLastLine(context),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildNameFields() {
//     return Row(
//       children: [
//         Expanded(
//           child: CustomTextField.name(
//             controller: _firstNameController,
//             hintText: AppStrings.firstName,
//           ),
//         ),
//         SizedBox(
//           width: Constants.getHorizontalGapBetweenTwoTextformfields(context),
//         ),
//         Expanded(
//           child: CustomTextField.name(
//             controller: _lastNameController,
//             hintText: AppStrings.lastName,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildPasswordField() {
//     return Builder(
//       builder: (builderContext) {
//         try {
//           final signupProvider = Provider.of<SignupProvider>(
//             builderContext,
//             listen: true,
//           );
//           return CustomTextField.password(
//             controller: _passwordController,
//             obscureText: !signupProvider.passwordVisible,
//             onToggleVisibility: () {
//               signupProvider.togglePasswordVisibility();
//             },
//           );
//         } catch (e) {
//           return CustomTextField.password(
//             controller: _passwordController,
//             obscureText: !_passwordVisible,
//             onToggleVisibility: () {
//               setState(() {
//                 _passwordVisible = !_passwordVisible;
//               });
//             },
//           );
//         }
//       },
//     );
//   }

//   Widget _buildTermsCheckbox() {
//     return Builder(
//       builder: (builderContext) {
//         try {
//           final signupProvider = Provider.of<SignupProvider>(
//             builderContext,
//             listen: true,
//           );
//           return Row(
//             children: [
//               Checkbox(
//                 value: signupProvider.isChecked,
//                 onChanged: (value) {
//                   signupProvider.setChecked(value!);
//                   _submit();
//                 },
//               ),
//               Flexible(
//                 child: RichText(
//                   text: TextSpan(
//                     children: [
//                       TextSpan(
//                         text: AppStrings.agreeTerms,
//                         style: TextStyle(
//                           color: AppColors.secondaryColor(),
//                           fontFamily: 'Visby',
//                           fontWeight: FontWeight.normal,
//                           fontSize: Constants.getTextformfieldHintFont(
//                             builderContext,
//                           ),
//                         ),
//                       ),
//                       TextSpan(
//                         recognizer:
//                             TapGestureRecognizer()
//                               ..onTap =
//                                   () => Navigator.push(
//                                     builderContext,
//                                     MaterialPageRoute(
//                                       builder:
//                                           (context) =>
//                                               const PrivacyPolicyPage(),
//                                     ),
//                                   ),
//                         text: AppStrings.termsOfService,
//                         style: TextStyle(
//                           color: AppColors.tertiaryColor(),
//                           fontFamily: 'Visby',
//                           fontWeight: FontWeight.normal,
//                           fontSize: Constants.getTextformfieldHintFont(
//                             builderContext,
//                           ),
//                         ),
//                       ),
//                       TextSpan(
//                         text: AppStrings.and,
//                         style: TextStyle(
//                           color: AppColors.secondaryColor(),
//                           fontFamily: 'Visby',
//                           fontWeight: FontWeight.normal,
//                           fontSize: Constants.getTextformfieldHintFont(
//                             builderContext,
//                           ),
//                         ),
//                       ),
//                       TextSpan(
//                         recognizer:
//                             TapGestureRecognizer()
//                               ..onTap =
//                                   () => Navigator.push(
//                                     builderContext,
//                                     MaterialPageRoute(
//                                       builder:
//                                           (context) =>
//                                               const PrivacyPolicyPage(),
//                                     ),
//                                   ),
//                         text: AppStrings.privacyPolicy,
//                         style: TextStyle(
//                           color: AppColors.tertiaryColor(),
//                           fontFamily: 'Visby',
//                           fontWeight: FontWeight.normal,
//                           fontSize: Constants.getTextformfieldHintFont(
//                             builderContext,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           );
//         } catch (e) {
//           return Row(
//             children: [
//               Checkbox(
//                 value: _isChecked,
//                 onChanged: (value) {
//                   setState(() {
//                     _isChecked = value!;
//                   });
//                   _submit();
//                 },
//               ),
//               Flexible(
//                 child: RichText(
//                   text: TextSpan(
//                     children: [
//                       TextSpan(
//                         text: AppStrings.agreeTerms,
//                         style: TextStyle(
//                           color: AppColors.secondaryColor(),
//                           fontFamily: 'Visby',
//                           fontWeight: FontWeight.normal,
//                           fontSize: Constants.getTextformfieldHintFont(
//                             builderContext,
//                           ),
//                         ),
//                       ),
//                       TextSpan(
//                         recognizer:
//                             TapGestureRecognizer()
//                               ..onTap =
//                                   () => Navigator.push(
//                                     builderContext,
//                                     MaterialPageRoute(
//                                       builder:
//                                           (context) =>
//                                               const PrivacyPolicyPage(),
//                                     ),
//                                   ),
//                         text: AppStrings.termsOfService,
//                         style: TextStyle(
//                           color: AppColors.tertiaryColor(),
//                           fontFamily: 'Visby',
//                           fontWeight: FontWeight.normal,
//                           fontSize: Constants.getTextformfieldHintFont(
//                             builderContext,
//                           ),
//                         ),
//                       ),
//                       TextSpan(
//                         text: AppStrings.and,
//                         style: TextStyle(
//                           color: AppColors.secondaryColor(),
//                           fontFamily: 'Visby',
//                           fontWeight: FontWeight.normal,
//                           fontSize: Constants.getTextformfieldHintFont(
//                             builderContext,
//                           ),
//                         ),
//                       ),
//                       TextSpan(
//                         recognizer:
//                             TapGestureRecognizer()
//                               ..onTap =
//                                   () => Navigator.push(
//                                     builderContext,
//                                     MaterialPageRoute(
//                                       builder:
//                                           (context) =>
//                                               const PrivacyPolicyPage(),
//                                     ),
//                                   ),
//                         text: AppStrings.privacyPolicy,
//                         style: TextStyle(
//                           color: AppColors.tertiaryColor(),
//                           fontFamily: 'Visby',
//                           fontWeight: FontWeight.normal,
//                           fontSize: Constants.getTextformfieldHintFont(
//                             builderContext,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           );
//         }
//       },
//     );
//   }

//   Widget _buildSignUpButton() {
//     return Builder(
//       builder: (builderContext) {
//         try {
//           final signupProvider = Provider.of<SignupProvider>(
//             builderContext,
//             listen: true,
//           );
//           return CustomButton(
//             onPressed:
//                 signupProvider.isChecked
//                     ? () async {
//                       _submit();
//                       if (_validateForm(signupProvider)) {
//                         final isVerified = await signupProvider.checkUser(
//                           _cnicController.text,
//                           builderContext,
//                         );
//                         if (isVerified) {
//                           _navigateToMobileVerification(builderContext);
//                         }
//                       }
//                     }
//                     : null,
//             text: AppStrings.signUp,
//             isLoading: signupProvider.isLoading,
//             isEnabled: signupProvider.isChecked,
//           );
//         } catch (e) {
//           return CustomButton(
//             onPressed:
//                 _isChecked
//                     ? () async {
//                       _submit();
//                       if (_validateForm(null)) {
//                         values = {
//                           'fullname':
//                               "${_firstNameController.text} ${_lastNameController.text}",
//                           'emailAddress': _emailController.text,
//                           'cnic': _cnicController.text,
//                           'password': _passwordController.text,
//                           'Category': "PAYMIR",
//                         };
//                         _navigateToMobileVerification(builderContext);
//                       }
//                     }
//                     : null,
//             text: AppStrings.signUp,
//             isLoading: false,
//             isEnabled: _isChecked,
//           );
//         }
//       },
//     );
//   }

//   bool _validateForm(SignupProvider? provider) {
//     return MyValidationClass.validateName(_firstNameController.text) == null &&
//         MyValidationClass.validateName(_lastNameController.text) == null &&
//         MyValidationClass.validateEmail(_emailController.text) == null &&
//         MyValidationClass.validateCNIC(_cnicController.text) == null &&
//         MyValidationClass.validatePassword(_passwordController.text) == null &&
//         (provider?.isChecked ?? _isChecked) == true;
//   }

//   void _navigateToMobileVerification(BuildContext context) {
//     values = {
//       'fullname': "${_firstNameController.text} ${_lastNameController.text}",
//       'emailAddress': _emailController.text,
//       'cnic': _cnicController.text,
//       'password': _passwordController.text,
//       'Category': "PAYMIR",
//     };
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => MobileVerificationScreen(values)),
//     );
//   }

//   Widget _buildDivider() {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Expanded(child: Divider(thickness: 1, color: Colors.grey.shade400)),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               child: CustomText.divider(text: AppStrings.or, context: context),
//             ),
//             Expanded(child: Divider(thickness: 1, color: Colors.grey.shade400)),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildGovIdentityButton() {
//     return Container(
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.all(
//           Radius.circular(Constants.getTextformfieldBorderRadius(context)),
//         ),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       padding: EdgeInsets.symmetric(
//         vertical: Constants.getLoginViaEIdentityVerticalPadding(context),
//         horizontal: Constants.getLoginViaEIdentityVerticalPadding(context),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Padding(
//             padding: EdgeInsets.only(
//               left: Constants.getLoginViaEIdentityLeftImagePadding(context),
//             ),
//             child: SvgPicture.asset("assets/images/gov_eidentity_icon.svg"),
//           ),
//           SizedBox(width: Constants.getLoginViaEIdentityHorizontalGap(context)),
//           Expanded(
//             child: CustomText.body(
//               text: AppStrings.loginViaGovIdentity,
//               context: context,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSignInLink() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         CustomText.body(text: AppStrings.alreadyRegistered, context: context),
//         GestureDetector(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => const LoginScreen()),
//             );
//           },
//           child: CustomText.link(text: AppStrings.signIn, context: context),
//         ),
//       ],
//     );
//   }
// }
