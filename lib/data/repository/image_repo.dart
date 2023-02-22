import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_constants.dart';
import '../api_client.dart';

class ImageRepo extends GetxService {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  ImageRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<Response> getImageList() async {
    return await apiClient.getData(
      '${AppConstans.IMAGE_URL}?page=1',
    );
  }

  Future<bool> saveImageList(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstans.TOKEN, token);
  }
}
