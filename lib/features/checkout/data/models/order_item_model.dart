class OrderItemModel {
  final String id;
  final String name;
  final double price;
  final int quantity;
  final String image;

  OrderItemModel({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
      'image': image,
    };
  }
}
