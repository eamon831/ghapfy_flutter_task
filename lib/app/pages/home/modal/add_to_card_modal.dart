import 'package:getx_template/app/core/exporter.dart';
import 'package:getx_template/app/entity/cart.dart';
import 'package:getx_template/app/entity/product_list.dart';
import 'package:nb_utils/nb_utils.dart';

class AddToCardModal extends StatefulWidget {
  final ProductList productList;
  const AddToCardModal({
    required this.productList,
    super.key,
  });

  @override
  State<AddToCardModal> createState() => _AddToCardModalState();
}

class _AddToCardModalState extends State<AddToCardModal> {
  final quantity = 0.obs;
  final dbHelper = DbHelper.instance;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () async {
        await _setPreQuantity();
      },
    );
  }

  Future<void> _setPreQuantity() async {
    final cart = await dbHelper.find(
      tableCart,
      'productId == ?',
      [widget.productList.id],
    );
    if (cart.isNotEmpty) {
      quantity.value = cart[0]['quantity'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          const Text(
            'Note : You need to press the add to cart if you are updating the quantity or adding a new product',
          ),
          Center(
            child: Row(
              //mainAxisAlignment: spaceBetweenMAA,
              children: [
                Row(
                  children: [
                    IconButton.outlined(
                      onPressed: () {
                        if (quantity.value > 1) {
                          quantity.value--;
                        } else {
                          toast('At least one quantity is required');
                        }
                      },
                      icon: const Icon(
                        TablerIcons.minus,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 8, right: 8),
                      child: Obx(
                        () => Text(
                          quantity.value.toString(),
                        ),
                      ),
                    ),
                    IconButton.outlined(
                      onPressed: () {
                        quantity.value++;
                      },
                      icon: const Icon(
                        TablerIcons.plus,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      if (quantity.value == 0) {
                        toast('At least one quantity is required');
                        return;
                      }
                      final cart = Cart(
                        productId: widget.productList.id,
                        quantity: quantity.value,
                        price: widget.productList.price,
                      );
                      await dbHelper.addItemToCart(cart);
                      Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                      ),
                      child: Center(
                        child: Text(
                          appLocalization.addToCart,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
