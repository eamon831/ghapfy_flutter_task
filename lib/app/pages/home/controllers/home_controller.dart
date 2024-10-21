import '/app/core/exporter.dart';

class HomeController extends BaseController {
  @override
  Future<void> onInit() async {
    super.onInit();
    updatePageState(PageState.loading);
    await 5.delay();
    updatePageState(PageState.success);
  }

  void goToLocalDbPage() {
    Get.toNamed(
      Routes.localDbData,
    );
  }

  @override
  Future<void> refreshData() async {
    super.refreshData();
    updatePageState(PageState.loading);
    await 5.delay();
    updatePageState(PageState.success);
  }
}
