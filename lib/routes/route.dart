import 'package:get/get.dart';

import '../pages/authorization/authorization_page.dart';
import '../pages/home/main_page.dart';

class RouteHelper {
  static const String authorization = '/authorization-page';
  static const String initial = '/';
  static const String popularFood = '/popular-food';
  static const String recommendedFood = '/recommended-food';
  static const String cartPage = '/cart-page';
  static const String signIn = '/sign-in';
  static const String addAddress = '/add-address';

  static String getAuthorizationPage() => authorization;
  static String getInitial() => initial;

  // static String getPopularFood(int pageId, String? page) =>
  //     '$popularFood?pageId=$pageId&page=$page';

  static List<GetPage> routes = [
    // initial
    GetPage(
      name: initial,
      page: () => const MainPage(),
    ),

    // splashScreen
    GetPage(
      name: authorization,
      page: () => const AuthorizationPage(),
    ),

    //popularFood
    // GetPage(
    //   name: popularFood,
    //   page: () {
    //     var pageId = Get.parameters['pageId'];
    //     var page = Get.parameters['page'];
    //     return PopularFoodDetail(
    //       pageId: int.parse(pageId!),
    //       page: page!,
    //     );
    //   },
    //   transition: Transition.fadeIn,
    // ),
  ];
}
