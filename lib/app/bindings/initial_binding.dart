import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '/app/core/session_manager/session_manager.dart';
import '/app/global_controller/cart_controller.dart';

class InitialBinding implements Bindings {
  @override
  Future<void> dependencies() async {
    Get.put(CartController());
    await SessionManager().init();
    await initialize();
  }
}
