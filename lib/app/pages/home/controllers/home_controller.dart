import 'package:getx_template/app/entity/product_list.dart';

import '/app/core/exporter.dart';

class HomeController extends BaseController {
  final pagingController = Rx<PagingController<int, ProductList>>(
    PagingController<int, ProductList>(
      firstPageKey: 1,
    ),
  );

  @override
  Future<void> onInit() async {
    super.onInit();
    pagingController.value.addPageRequestListener(
      (pageKey) {
        fetchProductList(
          pageKey: pageKey,
        );
      },
    );
    await _initializePagingController();
  }

  Future<void> _initializePagingController() async {
    try {
      updatePageState(PageState.loading);
      await fetchProductList(
        pageKey: 1,
      );
    } finally {
      if (pagingController.value.itemList == null) {
        updatePageState(PageState.failed);
      } else if (pagingController.value.itemList!.isEmpty) {
        updatePageState(PageState.emptyList);
      } else {
        updatePageState(PageState.success);
      }
    }
  }

  Future<void> fetchProductList({
    required int pageKey,
  }) async {
    final apiDataList = await services.getProducts();

    if (apiDataList == null) {
      pagingController.value.error = true;
      return;
    }

    if ((apiDataList.length) < pageLimit) {
      pagingController.value.appendLastPage(apiDataList);
    } else {
      pagingController.value.appendPage(
        apiDataList,
        pageKey + 1,
      );
    }

    update();
    refresh();
    notifyChildrens();
  }

  void goToLocalDbPage() {}

  @override
  Future<void> refreshData() async {
    pagingController.value.refresh();
    await _initializePagingController();
  }

  void goToLoginPage() {
    Get.toNamed(Routes.login);
  }

  addToCart(ProductList element) {
    // Add to cart
  }
}
