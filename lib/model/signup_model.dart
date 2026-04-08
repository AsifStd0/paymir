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
  final String? otp;
  final bool responseStatus;

  SignupResponse({
    this.statusCode,
    this.responseMessage,
    this.data,
    this.otp,
    this.responseStatus = false,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      statusCode: json["statusCode"]?.toString(),
      responseMessage: json["responseMessage"],
      data: json["data"],
      otp: json["otp"]?.toString(),
      responseStatus:
          json["responseStatus"] == true || json["responseStatus"] == "true",
    );
  }

  bool get isSuccess =>
      (statusCode == "200" || statusCode == "201" || statusCode == "202") &&
      responseStatus;

  bool get isRegistered => statusCode == "201";
  bool get isUnverified => statusCode == "202";
}
