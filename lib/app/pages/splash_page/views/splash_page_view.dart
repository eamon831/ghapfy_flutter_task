import '/app/core/exporter.dart';
import '/app/pages/splash_page/controllers/splash_page_controller.dart';

// ignore: must_be_immutable
class SplashPageView extends BaseView<SplashPageController> {
  SplashPageView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return Container();
  }
}
