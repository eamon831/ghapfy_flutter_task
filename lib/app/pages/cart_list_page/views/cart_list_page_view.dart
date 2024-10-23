import 'package:nb_utils/nb_utils.dart';

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
        SelectiveButton(
          onPressed:  controller.clearCart,
          text: 'Clear Cart',
          textColor: Colors.white,
          isSelected: true,
          margin: 5,
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

        return Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Center(
                child: commonCachedNetworkImage(
                  product.image,
                  //width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                ' ${product.title ?? ''}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),
              8.height,
              Row(
                children: [
                  Expanded(
                    child: LabelValue(
                      label: appLocalization.price,
                      value: product.price.toString(),
                      labelFlex: 2,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  Expanded(
                    child: LabelValue(
                      label: appLocalization.quantity,
                      value: controller.quantity[product.id].toString(),
                      labelFlex: 2,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
              8.height,
              SelectiveButton(
                onPressed: () => controller.removeCartItem(product),
                //  width: 60,
                text: 'Remove',
                icon: Icons.delete,
                iconColor: Colors.red,
                textColor: Colors.red,
              ),
            ],
          ),
        );

        return ListTile(
          title: Text(product.title ?? ''),
          subtitle: Text(product.price.toString()),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => controller.removeCartItem(product),
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
