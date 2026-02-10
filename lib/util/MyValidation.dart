import 'package:flutter/foundation.dart';

class MyValidationClass extends ChangeNotifier {

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty!';
    }
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!))
      return 'Invalid email address!';
    else
      return null;
  }

  static String? validateFourDigitsCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Code cannot be empty!';
    }
    if (value!.length<4)
      return 'Code must be of 4 digits!';
    else
      return null;
  }

  static String? validateCNIC(String? value) {
    if (value == null || value.isEmpty) {
      return 'CNIC cannot be empty!';
    }
    if (value.length < 15) {
      return 'Invalid CNIC!';
    }
    return null;
  }

  static String? validateMobileforEditProfile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile number cannot be empty!';
    } else if (value.length != 10) {
      return 'Mobile number must be 10 digits long!';
    } else if (!value.startsWith('3')) {
      return 'Mobile number must start with "3"!';
    } else {
      return null;
    }
  }

  static String? validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile number cannot be empty!';
    } else if (value.length != 11) {
      return 'Mobile number must be 11 digits long!';
    } else if (!value.startsWith('03')) {
      return 'Mobile number must start with "03"!';
    } else {
      return null;
    }
  }

  static String? validatePSID(String? value) {
    if (value == null || value.isEmpty) {
      return 'PSID cannot be empty!';
    } else if (value.length < 17) {
      return 'PSID must be at least 17 digits long!';
    } else {
      return null;
    }
  }
  static String? validateVoucher(String? value) {
    if (value == null || value.isEmpty) {
      return 'Voucher cannot be empty!';
    } else if (value.length < 19) {
      return 'Voucher must be at least 19 digits long!';
    } else {
      return null;
    }
  }


  static String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Empty name!';
    }
    String pattern =
        r'^([a-zA-Z. ]{3,})+$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Invalid name!';
    else if (value.startsWith(' '))
      return 'Space in the start!';
    else if (value.endsWith(' '))
      return 'Space in the end!';
    else
      return null;
  }



  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name cannot be empty!';
    }
    String pattern =
        r'^([a-zA-Z ]{3,})+$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Invalid name!';
    else if (value.startsWith(' '))
      return 'Space in the start!';
    else if (value.endsWith(' '))
      return 'Space in the end!';
    else
      return null;
  }

  static String? validatePassword(String? password) {

    if (password == null || password.isEmpty) {
      return 'Password cannot be empty!';
    }
    if (password.isEmpty) {
      return 'Password cannot be empty.';
    }
    if (password.length < 8) {
      return 'Password must be at least 8 characters long.';
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter.';
    }
    if (!password.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter.';
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one digit.';
    }
    if (!password.contains(RegExp(r'[!@#\$%\^&\*(),\.\?":{}|<>]'))) {
      return 'Password must contain at least one special character.';
    }
    if (password.contains(RegExp(r'\s'))) {
      return 'Password must not contain spaces.';
    }
    return null;
  }

  static String? validateOldPassword(String? password) {

    if (password == null || password.isEmpty) {
      return 'Enter old password!';
    }
    if (password.length < 8) {
      return 'Incorrect old password!';
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'Incorrect old password!';
    }
    if (!password.contains(RegExp(r'[a-z]'))) {
      return 'Incorrect old password!';
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      return 'Incorrect old password!';
    }
    if (!password.contains(RegExp(r'[!@#\$%\^&\*(),\.\?":{}|<>]'))) {
      return 'Incorrect old password!';

    }
    if (password.contains(RegExp(r'\s'))) {
      return 'Incorrect old password!';
    }
    return null;
  }

  static String? validateEmailPassword(String? password) {

    if (password == null || password.isEmpty) {
      return 'Enter password!';
    }
    if (password.length < 8) {
      return 'Incorrect password!';
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'Incorrect password!';
    }
    if (!password.contains(RegExp(r'[a-z]'))) {
      return 'Incorrect password!';
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      return 'Incorrect password!';
    }
    if (!password.contains(RegExp(r'[!@#\$%\^&\*(),\.\?":{}|<>]'))) {
      return 'Incorrect password!';

    }
    if (password.contains(RegExp(r'\s'))) {
      return 'Incorrect password!';
    }
    return null;
  }

  static String? validateRePassword(String? password) {

    if (password == null || password.isEmpty) {
      return 'Enter password again!';
    }
    else
      return null;
  }



}