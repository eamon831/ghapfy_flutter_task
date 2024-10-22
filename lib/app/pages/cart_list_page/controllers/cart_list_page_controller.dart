import 'package:getx_template/app/entity/product_list.dart';
import 'package:getx_template/app/global_controller/cart_controller.dart';

import '/app/core/exporter.dart';

class CartListPageController extends BaseController {
  final cartController = Get.find<CartController>();
  final products = Rx<List<ProductList>?>(null);

  @override
  Future<void> onInit() async {
    super.onInit();
    await _initial();
  }

  Future<void> _initial() async {
    try {
      updatePageState(PageState.loading);
      await prepareCartList();
    } finally {
      if (products.value?.isEmpty ?? true) {
        updatePageState(PageState.emptyList);
      } else {
        updatePageState(PageState.success);
      }
    }
  }

  Future<void> prepareCartList() async {
    final productIds = await dbHelper.setOfColumns(
      tableCartProduct,
      'productId',
    );

    final ids = productIds.map((e) => e['productId']).toList();
    final placeholders = ids.map((_) => '?').join(', ');
    // Fetch all products at once using the IN clause
    final productsMaps = await dbHelper.getAllWhr(
      tbl: tableProducts,
      where: 'id IN ($placeholders)',
      whereArgs: ids,
    );

    products.value = productsMaps.map(ProductList.fromJson).toList();
    await cartController.getTotalCarts();
  }

  Future<void> clearCart() async {
    final confirm = await confirmationModal(msg: appLocalization.confirm);
    if(!confirm) return;
    await dbHelper.deleteAll(tbl: tableCartProduct);
    await dbHelper.deleteAll(tbl: tableCart);
    await _initial();
  }
}
