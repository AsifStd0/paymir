// import 'package:extended_masked_text/extended_masked_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:provider/provider.dart';

// import '../../providers/auth/login_provider.dart';
// import '../../utils/app_strings.dart';
// import '../../utils/constants.dart';
// import '../../util/AlertDialogueClass.dart';
// import '../../util/MyValidation.dart';
// import '../../widget/custom/custom_button.dart';
// import '../../widget/custom/custom_text.dart';
// import '../../widget/custom/custom_textfield.dart';
// import '../home/home_screen.dart';
// import 'signup_screen.dart';
// import 'forgot_password_screen.dart';

// /// Login screen for user authentication
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _cnicController = MaskedTextController(
//     mask: '00000-0000000-0',
//   );
//   final TextEditingController _passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   bool _passwordVisible = false; // Fallback state

//   void _submit() {
//     if (_formKey.currentState!.validate()) {
//       // Form validation passed
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         return (await ShowAlertDialogueClass.exitAppDialog(context));
//       },
//       child: Scaffold(
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 _buildBackButton(),
//                 _buildForm(),
//               ],
//             ),
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
//             onPressed: () async {
//               await ShowAlertDialogueClass.exitAppDialog(context);
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
//               text: AppStrings.signInTitle,
//               context: context,
//             ),
//             SizedBox(
//               height: Constants.getVerticalGapBetweenMainAndSmallFont(context),
//             ),
//             CustomText.subtitle(
//               text: AppStrings.signInSubtitle,
//               context: context,
//             ),
//             SizedBox(
//               height: Constants.getVerticalGapBetweenSmallfontAndTextfield(context),
//             ),
//             CustomTextField.cnic(controller: _cnicController),
//             SizedBox(
//               height: Constants.getVerticalGapBetweenTwoTextformfields(context),
//             ),
//             _buildPasswordField(),
//             _buildForgotPasswordButton(),
//             SizedBox(
//               height: Constants.getVerticalGapBetweenForgotPasswordAndSignInButton(context),
//             ),
//             _buildSignInButton(),
//             _buildDivider(),
//             _buildGovIdentityButton(),
//             SizedBox(
//               height: Constants.getVerticalGapAfterLoginViaGovLogInPage(context),
//             ),
//             _buildSignUpLink(),
//             const SizedBox(height: 30),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPasswordField() {
//     return Builder(
//       builder: (builderContext) {
//         try {
//           final loginProvider = Provider.of<LoginProvider>(
//             builderContext,
//             listen: true,
//           );
//           return CustomTextField.password(
//             controller: _passwordController,
//             obscureText: !loginProvider.passwordVisible,
//             onToggleVisibility: () {
//               loginProvider.togglePasswordVisibility();
//             },
//             validator: (value) => MyValidationClass.validateEmailPassword(value),
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
//             validator: (value) => MyValidationClass.validateEmailPassword(value),
//           );
//         }
//       },
//     );
//   }

//   Widget _buildForgotPasswordButton() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         TextButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => ForgotPasswordScreen(),
//               ),
//             );
//           },
//           child: CustomText.forgotPassword(
//             text: AppStrings.forgotPassword,
//             context: context,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSignInButton() {
//     return Builder(
//       builder: (builderContext) {
//         try {
//           final loginProvider = Provider.of<LoginProvider>(
//             builderContext,
//             listen: true,
//           );
//           return CustomButton(
//             onPressed: () async {
//               _submit();
//               if (MyValidationClass.validateCNIC(_cnicController.text) == null &&
//                   MyValidationClass.validatePassword(_passwordController.text) == null) {
//                 final success = await loginProvider.login(
//                   cnic: _cnicController.text,
//                   password: _passwordController.text,
//                   context: builderContext,
//                 );
//                 if (success && mounted) {
//                   Navigator.pushReplacement(
//                     builderContext,
//                     MaterialPageRoute(
//                       builder: (_) => const HomeScreen(),
//                     ),
//                   );
//                 }
//               }
//             },
//             text: AppStrings.signIn,
//             isLoading: loginProvider.isLoading,
//             isEnabled: true,
//           );
//         } catch (e) {
//           return CustomButton(
//             onPressed: () {
//               ShowAlertDialogueClass.showAlertDialogue(
//                 context: builderContext,
//                 title: AppStrings.providerError,
//                 message: AppStrings.providerNotInitialized,
//                 buttonText: AppStrings.ok,
//                 iconData: Icons.error,
//               );
//             },
//             text: AppStrings.signIn,
//             isLoading: false,
//             isEnabled: true,
//           );
//         }
//       },
//     );
//   }

//   Widget _buildDivider() {
//     return Column(
//       children: [
//         SizedBox(
//           height: Constants.getVerticalGapBetweenTwoTextformfields(context) * 20,
//         ),
//         Row(
//           children: [
//             Expanded(
//               child: Divider(
//                 thickness: 1,
//                 color: Colors.grey.shade400,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               child: CustomText.divider(
//                 text: AppStrings.or,
//                 context: context,
//               ),
//             ),
//             Expanded(
//               child: Divider(
//                 thickness: 1,
//                 color: Colors.grey.shade400,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: Constants.getVerticalGapBetweenTwoTextformfields(context) * 20,
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
//           SizedBox(
//             width: Constants.getLoginViaEIdentityHorizontalGap(context),
//           ),
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

//   Widget _buildSignUpLink() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         CustomText.body(
//           text: AppStrings.notRegistered,
//           context: context,
//         ),
//         GestureDetector(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => const SignupScreen(),
//               ),
//             );
//           },
//           child: CustomText.link(
//             text: AppStrings.signUp,
//             context: context,
//           ),
//         ),
//       ],
//     );
//   }
// }
