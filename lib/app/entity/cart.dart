class Cart {
  final num? productId;
  final num? quantity;
  final num? price;
  Cart({
    this.productId,
    this.quantity,
    this.price,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      productId: json['productId'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['quantity'] = quantity;
    data['price'] = price;
    return data;
  }
}
