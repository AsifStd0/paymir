import 'dart:convert';

import '../../util/NetworkHelperClass.dart';

/// Service for home screen API calls
class HomeService {
  /// Get card details
  Future<Map<String, dynamic>> getCardDetail({
    required String cnic,
    required String token,
  }) async {
    final data = {"CNIC": cnic};
    final auth = "Bearer $token";
    final responseBody = await NetworkHelper.getCardDetail(data, auth);

    if (responseBody != null) {
      return jsonDecode(responseBody);
    }
    throw Exception('Failed to load card details');
  }

  /// Get pending transactions
  Future<Map<String, dynamic>> getPendingTransactions({
    required String cnic,
    required String token,
  }) async {
    final data = {
      "DPTPaymentID": "NULL",
      "CNIC": cnic,
      "Using": "CNICNo",
      "PaymentPlatform": "Jazz Cash",
      "PaymentMode": "MobileWallet",
    };
    final auth = "Bearer $token";
    final responseBody = await NetworkHelper.getPendingTransactions(data, auth);

    if (responseBody != null) {
      return jsonDecode(responseBody);
    }
    throw Exception('Failed to load pending transactions');
  }

  /// Get done transactions
  Future<Map<String, dynamic>> getDoneTransactions({
    required String cnic,
    required String token,
  }) async {
    final data = {"CNIC": cnic};
    final auth = "Bearer $token";
    final responseBody = await NetworkHelper.loadDoneApplicationDetails(
      data,
      auth,
    );

    if (responseBody != null) {
      return jsonDecode(responseBody);
    }
    throw Exception('Failed to load done transactions');
  }

  /// Get profile details
  Future<Map<String, dynamic>> getProfileDetail({
    required String cnic,
    required String token,
  }) async {
    final data = {"CNIC": cnic};
    final auth = "Bearer $token";
    final responseBody = await NetworkHelper.getProfileDetail(data, auth);

    if (responseBody != null) {
      return jsonDecode(responseBody);
    }
    throw Exception('Failed to load profile details');
  }
}
