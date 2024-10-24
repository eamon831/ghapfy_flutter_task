import 'package:getx_template/app/pages/home/controllers/home_controller.dart';

import '/app/core/exporter.dart';

class SplashPageController extends BaseController {
  @override
  Future<void> onInit() async {
    super.onInit();
    await navigatePage();
  }

  Future<void> navigatePage() async {
    final isLogin = await prefs.getBool(prefIsLogin);
    if (isLogin) {
      final userData = await prefs.getString(prefUser);
      if (userData != null) {
        LoggedUser.fromJson(jsonDecode(userData));
        if (kDebugMode) {
          //print('Logged User: ${LoggedUser().toJson()}');
        }
      }
    } else {
      LoggedUser.fromJson({});
    }

    Get.offAllNamed(Routes.home);
  }
}
