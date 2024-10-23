import '/app/core/exporter.dart';
import '/app/pages/login_page/controllers/login_page_controller.dart';

class LoginPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginPageController>(
      LoginPageController.new,
      fenix: true,
    );
  }
}
