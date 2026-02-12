/// Data models for profile operations

/// Complaint registration request
class ComplaintRequest {
  final String cnic;
  final String category;
  final String description;

  ComplaintRequest({
    required this.cnic,
    required this.category,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {'CNIC': cnic, 'Category': category, 'Description': description};
  }
}

/// Complaint registration response
class ComplaintResponse {
  final String statusCode;
  final String responseMessage;
  final bool isSuccess;

  ComplaintResponse({
    required this.statusCode,
    required this.responseMessage,
    required this.isSuccess,
  });

  factory ComplaintResponse.fromJson(Map<String, dynamic> json) {
    return ComplaintResponse(
      statusCode: json['statusCode']?.toString() ?? '',
      responseMessage: json['responseMessage']?.toString() ?? '',
      isSuccess: json['statusCode']?.toString() == '200',
    );
  }
}

/// Password update request
class PasswordUpdateRequest {
  final String cnic;
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  PasswordUpdateRequest({
    required this.cnic,
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {'CNIC': cnic, 'Password': newPassword};
  }
}

/// Password update response
class PasswordUpdateResponse {
  final String statusCode;
  final String responseMessage;
  final bool isSuccess;

  PasswordUpdateResponse({
    required this.statusCode,
    required this.responseMessage,
    required this.isSuccess,
  });

  factory PasswordUpdateResponse.fromJson(Map<String, dynamic> json) {
    return PasswordUpdateResponse(
      statusCode: json['statusCode']?.toString() ?? '',
      responseMessage: json['responseMessage']?.toString() ?? '',
      isSuccess: json['statusCode']?.toString() == '200',
    );
  }
}

/// Profile image upload request
class ProfileImageUploadRequest {
  final String cnic;
  final String base64Image;

  ProfileImageUploadRequest({required this.cnic, required this.base64Image});

  Map<String, dynamic> toJson() {
    return {'CNIC': cnic, 'Base64_txt_encoder': base64Image};
  }
}

/// Profile image upload response
class ProfileImageUploadResponse {
  final String statusCode;
  final String responseMessage;
  final bool isSuccess;

  ProfileImageUploadResponse({
    required this.statusCode,
    required this.responseMessage,
    required this.isSuccess,
  });

  factory ProfileImageUploadResponse.fromJson(Map<String, dynamic> json) {
    return ProfileImageUploadResponse(
      statusCode: json['statusCode']?.toString() ?? '',
      responseMessage: json['responseMessage']?.toString() ?? '',
      isSuccess: json['statusCode']?.toString() == '200',
    );
  }
}

/// Old password response
class OldPasswordResponse {
  final String responseMessage;
  final String? oldPassword;

  OldPasswordResponse({required this.responseMessage, this.oldPassword});

  factory OldPasswordResponse.fromJson(Map<String, dynamic> json) {
    final responseMessage = json['responseMessage']?.toString() ?? '';
    String? password;

    if (responseMessage.contains(':')) {
      try {
        password = responseMessage.split(':')[1].trim();
      } catch (e) {
        password = null;
      }
    }

    return OldPasswordResponse(
      responseMessage: responseMessage,
      oldPassword: password,
    );
  }
}

/// Edit profile request
class EditProfileRequest {
  final String cnic;
  final String fullName;
  final String emailAddress;
  final String mobileNo;

  EditProfileRequest({
    required this.cnic,
    required this.fullName,
    required this.emailAddress,
    required this.mobileNo,
  });

  Map<String, dynamic> toJson() {
    return {
      'CNIC': cnic,
      'FullName': fullName,
      'EmailAddress': emailAddress,
      'MobileNo': mobileNo,
    };
  }
}

/// Edit profile response
class EditProfileResponse {
  final String statusCode;
  final String responseMessage;
  final bool isSuccess;

  EditProfileResponse({
    required this.statusCode,
    required this.responseMessage,
    required this.isSuccess,
  });

  factory EditProfileResponse.fromJson(Map<String, dynamic> json) {
    return EditProfileResponse(
      statusCode: json['statusCode']?.toString() ?? '',
      responseMessage: json['responseMessage']?.toString() ?? '',
      isSuccess: json['statusCode']?.toString() == '200',
    );
  }
}

/// Send OTP for edit profile request
class SendOTPEditProfileRequest {
  final String emailAddress;
  final String mobileNo;

  SendOTPEditProfileRequest({
    required this.emailAddress,
    required this.mobileNo,
  });

  Map<String, dynamic> toJson() {
    return {'EmailAddress': emailAddress, 'MobileNo': mobileNo};
  }
}

/// Send OTP for edit profile response
class SendOTPEditProfileResponse {
  final String statusCode;
  final String responseMessage;
  final String? otp;
  final bool isSuccess;

  SendOTPEditProfileResponse({
    required this.statusCode,
    required this.responseMessage,
    this.otp,
    required this.isSuccess,
  });

  factory SendOTPEditProfileResponse.fromJson(Map<String, dynamic> json) {
    return SendOTPEditProfileResponse(
      statusCode: json['statusCode']?.toString() ?? '',
      responseMessage: json['responseMessage']?.toString() ?? '',
      otp: json['otp']?.toString(),
      isSuccess: json['statusCode']?.toString() == '200',
    );
  }
}
