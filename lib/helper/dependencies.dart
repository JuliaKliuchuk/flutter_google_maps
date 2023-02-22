import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/auth_controller.dart';
import '../controllers/images_controller.dart';
import '../data/api_client.dart';
import '../data/repository/auth_repo.dart';
import '../data/repository/image_repo.dart';
import '../utils/app_constants.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);

  // api client
  Get.lazyPut(
    () => ApiClient(
      appBaseUrl: AppConstans.BASE_URL,
      sharedPreferences: Get.find(),
    ),
  );
  Get.lazyPut(
    () => AuthRepo(
      apiClient: Get.find(),
      sharedPreferences: Get.find(),
    ),
  );

  // repository
  Get.lazyPut(() => ImageRepo(
        apiClient: Get.find(),
        sharedPreferences: Get.find(),
      ));

  // controllers
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => ImageController(
        imageRepo: Get.find(),
      ));
}
