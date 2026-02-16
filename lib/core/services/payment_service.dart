import '../../util/app_url.dart';
import 'base_service.dart';

/// Service for payment-related operations
class PaymentService extends BaseService {
  PaymentService(super.apiClient);

  /// Generate PSID for payment
  Future<Map<String, dynamic>?> generatePSID({
    required String cnic,
    required double amount,
    required String purpose,
  }) async {
    final data = {
      'CNIC': cnic,
      'Amount': amount.toString(),
      'Purpose': purpose,
    };

    try {
      final response = await apiClient.request(
        method: 'POST',
        endpoint: ApiEndpoints.generatePSID,
        data: data,
      );

      return response is Map<String, dynamic> ? response : null;
    } catch (e) {
      return null;
    }
  }

  /// Enquire PSID status
  Future<Map<String, dynamic>?> enquirePSID({required String psid}) async {
    final data = {'PSID': psid};

    try {
      final response = await apiClient.request(
        method: 'POST',
        endpoint: ApiEndpoints.confirmPSIDStatus,
        data: data,
      );

      return response is Map<String, dynamic> ? response : null;
    } catch (e) {
      return null;
    }
  }

  /// Process bill payment
  Future<Map<String, dynamic>?> billPayment({
    required String psid,
    required String cnic,
    required double amount,
    required String bankCode,
  }) async {
    final data = {
      'PSID': psid,
      'CNIC': cnic,
      'Amount': amount.toString(),
      'BankCode': bankCode,
    };

    try {
      final response = await apiClient.request(
        method: 'POST',
        endpoint: ApiEndpoints.billPayment,
        data: data,
      );

      return response is Map<String, dynamic> ? response : null;
    } catch (e) {
      return null;
    }
  }

  /// Get Arms License PSID
  Future<String?> getArmsLicensePSID({
    required String cnic,
    required String licenseNo,
  }) async {
    final data = {'CNIC': cnic, 'LicenseNo': licenseNo};

    try {
      final response = await apiClient.request(
        method: 'POST',
        endpoint: ApiEndpoints.getPSID,
        data: data,
      );

      if (response != null && response is Map<String, dynamic>) {
        return response['PSID']?.toString();
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Get pending transactions
  Future<List<dynamic>> getPendingTransactions({required String cnic}) async {
    final data = {'CNIC': cnic};

    try {
      final response = await apiClient.request(
        method: 'POST',
        endpoint: ApiEndpoints.getPendingTransactions,
        data: data,
      );

      if (response != null && response is Map<String, dynamic>) {
        return response['pendingDues'] ?? [];
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  /// Get received/done transactions
  Future<List<dynamic>> getReceivedTransactions({required String cnic}) async {
    final data = {'CNIC': cnic};

    try {
      final response = await apiClient.request(
        method: 'POST',
        endpoint: ApiEndpoints.getReceivedTransactions,
        data: data,
      );

      if (response != null && response is Map<String, dynamic>) {
        return response['receivedData'] ?? [];
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}
