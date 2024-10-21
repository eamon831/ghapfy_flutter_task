import '/app/core/exporter.dart';

class SplashPageController extends BaseController {
  @override
  Future<void> onInit() async {
    super.onInit();
    await navigatePage();
  }

  Future<void> navigatePage() async {
    await 2.delay();
    Get.offNamed(Routes.home);
  }
}
