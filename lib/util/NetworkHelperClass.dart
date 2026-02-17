import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/io_client.dart';

import 'app_url.dart';

class NetworkHelper {
  static const String _baseUrl = ApiEndpoints.baseUrl;

  /// Create HTTP client with SSL certificate bypass for testing
  /// WARNING: This is for development/testing only. Use proper certificates in production.
  static http.Client _createHttpClient() {
    final httpClient = HttpClient();
    if (kDebugMode) {
      httpClient.badCertificateCallback = (
        X509Certificate cert,
        String host,
        int port,
      ) {
        debugPrint(
          '⚠️ NetworkHelper: Bypassing SSL certificate verification for $host:$port',
        );
        return true; // Accept all certificates in development
      };
    }
    return IOClient(httpClient);
  }

  // Static client instance to reuse across requests
  static http.Client? _client;

  static http.Client get _httpClient {
    _client ??= _createHttpClient();
    return _client!;
  }

  static Future<String?> signUp(Map<String, dynamic> data) async {
    final url = Uri.parse(ApiEndpoints.getFullUrl(ApiEndpoints.registerUser));
    final encoding = Encoding.getByName('utf-8');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final response = await _httpClient.post(
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
    final url = Uri.parse(ApiEndpoints.getFullUrl(ApiEndpoints.login));
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final encoding = Encoding.getByName('utf-8');
    final response = await _httpClient.post(
      url,
      headers: headers,
      body: data,
      encoding: encoding,
    );
    print(response.body);
    print(response.statusCode);
    return response.body;
  }

  static Future<String?> checkUser(Map<String, dynamic> data) async {
    log('checking user *** 1111 $data');
    final url = Uri.parse(
      ApiEndpoints.getFullUrl(ApiEndpoints.checkVerifiedCNIC),
    );
    log('url: $url');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final encoding = Encoding.getByName('utf-8');
    final response = await _httpClient.post(
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
    final url = Uri.parse(
      ApiEndpoints.getFullUrl(ApiEndpoints.attemptForEditProfile),
    );

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': auth,
    };

    Response response = await _httpClient.post(
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
      ApiEndpoints.getFullUrl(ApiEndpoints.sendOTPEditProfile),
    );

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': auth,
    };

    Response response = await _httpClient.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );

    return response.body;
  }

  static Future<String?> verifyUserforResettingPassword(
    Map<String, dynamic> data,
  ) async {
    final url = Uri.parse(
      ApiEndpoints.getFullUrl(ApiEndpoints.verifyUserForResettingPassword),
    );
    final encoding = Encoding.getByName('utf-8');
    final response = await _httpClient.post(
      url,
      body: data,
      encoding: encoding,
    );
    return response.body;
  }

  static Future<String?> BillPayment(
    Map<String, dynamic> data,
    String auth,
  ) async {
    final url = Uri.parse(ApiEndpoints.getFullUrl(ApiEndpoints.billPayment));
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': auth,
    };
    Response response = await _httpClient.post(
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
    final url = Uri.parse(ApiEndpoints.getFullUrl(ApiEndpoints.getCardDetail));

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': auth,
    };

    Response response = await _httpClient.post(
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
    final url = Uri.parse(
      ApiEndpoints.getFullUrl(ApiEndpoints.requestForEditProfile),
    );

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': auth,
    };

    Response response = await _httpClient.post(
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
    final url = Uri.parse(ApiEndpoints.getFullUrl(ApiEndpoints.generatePSID));

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': auth,
    };

    Response response = await _httpClient.post(
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
    final url = Uri.parse(
      ApiEndpoints.getFullUrl(ApiEndpoints.confirmPSIDStatus),
    );

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': auth,
    };

    Response response = await _httpClient.post(
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
    final url = Uri.parse(
      ApiEndpoints.getFullUrl(ApiEndpoints.uploadProfileImg),
    );

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': auth,
    };

    Response response = await _httpClient.post(
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
    final url = Uri.parse(
      ApiEndpoints.getFullUrl(ApiEndpoints.downloadProfileImg),
    );

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': auth,
    };

    Response response = await _httpClient.post(
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
    final url = Uri.parse(
      ApiEndpoints.getFullUrl(ApiEndpoints.getPendingTransactions),
    );
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': auth,
    };
    Response response = await _httpClient.post(
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
    final url = Uri.parse(ApiEndpoints.getFullUrl(ApiEndpoints.getPSID));
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': auth,
    };
    Response response = await _httpClient.post(
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
    final url = Uri.parse(
      ApiEndpoints.getFullUrl(ApiEndpoints.getReceivedTransactions),
    );
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': auth,
    };

    Response response = await _httpClient.post(
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

    Response response = await _httpClient.post(
      url,
      body: data,
      encoding: encoding,
    );

    return response.body;
  }

  static Future<String?> resetPassword(Map<String, dynamic> data) async {
    final url = Uri.parse(ApiEndpoints.getFullUrl(ApiEndpoints.resetPassword));

    final encoding = Encoding.getByName('utf-8');

    Response response = await _httpClient.post(
      url,
      body: data,
      encoding: encoding,
    );

    return response.body;
  }

  static Future<String?> getOldPassword(
    Map<String, dynamic> data,
    String auth,
  ) async {
    final url = Uri.parse(ApiEndpoints.getFullUrl(ApiEndpoints.getOldPassword));
    final headers = {'Accept': 'application/json', 'Authorization': auth};
    Response response = await _httpClient.post(
      url,
      headers: headers,
      body: data,
    );
    return response.body;
  }

  static Future<String?> updateOldPassword(
    Map<String, dynamic> data,
    String auth,
  ) async {
    final url = Uri.parse(
      ApiEndpoints.getFullUrl(ApiEndpoints.updateOldPassword),
    );
    final headers = {'Accept': 'application/json', 'Authorization': auth};

    Response response = await _httpClient.post(
      url,
      headers: headers,
      body: data,
    );
    return response.body;
  }

  static Future<String?> registerComplaint(
    Map<String, dynamic> data,
    String auth,
  ) async {
    final url = Uri.parse(
      ApiEndpoints.getFullUrl(ApiEndpoints.registerComplaint),
    );
    final headers = {'Accept': 'application/json', 'Authorization': auth};

    Response response = await _httpClient.post(
      url,
      headers: headers,
      body: data,
    );
    return response.body;
  }
}
