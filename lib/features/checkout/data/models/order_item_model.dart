class OrderItemModel {
  final String product;
  final String productName;
  final String productImage;
  final String? sku;
  final int quantity;
  final double unitPrice;
  final double? unitDiscountPrice;
  final double itemTotal;

  OrderItemModel({
    required this.product,
    required this.productName,
    required this.productImage,
    this.sku,
    required this.quantity,
    required this.unitPrice,
    this.unitDiscountPrice,
    required this.itemTotal,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      product: json['product'] ?? '',
      productName: json['productName'] ?? '',
      productImage: json['productImage'] ?? '',
      sku: json['sku'],
      quantity: json['quantity'] ?? 0,
      unitPrice: (json['unitPrice'] ?? 0).toDouble(),
      unitDiscountPrice: json['unitDiscountPrice']?.toDouble(),
      itemTotal: (json['itemTotal'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product,
      'productName': productName,
      'productImage': productImage,
      'sku': sku,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'unitDiscountPrice': unitDiscountPrice,
      'itemTotal': itemTotal,
    };
  }
}
