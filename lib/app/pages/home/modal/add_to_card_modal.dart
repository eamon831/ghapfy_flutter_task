import 'package:getx_template/app/core/exporter.dart';
import 'package:getx_template/app/entity/product_list.dart';

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
    // TODO: implement initState
    super.initState();
    Future.delayed(
      Duration.zero,
      () async {
        await _setPreQuantity();
      },
    );
  }

  Future<void> _setPreQuantity() async {}

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        //mainAxisAlignment: spaceBetweenMAA,
        children: [
          Row(
            children: [
              IconButton.outlined(
                onPressed: () {
                  if (quantity.value > 0) {
                    quantity.value--;
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
              onTap: (){

              },
              child: Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
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
    );
  }
}
