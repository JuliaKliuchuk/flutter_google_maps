import 'package:get/get.dart';

import '../pages/authorization/authorization_page.dart';
import '../pages/home/image_details_page.dart';
import '../pages/home/main_page.dart';
import '../pages/home/map_page.dart';

class RouteHelper {
  static const String authorization = '/authorization-page';
  static const String initial = '/';
  static const String mapPage = '/map-page';
  static const String imageDetail = '/image-detail-page';

  static String getAuthorizationPage() => authorization;
  static String getInitial() => initial;
  static String getMapPage() => mapPage;
  static String getImageDetailPage(int pageId) => '$imageDetail?pageId=$pageId';

  static List<GetPage> routes = [
    // initial
    GetPage(
      name: initial,
      page: () => const MainPage(),
      transition: Transition.fadeIn,
    ),

    // login/register
    GetPage(
      name: authorization,
      page: () => const AuthorizationPage(),
    ),

    // map page
    GetPage(
      name: mapPage,
      page: () => const MapPage(),
      transition: Transition.fadeIn,
    ),

    // image detail
    GetPage(
      name: imageDetail,
      page: () {
        var pageId = Get.parameters['pageId'];

        return ImageDetailsPage(
          pageId: int.parse(pageId!),
        );
      },
      transition: Transition.fadeIn,
    ),
  ];
}
