import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/auth_controller.dart';
import '../controllers/comment_controller.dart';
import '../controllers/images_controller.dart';
import '../controllers/map_controller.dart';
import '../data/api_client.dart';
import '../data/repository/auth_repo.dart';
import '../data/repository/comment_repo.dart';
import '../data/repository/image_repo.dart';
import '../data/repository/map_repo.dart';
import '../database/database.dart';
import '../utils/app_constants.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final db = Database();

  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => db);

  // api client
  Get.lazyPut(
    () => ApiClient(
      appBaseUrl: AppConstans.BASE_URL,
      sharedPreferences: Get.find(),
    ),
  );

  // repository
  Get.lazyPut(
    () => AuthRepo(
      apiClient: Get.find(),
      sharedPreferences: Get.find(),
    ),
  );
  Get.lazyPut(() => ImageRepo(
        apiClient: Get.find(),
        sharedPreferences: Get.find(),
      ));
  Get.lazyPut(() => CommentRepo(
        apiClient: Get.find(),
      ));
  Get.lazyPut(() => MapRepo(
        apiClient: Get.find(),
      ));

  // controllers
  Get.lazyPut(() => AuthController(
        authRepo: Get.find(),
      ));

  Get.lazyPut(() => ImageController(
        db: Get.find(),
        imageRepo: Get.find(),
      ));

  Get.lazyPut(
      () => CommentController(
            db: Get.find(),
            commentRepo: Get.find(),
          ),
      fenix: true);

  Get.lazyPut(
      () => MapController(
            mapRepo: Get.find(),
          ),
      fenix: true);
}
