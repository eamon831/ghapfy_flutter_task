class CartProduct {
  final num? productId;
  final num? quantity;

  CartProduct({
    this.productId,
    this.quantity,
  });

  // Factory constructor to create a Product from a map (JSON-like structure)
  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }

  // Method to convert a Product to a map (JSON-like structure)
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }
}
