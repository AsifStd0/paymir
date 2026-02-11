/// Centralized string constants for the entire application
/// All UI text should be defined here for easy maintenance and localization
class AppStrings {
  // App Name
  static const String appName = 'Paymir';

  // Authentication
  static const String signIn = 'Sign In';
  static const String signUp = 'Sign Up';
  static const String signOut = 'Sign Out';
  static const String alreadyRegistered = 'Already Registered? ';
  static const String notRegistered = 'Not Registered? ';
  static const String forgotPassword = 'Forgot Password?';
  static const String createAccount = 'Create Account';
  static const String loginViaGovIdentity = 'Login via Gov e Identity';

  // Sign In Screen
  static const String signInTitle = 'Sign In';
  static const String signInSubtitle = 'You have been missed';
  static const String cnic = 'CNIC';
  static const String password = 'Password';
  static const String email = 'Email Address';
  static const String emailAddress = 'Email Address';

  // Sign Up Screen
  static const String signUpTitle = 'Sign Up';
  static const String signUpSubtitle =
      'It only takes a minute to create your account';
  static const String firstName = 'First Name';
  static const String lastName = 'Last Name';
  static const String fullName = 'Full Name';
  static const String mobileNumber = 'Mobile Number';
  static const String phoneNumber = 'Phone Number';
  static const String confirmPassword = 'Confirm Password';
  static const String agreeTerms = 'I agree with the ';
  static const String termsOfService = 'Terms of Services ';
  static const String and = 'and ';
  static const String privacyPolicy = 'Privacy Policy';

  // Mobile Verification
  static const String setupTwoStepVerification = 'Set up 2-step verification';
  static const String enterPhoneNumber =
      'Enter your phone number so that we can send you verification code';
  static const String verify = 'Verify';
  static const String continueText = 'Continue';

  // Buttons
  static const String ok = 'OK';
  static const String cancel = 'Cancel';
  static const String close = 'Close';
  static const String submit = 'Submit';
  static const String save = 'Save';
  static const String delete = 'Delete';
  static const String edit = 'Edit';
  static const String back = 'Back';
  static const String next = 'Next';
  static const String done = 'Done';
  static const String retry = 'Retry';

  // Dividers
  static const String or = 'OR';

  // Error Messages
  static const String error = 'Error';
  static const String noInternet = 'No Internet';
  static const String checkInternetConnection =
      'Check your internet connection!';
  static const String somethingWentWrong = 'Something went wrong';
  static const String pleaseTryAgain = 'Please try again';
  static const String registrationFailed = 'Registration Failed';
  static const String loginFailed = 'Login Failed';
  static const String providerError = 'Provider Error';
  static const String providerNotInitialized =
      'Please restart the app. Provider not initialized.';

  // Success Messages
  static const String success = 'Success';
  static const String registrationSuccessful = 'Registration successful';
  static const String loginSuccessful = 'Login successful';
  static const String verificationCodeSent =
      'A verification code has been sent to the associated mobile number. Please verify!';

  // Validation Messages
  static const String invalidCnic = 'Invalid CNIC';
  static const String invalidEmail = 'Invalid Email';
  static const String invalidPassword = 'Invalid Password';
  static const String invalidPhoneNumber = 'Invalid phone number';
  static const String phoneNumberFormat = 'Valid format is 3123456789';
  static const String cnicVerificationFailed = 'CNIC verification failed';
  static const String unverifiedCnic = 'Unverified CNIC';

  // Alert Dialog Titles
  static const String alertTitle = 'Alert';
  static const String response = 'Response';
  static const String warning = 'Warning';
  static const String info = 'Information';

  // Alert Dialog Messages
  static const String pleaseVerifyMobile = 'Please verify your mobile number.';
  static const String registrationFailedMessage =
      'Registration failed. Please try again.';
  static const String loginFailedMessage = 'Login failed. Please try again.';

  // Placeholders
  static const String enterCnic = 'Enter CNIC';
  static const String enterPassword = 'Enter Password';
  static const String enterEmail = 'Enter Email';
  static const String enterFirstName = 'Enter First Name';
  static const String enterLastName = 'Enter Last Name';
  static const String enterPhone = 'Enter Phone Number';

  // Home Screen
  static const String home = 'Home';
  static const String services = 'Services';
  static const String profile = 'Profile';
  static const String more = 'More';

  // Profile
  static const String myProfile = 'My Profile';
  static const String editProfile = 'Edit Profile';
  static const String updateProfile = 'Update Profile';

  // Common
  static const String loading = 'Loading...';
  static const String pleaseWait = 'Please wait...';
  static const String noData = 'No Data Available';
}
