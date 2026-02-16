class ApiEndpoints {
  // ============================================
  // BASE URL
  // ============================================
  static const String baseUrl = 'https://apipaymir.kp.gov.pk/';

  // ============================================
  // AUTHENTICATION ENDPOINTS
  // ============================================
  static const String login = 'api/token';
  static const String registerUser = 'api/user/RegisterUser';
  static const String checkVerifiedCNIC = 'api/user/CheckVerifiedCNIC';
  static const String verifyUser = 'api/user/verifyUser';

  static const String verifyUserForResettingPassword =
      'api/User/VerifyUserForResettingPassword';
  static const String resetPassword = 'api/User/ResetPassword';

  // ============================================
  // USER PROFILE ENDPOINTS
  // ============================================
  static const String getCardDetail = 'api/user/GetCardDetail';
  static const String requestForEditProfile = 'api/user/RequestforEditProfile';
  static const String attemptForEditProfile = 'api/user/AttemptforEditProfile';
  static const String sendOTPEditProfile =
      'api/user/SendOTPtoMobileandEmail_AttemptforEditProfile';
  static const String uploadProfileImg = 'api/user/UploadProfileImg';
  static const String downloadProfileImg = 'api/user/DownloadProfileImg';
  static const String getOldPassword = 'api/user/GetOldPassword';
  static const String updateOldPassword = 'api/user/UpdateOldPassword';

  // ============================================
  // SERVICE & PAYMENT ENDPOINTS
  // ============================================
  static const String billPayment = 'api/service/BillPayment';
  static const String generatePSID = 'api/service/GeneratePSID';
  static const String confirmPSIDStatus = 'api/service/ConfirmPSIDStatus';
  static const String getPSID = 'api/service/GetPSID';
  static const String getPendingTransactions =
      'api/service/getPendingTransactions';
  static const String getReceivedTransactions =
      'api/service/getReceivedTransactions';

  // ============================================
  // COMPLAINT ENDPOINTS
  // ============================================
  static const String registerComplaint = 'api/user/RegisterComplaint';

  // ============================================
  // HELPER METHODS
  // ============================================

  /// Get full URL for an endpoint
  static String getFullUrl(String endpoint) {
    // Remove leading slash if present
    final cleanEndpoint =
        endpoint.startsWith('/') ? endpoint.substring(1) : endpoint;
    return '$baseUrl$cleanEndpoint';
  }

  /// Get full URL for an endpoint (with base URL)
  static String url(String endpoint) {
    return getFullUrl(endpoint);
  }
}
