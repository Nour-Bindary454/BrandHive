class NewArrivalModel {
  final String id;
  final String name;
  final double price;
  final double finalPrice;
  final String image;
  final bool isOutOfStock;
  final String brandName;
  final String description;
  final double rating;

  NewArrivalModel({
    required this.id,
    required this.name,
    required this.price,
    required this.finalPrice,
    required this.image,
    required this.isOutOfStock,
    this.brandName = '',
    this.description = '',
    this.rating = 0.0,
  });

  factory NewArrivalModel.fromJson(Map<String, dynamic> json) {
    return NewArrivalModel(
      id: json['id'] ?? json['_id'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      finalPrice: (json['finalPrice'] as num?)?.toDouble() ?? 0.0,
      image: json['mainImage'] ?? '',
      isOutOfStock: json['isOutOfStock'] ?? false,
      brandName: json['brand']?['name'] ?? '',
      description: json['description'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
