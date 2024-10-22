import '/app/core/exporter.dart';
import '/app/pages/cart_list_page/controllers/cart_list_page_controller.dart';

class CartListPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartListPageController>(
      CartListPageController.new,
      fenix: true,
    );
  }
}
