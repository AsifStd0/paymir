import 'dart:convert';

import '../../util/NetworkHelperClass.dart';

/// Service for voucher page API calls
class VoucherService {
  /// Get pending transactions by voucher number (DPTPaymentID)
  Future<Map<String, dynamic>> getPendingTransactionsByVoucher({
    required String dtpPaymentID,
    required String cnic,
    required String token,
  }) async {
    final data = {
      "DPTPaymentID": dtpPaymentID,
      "CNIC": cnic,
      "Using": "DPTPayID",
      "PaymentPlatform": "Jazz Cash",
      "PaymentMode": "MobileWallet",
    };

    final auth = "Bearer $token";
    final responseBody = await NetworkHelper.getPendingTransactions(data, auth);

    if (responseBody != null) {
      if (responseBody.contains("false")) {
        throw Exception('No record found');
      }
      return jsonDecode(responseBody);
    }
    throw Exception('Failed to load pending transactions');
  }
}
