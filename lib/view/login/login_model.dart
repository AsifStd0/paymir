class LoginRequest {
  final String username;
  final String password;
  final String grantType;
  final String category;

  LoginRequest({
    required this.username,
    required this.password,
    this.grantType = "password",
    this.category = "PAYMIR",
  });

  Map<String, dynamic> toJson() {
    return {
      "grant_type": grantType,
      "username": username,
      "password": password,
      "Category": category,
    };
  }
}

class LoginResponse {
  final String? accessToken;
  final String? tokenType;
  final int? expiresIn;
  final String? error;
  final String? errorDescription;
  final bool isSuccess;

  LoginResponse({
    this.accessToken,
    this.tokenType,
    this.expiresIn,
    this.error,
    this.errorDescription,
    required this.isSuccess,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json["access_token"],
      tokenType: json["token_type"],
      expiresIn: json["expires_in"],
      error: json["error"],
      errorDescription: json["error_description"],
      isSuccess: json["access_token"] != null,
    );
  }

  bool get hasError => error != null || errorDescription != null;
  bool get isUnverified =>
      errorDescription?.toLowerCase().contains("unverified") ?? false;
}
