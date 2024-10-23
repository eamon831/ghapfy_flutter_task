import 'package:get/get.dart';
import '/app/pages/cart_list_page/bindings/cart_list_page_binding.dart';
import '/app/pages/cart_list_page/views/cart_list_page_view.dart';

import '/app/pages/home/bindings/home_binding.dart';
import '/app/pages/home/views/home_view.dart';
import '/app/pages/login_page/bindings/login_page_binding.dart';
import '/app/pages/login_page/views/login_page_view.dart';
import '/app/pages/splash_page/bindings/splash_page_binding.dart';
import '/app/pages/splash_page/views/splash_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splashPage;

  static final routes = [
    GetPage(
      name: _Paths.login,
      page: LoginPageView.new,
      binding: LoginPageBinding(),
    ),
    GetPage(
      name: _Paths.home,
      page: HomeView.new,
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.splashPage,
      page: SplashPageView.new,
      binding: SplashPageBinding(),
    ),
    GetPage(
      name: _Paths.cartListPage,
      page: CartListPageView.new,
      binding: CartListPageBinding(),
    ),
  ];
}
