import 'cart_product.dart';

class Cart {
  final int id;
  final int userId;
  final String date;
  final List<CartProduct> products;

  Cart({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    final productsFromJson = json['products'] as List;
    final productList = productsFromJson.map(
      (item) {
        return CartProduct.fromJson(item);
      },
    ).toList();

    return Cart(
      id: json['id'],
      userId: json['userId'],
      date: json['date'],
      products: productList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'date': date,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}

class CartProduct {
  final num? productId;
  final num? quantity;

  CartProduct({
    this.productId,
    this.quantity,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }
}
