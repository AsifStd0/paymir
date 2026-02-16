import '../../util/app_url.dart';
import 'base_service.dart';

/// Service for complaint-related operations
class ComplaintService extends BaseService {
  ComplaintService(super.apiClient);

  /// Register a complaint
  Future<bool> registerComplaint({
    required String cnic,
    required String category,
    required String description,
  }) async {
    final data = {
      'CNIC': cnic,
      'Category': category,
      'Description': description,
    };

    try {
      final response = await apiClient.request(
        method: 'POST',
        endpoint: ApiEndpoints.registerComplaint,
        data: data,
        isFormData: true,
      );

      if (response != null) {
        final responseData =
            response is Map<String, dynamic>
                ? response
                : {'statusCode': response.toString()};
        return responseData['statusCode']?.toString() == '200';
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
