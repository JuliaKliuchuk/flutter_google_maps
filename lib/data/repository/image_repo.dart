import 'package:flutter_google_maps/models/image_model.dart';
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
      '${AppConstans.IMAGE_URL}?page=0',
    );
  }

  Future<Response> postImage(ImageModel imageModel) async {
    return await apiClient.postData(
      AppConstans.POST_IMAGE_URL,
      imageModel.toJson(),
    );
  }
}
