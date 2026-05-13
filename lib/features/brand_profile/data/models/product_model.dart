class Product {
  final String id;
  final String brandId;
  final String brandName;
  final String name;
  final String description;
  final String image;
  final double rating;
  final double price;
  final String currency;
  final bool isFavorite;
  final bool? isActive;

  Product({
    required this.id,
    required this.brandId,
    required this.brandName,
    required this.name,
    this.description = '',
    required this.image,
    required this.rating,
    required this.price,
    required this.currency,
    this.isFavorite = false,
    this.isActive = true,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      brandId: json['brandId'],
      brandName: json['brandName'] ?? '',
      name: json['name'],
      description: json['description'] ?? '',
      image: json['image'],
      rating: (json['rating'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      currency: json['currency'],
      isFavorite: json['isFavorite'] ?? false,
      isActive: json['isActive'] ?? true,
    );
  }

  Product copyWith({bool? isFavorite, bool? isActive}) {
    return Product(
      id: id,
      brandId: brandId,
      brandName: brandName,
      name: name,
      description: description,
      image: image,
      rating: rating,
      price: price,
      currency: currency,
      isFavorite: isFavorite ?? this.isFavorite,
      isActive: isActive ?? this.isActive,
    );
  }
}
