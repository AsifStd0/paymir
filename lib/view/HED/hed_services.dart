import 'dart:convert';

import '../../util/NetworkHelperClass.dart';

/// Service for HED page API calls
class HedService {
  /// Get pending transactions by mobile number
  Future<Map<String, dynamic>> getPendingTransactionsByMobile({
    required String mobileNo,
    required String token,
  }) async {
    final data = {
      "DPTPaymentID": "NULL",
      "MobileNoForVoucher": mobileNo,
      "Using": "MobileNo",
    };
    final auth = "Bearer $token";
    final responseBody = await NetworkHelper.getPendingTransactions(data, auth);

    if (responseBody != null) {
      return jsonDecode(responseBody);
    }
    throw Exception('Failed to load pending transactions');
  }

  /// Get done transactions by mobile number
  Future<Map<String, dynamic>> getDoneTransactionsByMobile({
    required String mobileNo,
    required String token,
  }) async {
    final data = {"MobileNoForVoucher": mobileNo, "Using": "MobileNo"};
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

  /// Get card details by CNIC
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
}
