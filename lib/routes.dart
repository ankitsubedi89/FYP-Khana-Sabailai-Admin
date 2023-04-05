import 'package:get/get.dart';
import 'package:khana_sabailai_admin/screens/auth/login_screen.dart';
import 'package:khana_sabailai_admin/screens/food/category_screen.dart';
import 'package:khana_sabailai_admin/screens/food/single_food_screen.dart';
import 'package:khana_sabailai_admin/screens/home/bottom_tab.dart';
import 'package:khana_sabailai_admin/screens/home/report_screen.dart';
import 'package:khana_sabailai_admin/screens/restaurant/single_restaurant.dart';
import 'package:khana_sabailai_admin/splash.dart';

class GetRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String bottomTab = '/bottomTab';
  static const String categoryScreen = '/categoryScreen';
  static const String singleFood = '/singleFood';
  static const String reportScreen = '/report-screen';
  static const String singleRestaurant = '/single-restaurant';

  static List<GetPage> routes = [
    GetPage(
      name: GetRoutes.splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: GetRoutes.login,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: GetRoutes.bottomTab,
      page: () => BottomTab(),
    ),
    GetPage(
      name: GetRoutes.singleRestaurant,
      page: () => SingleRestaurant(),
    ),
    GetPage(
      name: GetRoutes.categoryScreen,
      page: () => CategoryScreen(),
    ),
    GetPage(
      name: GetRoutes.singleFood,
      page: () => SingleFoodScreen(),
    ),
    // GetPage(
    //   name: GetRoutes.reportScreen,
    //   page: () => const ReportScreen(),
    // ),
  ];
}
