class UserProfile {
  final String name;
  final String profileImageUrl;
  final String greeting;

  UserProfile({
    required this.name,
    required this.profileImageUrl,
    required this.greeting,
  });
}

class CategoryModel {
  final String id;
  final String name;
  final String imageUrl;

  CategoryModel({required this.id, required this.name, required this.imageUrl});
}

class EventModel {
  final String id;
  final String title;
  final String date;
  final String location;

  EventModel({
    required this.id,
    required this.title,
    required this.date,
    required this.location,
  });
}

class BannerModel {
  final String id;
  final String label;
  final String title;
  final String subtitle;
  final String imageUrl;

  BannerModel({
    required this.id,
    required this.label,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });
}

class HomeProduct {
  final String id;
  final String brandName;
  final String category;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final int matchPercentage;
  final double rating;

  HomeProduct({
    required this.id,
    required this.brandName,
    required this.category,
    required this.name,
    this.description = '',
    required this.imageUrl,
    required this.price,
    this.matchPercentage = 0,
    this.rating = 0.0,
  });

  factory HomeProduct.fromJson(Map<String, dynamic> json) {
    return HomeProduct(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      brandName: json['brand']?['name'] ?? '',
      category: json['category']?['name'] ?? '',
      imageUrl: json['mainImage'] ?? '',
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      rating: double.tryParse(json['stats']?['averageRating']?.toString() ?? '0') ?? 0.0,
    );
  }
}

class BrandModel {
  final String id;
  final String name;
  final String slug;
  final String description;
  final String country;
  final String logoUrl;
  final bool isActive;

  BrandModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.country,
    required this.logoUrl,
    required this.isActive,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['_id'],
      name: json['name'],
      slug: json['slug'],
      description: json['description'],
      country: json['country'],
      logoUrl: json['logo']['url'],
      isActive: json['isActive'],
    );
  }
}
