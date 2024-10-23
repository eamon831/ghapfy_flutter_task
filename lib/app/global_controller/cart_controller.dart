import 'package:getx_template/app/entity/cart.dart';
import 'package:getx_template/app/entity/product_list.dart';
import 'package:getx_template/app/pages/home/modal/add_to_card_modal.dart';
import 'package:nb_utils/nb_utils.dart';

import '/app/core/exporter.dart';

class CartController extends BaseController {
  @override
  Future<void> onInit() async {
    super.onInit();
    await getTotalCarts();
  }

  final test = false.obs;
  final totalCartItem = 0.obs;
  final totalQuantity = 0.obs;
  final totalCartAmount = 0.0.obs;

  Future<void> getTotalCarts() async {
    try {
      final data = await dbHelper.getTotalCountANdSum();
      if (kDebugMode) {
        logger.i(data);
      }

      totalCartItem.value = int.tryParse(data[0]['totalItems'].toString()) ?? 0;
      totalQuantity.value =
          int.tryParse(data[0]['totalQuantity'].toString()) ?? 0;
      totalCartAmount.value =
          double.tryParse(data[0]['totalPrice'].toString()) ?? 0;
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
    }
  }

  Future<void> updateCartList() async {
    try {
      final apiCartList = await services.getCartList();
      if (apiCartList != null) {
        await clearCart(
          showConfirmation: false,
        );
        await Future.forEach<Cart>(
          apiCartList,
          (element) async {
            await dbHelper.addItemToCart(element);
          },
        );
        await getTotalCarts();
      }
    } catch (e) {
      // TODO
    }
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
      toast('Added to cart');
    }
  }

  Future<bool> clearCart({
    required bool showConfirmation,
  }) async {
    if (showConfirmation) {
      final confirm = await confirmationModal(msg: appLocalization.confirm);
      if (!confirm) return false;
    }
    await dbHelper.deleteAll(tbl: tableCart);
    await dbHelper.deleteAll(tbl: tableCartProduct);
    await getTotalCarts();
    return true;
  }

  Future<bool> removeCartItem(
    ProductList product, {
    required bool showConfirmation,
  }) async {
    if (showConfirmation) {
      final confirm = await confirmationModal(msg: appLocalization.confirm);
      if (!confirm) return false;
    }
    Cart? deletedCart;
    await dataFetcher(
      future: () async {
        deletedCart = await services.deleteItemFromCart(product.id!.toInt());
      },
    );
    if (deletedCart != null) {
      await dbHelper.deleteAllWhr(
        tableCartProduct,
        'productId == ?',
        [product.id],
      );
      await getTotalCarts();
      return true;
    }
    return false;
  }

  Future<void> createCart(ProductList productList, int quantity) async {
    try {
      if (quantity == 0) {
        toast('At least one quantity is required');
        return;
      }
      final date = DateFormat('yyyy-MM-dd').format(
        DateTime.now(),
      );

      final cart = Cart(
        id: 0,
        userId: LoggedUser().id!.toInt(),
        date: date,
        products: [
          CartProduct(
            productId: productList.id,
            quantity: quantity,
          ),
        ],
      );
      try {
        Cart? data;
        await dataFetcher(
          future: () async {
            data = await services.addItemToCart(cart);
          },
        );
        if (data != null) {
          await dbHelper.addItemToCart(data!);
        } else {
          await dbHelper.addItemToCart(cart);
          toast('Saved Locally');
        }
        await getTotalCarts();
        if (data != null) {
          Get.back(
            result: {},
          );
        }
      } catch (e) {}
    } catch (e) {
      toast('Failed to add to cart');
    }
  }
}
