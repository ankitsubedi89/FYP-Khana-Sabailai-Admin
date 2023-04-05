import 'package:get/get.dart';
import 'package:khana_sabailai_admin/routes.dart';
import 'package:khana_sabailai_admin/utils/shared_prefs.dart';

class SplashContoller extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.delayed(const Duration(seconds: 1), checkUserLogin);
  }

  checkUserLogin() async {
    var usr = await SharedPrefs().getUser();
    if (usr != null) {
      Get.offAllNamed(GetRoutes.bottomTab);
    } else {
      Get.offAllNamed(GetRoutes.login);
    }
  }
}
