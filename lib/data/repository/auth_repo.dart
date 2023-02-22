import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/auth_model.dart';
import '../../utils/app_constants.dart';
import '../api_client.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<Response> registration(AuthModel data) async {
    return await apiClient.postData(
      AppConstans.REGISTRATION_URL,
      data.toJson(),
    );
  }

  Future<Response> login(String login, String password) async {
    return await apiClient.postData(
      AppConstans.LOGIN_URL,
      {'login': login, 'password': password},
    );
  }

  Future<String> getUserToken() async {
    return sharedPreferences.getString(AppConstans.TOKEN) ?? 'None';
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstans.TOKEN, token);
  }
}
