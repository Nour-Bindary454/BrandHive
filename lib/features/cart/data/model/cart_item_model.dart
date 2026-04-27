class CartItemModel {
  final String id;
  final String name;
  final String brand;
  final double price;
  final String image;
  int quantity;

  CartItemModel({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.image,
    required this.quantity,
  });

  /// Factory constructor to create a CartItemModel from JSON (future API usage)
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'] as String,
      name: json['name'] as String,
      brand: json['brand'] as String,
      price: (json['price'] as num).toDouble(),
      image: json['image'] as String,
      quantity: json['quantity'] as int,
    );
  }

  /// Converts a CartItemModel to JSON for API submission
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'price': price,
      'image': image,
      'quantity': quantity,
    };
  }
}
