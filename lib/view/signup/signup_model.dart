class SignupModel {
  final String fullName;
  final String emailAddress;
  final String cnic;
  final String password;
  final String category;

  SignupModel({
    required this.fullName,
    required this.emailAddress,
    required this.cnic,
    required this.password,
    this.category = "PAYMIR",
  });

  Map<String, String> toJson() {
    return {
      'fullname': fullName,
      'emailAddress': emailAddress,
      'cnic': cnic,
      'password': password,
      'Category': category,
    };
  }

  factory SignupModel.fromJson(Map<String, dynamic> json) {
    return SignupModel(
      fullName: json['fullname'] ?? '',
      emailAddress: json['emailAddress'] ?? '',
      cnic: json['cnic'] ?? '',
      password: json['password'] ?? '',
      category: json['Category'] ?? 'PAYMIR',
    );
  }
}

class CheckUserResponse {
  final String statusCode;
  final String responseMessage;
  final bool responseStatus;

  CheckUserResponse({
    required this.statusCode,
    required this.responseMessage,
    required this.responseStatus,
  });

  factory CheckUserResponse.fromJson(Map<String, dynamic> json) {
    return CheckUserResponse(
      statusCode: json['statusCode']?.toString() ?? '',
      responseMessage: json['responseMessage'] ?? '',
      responseStatus: json['responseStatus'] ?? false,
    );
  }
}
