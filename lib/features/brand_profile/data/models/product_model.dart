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
    final rawImage = json['image'] ?? json['mainImage'] ?? json['imageUrl'] ?? '';
    String parsedImage = '';
    if (rawImage is String) {
      parsedImage = rawImage;
    } else if (rawImage is Map) {
      parsedImage = rawImage['url']?.toString() ?? '';
    }

    final rawPrice = json['price'] ?? json['finalPrice'] ?? 0;
    final parsedPrice = (rawPrice is num) ? rawPrice.toDouble() : (double.tryParse(rawPrice.toString()) ?? 0.0);

    final rawRating = json['rating'] ?? json['ratingsAverage'] ?? json['stats_averageRating'] ?? 0.0;
    final parsedRating = (rawRating is num) ? rawRating.toDouble() : (double.tryParse(rawRating.toString()) ?? 0.0);

    return Product(
      id: json['id'] ?? json['_id'] ?? '',
      brandId: json['brandId'] ?? json['brand']?.toString() ?? '',
      brandName: json['brandName'] ?? json['brand_name'] ?? '',
      name: json['name'] ?? json['title'] ?? '',
      description: json['description'] ?? '',
      image: parsedImage.isNotEmpty ? parsedImage : 'https://placehold.co/300x300/png',
      rating: parsedRating,
      price: parsedPrice,
      currency: json['currency'] ?? 'EGP',
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
