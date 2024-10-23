import 'package:getx_template/app/entity/cart.dart';
import 'package:getx_template/app/entity/product_list.dart';
import 'package:getx_template/app/global_controller/cart_controller.dart';
import 'package:getx_template/app/pages/home/modal/add_to_card_modal.dart';
import 'package:nb_utils/nb_utils.dart';

import '/app/core/exporter.dart';

class HomeController extends BaseController {
  final pagingController = Rx<PagingController<int, ProductList>>(
    PagingController<int, ProductList>(
      firstPageKey: 0,
    ),
  );
  final cartController = Get.find<CartController>();
  final List<int> cartList = [];

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
      // As the api does not have pagination(it has limits but no page number)
      // so my plan is to fetch all the data at once and cache it in the local
      // database,then use the local database to paginate the data.each time 10
      // items will be fetched from the local database.

      try {
        // first fetch the cart list
        if (loggedUser.id != null) {
          final apiCartList = await services.getCartList();
          if (apiCartList != null) {
            await dbHelper.deleteAll(tbl: tableCart);
            await dbHelper.deleteAll(tbl: tableCartProduct);

            await Future.forEach<Cart>(
              apiCartList,
              (element) async {
                await dbHelper.addItemToCart(element);
              },
            );
            await cartController.getTotalCarts();
          }
        }

        final apiDataList = await services.getProducts();
        await dbHelper.insertList(
          deleteBeforeInsert: true,
          tableName: tableProducts,
          dataList: apiDataList?.map((e) => e.toJson()).toList() ?? [],
        );
      } catch (e) {
        // TODO
      }
      await fetchProductList(
        pageKey: 0,
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
    final localList = await dbHelper.getAll(
      tbl: tableProducts,
      limit: pageLimit,
      offset: pagingController.value.itemList?.length ?? 0,
    );
    final apiDataList = localList.map((e) => ProductList.fromJson(e)).toList();

    if ((apiDataList.length) < pageLimit) {
      pagingController.value.appendLastPage(apiDataList);
    } else {
      pagingController.value.appendPage(
        apiDataList,
        pageKey + 1,
      );
    }
  }

  @override
  Future<void> refreshData() async {
    pagingController.value.refresh();
    await _initializePagingController();
  }

  void goToLoginPage() {
    Get.toNamed(Routes.login);
  }

  Future<void> addToCart(ProductList element) async {
    if (loggedUser.id == null) {
      toast('Please login to add to cart');
      return;
    }
    // Add to cart
    final isCartAdded = await Get.dialog(
      DialogPattern(
        title: appLocalization.addToCart,
        subTitle: '',
        child: AddToCardModal(
          productList: element,
        ),
      ),
    );
    if (isCartAdded != null) {
      await dataFetcher(
        future: () async {},
      );
    }
  }

  void goToCartPage() {
    if (loggedUser.id == null) {
      toast('Please login to view cart');
      return;
    }
    Get.toNamed(Routes.cartListPage);
  }

  Future<void> logout() async {
    await dbHelper.deleteAll(tbl: tableCart);
    await dbHelper.deleteAll(tbl: tableCartProduct);
    await prefs.clear();
    Get.offAllNamed(Routes.splashPage);
  }

  Future<void> clearCart() async {
    await dbHelper.deleteAll(tbl: tableCart);
    await dbHelper.deleteAll(tbl: tableCartProduct);
    await cartController.getTotalCarts();
  }
}
