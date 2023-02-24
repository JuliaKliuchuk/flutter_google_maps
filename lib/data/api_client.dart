import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_constants.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late SharedPreferences sharedPreferences;

  late Map<String, String> _mainHeaders;

  ApiClient({
    required this.appBaseUrl,
    required this.sharedPreferences,
  }) {
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    token = sharedPreferences.getString(AppConstans.TOKEN) ?? '';
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
      'Access-Token': token,
      'accept': 'application/json;charset=UTF-8'
    };
  }

  void updateHeader(String token) {
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'accept': 'application/json;charset=UTF-8',
      'Authorization': 'Bearer $token',
      'Access-Token': token,
    };
  }

  Future<Response> getData(
    String url, {
    Map<String, String>? headers,
  }) async {
    try {
      Response response = await get(url, headers: headers ?? _mainHeaders);

      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String url, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      Response response = await post(url, body, headers: _mainHeaders);

      log('response body---${response.body}');

      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> deleteData(String url,
      {Map<String, String>? headers}) async {
    try {
      Response response = await delete(url, headers: _mainHeaders);

      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
