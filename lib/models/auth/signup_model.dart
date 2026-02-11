/// Signup request and response models
class SignupRequest {
  final String cnic;
  final String password;
  final String fullName;
  final String mobileNo;
  final String emailAddress;
  final String userType;
  final int roleId;
  final String category;

  SignupRequest({
    required this.cnic,
    required this.password,
    required this.fullName,
    required this.mobileNo,
    required this.emailAddress,
    this.userType = "NormalUser",
    this.roleId = 1,
    this.category = "PAYMIR",
  });

  Map<String, dynamic> toJson() {
    return {
      "CNIC": cnic,
      "Password": password,
      "FullName": fullName,
      "MobileNo": mobileNo,
      "EmailAddress": emailAddress,
      "UserType": userType,
      "RoleId": roleId,
      "Category": category,
    };
  }
}

class SignupResponse {
  final String? statusCode;
  final String? responseMessage;
  final dynamic data;

  SignupResponse({this.statusCode, this.responseMessage, this.data});

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      statusCode: json["statusCode"]?.toString(),
      responseMessage: json["responseMessage"],
      data: json["data"],
    );
  }

  bool get isSuccess => statusCode == "200" || statusCode == 200;
}
