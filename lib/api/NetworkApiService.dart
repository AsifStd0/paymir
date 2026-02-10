import 'dart:convert';

import 'package:http/http.dart';
import '../api/BaseApiService.dart';

import 'AppException.dart';

class NetworkApiService extends BaseApiService{
  @override
  Future postApiResponse(String url, data) async {

    final response = await post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
      body: data,
    );

    print('networkapi called');

   return returnResponse(response);
  }
}

dynamic returnResponse(Response response){
  switch(response.statusCode){
    case 200:
      dynamic resp = jsonDecode(response.body);
      return resp;
    case 404:
      throw UnauthorisedException(response.body);
    case 400:
      throw BadRequestException(response.body);
    default:
      throw FetchDataException(response.statusCode.toString());

  }

}

