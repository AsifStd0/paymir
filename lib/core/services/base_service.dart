import '../../api/api_client.dart';

/// Base class for all services
/// All services should extend this class to get access to ApiClient
abstract class BaseService {
  final ApiClient apiClient;

  BaseService(this.apiClient);
}
