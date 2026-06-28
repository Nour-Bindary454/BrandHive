class CartItemModel {
  final String productId;
  final String name;
  final String brand;
  final double price;
  final String image;
  int quantity;

  CartItemModel({
    required this.productId,
    required this.name,
    required this.brand,
    required this.price,
    required this.image,
    required this.quantity,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    final product = json['product'] ?? {};

    final String parsedProductId =
        product['id'] ?? product['_id'] ?? json['productId'] ?? '';

    String parsedName = '';
    String parsedBrand = '';
    String parsedImage = '';

    if (product is Map) {
      parsedName = product['name'] ?? '';
      parsedImage = product['image'] ?? product['mainImage'] ?? '';

      if (product['brand'] is Map) {
        parsedBrand = product['brand']['name'] ?? '';
      } else if (product['brand'] is String) {
        parsedBrand = product['brand'];
      }
    }

    double parsedPrice =
        (json['effectivePrice'] as num?)?.toDouble() ??
        (json['currentPrice'] as num?)?.toDouble() ??
        (json['lockedPrice'] as num?)?.toDouble() ??
        0.0;

    return CartItemModel(
      productId: parsedProductId,
      name: parsedName,
      brand: parsedBrand,
      price: parsedPrice,
      image: parsedImage,
      quantity: json['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {'productId': productId, 'quantity': quantity};
  }
}
