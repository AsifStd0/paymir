import '../../../util/MyValidation.dart';

class CustomValidation {
  static String? validateName(String? value) {
    return MyValidationClass.validateName(value);
  }

  static String? validateEmail(String? value) {
    return MyValidationClass.validateEmail(value);
  }

  static String? validateCNIC(String? value) {
    return MyValidationClass.validateCNIC(value);
  }

  static String? validatePassword(String? value) {
    return MyValidationClass.validatePassword(value);
  }

  static String? validateEmailPassword(String? value) {
    return MyValidationClass.validateEmailPassword(value);
  }
}
