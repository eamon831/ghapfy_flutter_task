import 'package:getx_template/app/entity/product_list.dart';
import 'package:nb_utils/nb_utils.dart';

import '/app/core/exporter.dart';
import '/app/pages/home/controllers/home_controller.dart';

class HomeView extends BaseView<HomeController> {
  HomeView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return CustomAppBar(
      appBarTitleText: 'Home',
      actions: [
        // login button
        if (controller.loggedUser.id == null)
          SelectiveButton(
            onPressed: controller.goToLoginPage,
            text: 'Log in',
          ),
        // logout button
        if (controller.loggedUser.id != null)
          SelectiveButton(
            onPressed: controller.logout,
            text: 'Log Out',
          ),
        5.width,
        SelectiveButton(
          onPressed: () => controller.cartController.clearCart(
            showConfirmation: true,
          ),
          text: 'Clear Cart',
        ),
        5.width,
        SelectiveButton(
          onPressed: () => controller.clearProduct(
            showConfirmation: true,
          ),
          text: 'Clear Product',
          isSelected: true,
        ),
      ],
    );
  }

  @override
  Widget body(BuildContext context) {
    return PagedListView<int, ProductList>(
      pagingController: controller.pagingController.value,
      shrinkWrap: true,
      padding: const EdgeInsets.only(
        bottom: 60,
      ),
      builderDelegate: PagedChildBuilderDelegate<ProductList>(
        itemBuilder: (context, item, index) {
          return _buildCardView(
            element: item,
            index: index,
            context: context,
          );
        },
        newPageErrorIndicatorBuilder: (context) {
          return ListRetryView(
            onRetry: controller.pagingController.value.retryLastFailedRequest,
          );
        },
      ),
    );
  }

  Widget _buildCardView({
    required ProductList element,
    required int index,
    required BuildContext context,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          AppValues.containerBorderRadius,
        ),
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
        crossAxisAlignment: startCAA,
        children: [
          Center(
            child: commonCachedNetworkImage(
              element.image,
              //width: 100,
              fit: BoxFit.cover,
            ),
          ),
          8.height,
          Row(
            children: [
              Text(
                '${index + 1}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              10.width,
              Expanded(
                child: Text(
                  ' ${element.title ?? ''}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
              ),
            ],
          ),
          8.height,
          Text(
          'Price ${element.price}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          8.height,
          Row(
            mainAxisAlignment: spaceBetweenMAA,
            children: [
              // add to cart button
              SelectiveButton(
                onPressed: () => controller.cartController.addToCart(element),
                color: Colors.green,
                text: appLocalization.addToCart,
                //isSelected: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget bottomNavigationBar() {
    return InkWell(
      onTap: controller.goToCartPage,
      child: Container(
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
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(
                    AppValues.containerBorderRadius,
                  ),
                ),
                child: const Text(
                  'Go to Cart',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
