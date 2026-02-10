import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkHelper {
  static const String _baseUrl = 'https://apipaymir.kp.gov.pk/';
  static Future<String?> signUp(Map<String, dynamic> data) async {
    final url = Uri.parse('$_baseUrl/api/user/registerUser');
    final encoding = Encoding.getByName('utf-8');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final response = await http.post(
      url,
      headers: headers,
      body: data,
      encoding: encoding,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> signIn(Map<String, dynamic> data) async {
    final url = Uri.parse('$_baseUrl/api/token');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final encoding = Encoding.getByName('utf-8');
    final response = await http.post(
      url,
      headers: headers,
      body: data,
      encoding: encoding,
    );
    print(response.body);
    print(response.statusCode);
    return response.body;
  }

  static Future<bool> checkInternetConnection() async {
    bool isConnected = await InternetConnectionChecker().hasConnection;
    return isConnected;
  }

  static Future<String?> checkUser(Map<String, dynamic> data) async {
    log('checking user *** 1111 $data');
    final url = Uri.parse('$_baseUrl/api/user/CheckVerifiedCNIC');
    log('url: $url');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final encoding = Encoding.getByName('utf-8');
    final response = await http.post(
      url,
      headers: headers,
      body: data,
      encoding: encoding,
    );
    return response.body;
  }

  static Future<String?> editProfile(
    Map<String, dynamic> data,
    String auth,
  ) async {
    final url = Uri.parse('$_baseUrl/api/user/AttemptforEditProfile');

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': auth,
    };

    Response response = await post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );

    return response.body;
  }

  static Future<String?> sendOTPEditProfile(
    Map<String, dynamic> data,
    String auth,
  ) async {
    final url = Uri.parse(
      '$_baseUrl/api/user/SendOTPtoMobileandEmail_AttemptforEditProfile',
    );

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': auth,
    };

    Response response = await post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );

    return response.body;
  }

  static Future<String?> verifyUserforResettingPassword(
    Map<String, dynamic> data,
  ) async {
    final url = Uri.parse('$_baseUrl/api/User/VerifyUserForResettingPassword');
    final encoding = Encoding.getByName('utf-8');
    final response = await post(url, body: data, encoding: encoding);
    return response.body;
  }

  static Future<String?> BillPayment(
    Map<String, dynamic> data,
    String auth,
  ) async {
    final url = Uri.parse('$_baseUrl/api/service/BillPayment');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': auth,
    };
    Response response = await post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );
    return response.body;
  }

  static Future<String?> getCardDetail(
    Map<String, dynamic> data,
    String auth,
  ) async {
    final url = Uri.parse('$_baseUrl/api/user/GetCardDetail');

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': auth,
    };

    Response response = await post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );

    return response.body;
  }

  static Future<String?> getProfileDetail(
    Map<String, dynamic> data,
    String auth,
  ) async {
    final url = Uri.parse('$_baseUrl/api/user/RequestforEditProfile');

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': auth,
    };

    Response response = await post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );

    return response.body;
  }

  static Future<String?> generatePSIDApi(
    Map<String, dynamic> data,
    String auth,
  ) async {
    final url = Uri.parse('$_baseUrl/api/service/GeneratePSID');

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': auth,
    };

    Response response = await post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );

    return response.body;
  }

  static Future<String?> enquirePSIDApi(
    Map<String, dynamic> data,
    String auth,
  ) async {
    final url = Uri.parse('$_baseUrl/api/service/ConfirmPSIDStatus');

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': auth,
    };

    Response response = await post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );

    return response.body;
  }

  static Future<String?> uploadProfileImage(
    Map<String, dynamic> data,
    String auth,
  ) async {
    final url = Uri.parse('$_baseUrl/api/user/UploadProfileImg');

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': auth,
    };

    Response response = await post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );

    return response.body;
  }

  static Future<String?> downloadProfileImage(
    Map<String, dynamic> data,
    String auth,
  ) async {
    final url = Uri.parse('$_baseUrl/api/user/DownloadProfileImg');

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': auth,
    };

    Response response = await post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );

    return response.body;
  }

  static Future<String?> getPendingTransactions(
    Map<String, dynamic> data,
    String auth,
  ) async {
    final url = Uri.parse('$_baseUrl/api/service/getPendingTransactions');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': auth,
    };
    Response response = await post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );
    return response.body;
  }

  static Future<String?> getArmsLicensePSID(
    Map<String, dynamic> data,
    String auth,
  ) async {
    final url = Uri.parse('$_baseUrl/api/service/GetPSID');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': auth,
    };
    Response response = await post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );
    return response.body;
  }

  static Future<String?> loadDoneApplicationDetails(
    Map<String, dynamic> data,
    String auth,
  ) async {
    final url = Uri.parse('$_baseUrl/api/service/getReceivedTransactions');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': auth,
    };

    Response response = await post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );
    return response.body;
  }

  static Future<String?> verifyUser(
    Map<String, dynamic> data,
    String endPoint,
  ) async {
    final url = Uri.parse('$_baseUrl/$endPoint');
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(url, body: data, encoding: encoding);

    return response.body;
  }

  static Future<String?> resetPassword(Map<String, dynamic> data) async {
    final url = Uri.parse('$_baseUrl/api/User/ResetPassword');

    final encoding = Encoding.getByName('utf-8');

    Response response = await post(url, body: data, encoding: encoding);

    return response.body;
  }

  static Future<String?> getOldPassword(
    Map<String, dynamic> data,
    String auth,
  ) async {
    final url = Uri.parse('$_baseUrl/api/user/GetOldPassword');
    final headers = {'Accept': 'application/json', 'Authorization': auth};
    Response response = await post(url, headers: headers, body: data);
    return response.body;
  }

  static Future<String?> updateOldPassword(
    Map<String, dynamic> data,
    String auth,
  ) async {
    final url = Uri.parse('$_baseUrl/api/user/UpdateOldPassword');
    final headers = {'Accept': 'application/json', 'Authorization': auth};

    Response response = await post(url, headers: headers, body: data);
    return response.body;
  }

  static Future<String?> registerComplaint(
    Map<String, dynamic> data,
    String auth,
  ) async {
    final url = Uri.parse('$_baseUrl/api/user/RegisterComplaint');
    final headers = {'Accept': 'application/json', 'Authorization': auth};

    Response response = await post(url, headers: headers, body: data);
    return response.body;
  }
}
