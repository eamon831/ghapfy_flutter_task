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
    final isClear = await cartController.clearCart(
      showConfirmation: true,
    );
    if (isClear) {
      await _initial();
    }
  }

  Future<void> removeCartItem(ProductList product) async {
    final isDeleted = await cartController.removeCartItem(
      product,
      showConfirmation: true,
    );
    if (isDeleted) {
      await _initial();
    }
  }
}
