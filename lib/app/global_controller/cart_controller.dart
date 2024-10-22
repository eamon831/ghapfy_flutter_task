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
}
