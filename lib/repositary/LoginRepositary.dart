import '../api/NetworkApiService.dart';
import '../model/LoginModel.dart';
import '../util/AppUrl.dart';

class LoginRepositary {
  final NetworkApiService baseApiService = NetworkApiService();

  Future<LoginModel> login(dynamic data) async {
    dynamic response = await baseApiService.postApiResponse(
      AppUrl.base_URL,
      data,
    );
    print('repository called');
    return LoginModel.fromJson(response);
  }
}
