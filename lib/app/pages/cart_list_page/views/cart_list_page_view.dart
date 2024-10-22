import '/app/core/exporter.dart';
import '/app/pages/cart_list_page/controllers/cart_list_page_controller.dart';

// ignore: must_be_immutable
class CartListPageView extends BaseView<CartListPageController> {
  CartListPageView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return CustomAppBar(
      appBarTitleText: appLocalization.cart,
      actions: [
        IconButton(
          icon: const Text('Clear Cart'),
          onPressed: controller.clearCart,
        ),
      ],
    );
  }

  @override
  Widget body(BuildContext context) {
    return ListView.builder(
      itemCount: controller.products.value?.length ?? 0,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final product = controller.products.value![index];
        return ListTile(
          title: Text(product.title ?? ''),
          subtitle: Text(product.price.toString()),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // controller.cartController.removeFromCart(product);
            },
          ),
        );
      },
    );
  }

  @override
  Widget bottomNavigationBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: spaceBetweenMAA,
        children: [
          Expanded(
            flex: 3,
            child: Obx(
              () => Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: endMAA,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  LabelValue(
                    label: 'Total Unique Items',
                    value: controller.cartController.totalCartItem.value
                        .toString(),
                    labelFlex: 2,
                    padding: EdgeInsets.zero,
                  ),
                  LabelValue(
                    label: 'Total Items',
                    value: controller.cartController.totalQuantity.value
                        .toString(),
                    labelFlex: 2,
                    padding: EdgeInsets.zero,
                  ),
                  LabelValue(
                    label: appLocalization.total,
                    value: controller.cartController.totalCartAmount.value
                        .toString(),
                    labelFlex: 2,
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
