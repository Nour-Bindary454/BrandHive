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
  final String slug;
  final String? logoUrl;

  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    this.logoUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'],
      name: json['name'],
      slug: json['slug'],
      logoUrl: json['logo'] != null ? json['logo']['url'] : null,
    );
  }
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
  final bool? isActive;

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
    this.isActive = true,
  });

  factory HomeProduct.fromJson(Map<String, dynamic> json) {
    return HomeProduct(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      brandName: json['brand'] is Map ? (json['brand']['name'] ?? '') : '',
      category: json['category'] is Map ? (json['category']['name'] ?? '') : '',
      imageUrl: json['mainImage'] ?? '',
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      rating:
          double.tryParse(json['stats']?['averageRating']?.toString() ?? '0') ??
          0.0,
      isActive: json['isActive'] ?? true,
    );
  }

  HomeProduct copyWith({
    String? id,
    String? brandName,
    String? category,
    String? name,
    String? description,
    String? imageUrl,
    double? price,
    int? matchPercentage,
    double? rating,
    bool? isActive,
  }) {
    return HomeProduct(
      id: id ?? this.id,
      brandName: brandName ?? this.brandName,
      category: category ?? this.category,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      matchPercentage: matchPercentage ?? this.matchPercentage,
      rating: rating ?? this.rating,
      isActive: isActive ?? this.isActive,
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
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      description: json['description'] ?? '',
      country: json['country'] ?? '',
      logoUrl: (json['logo'] != null && json['logo'] is Map && json['logo']['url'] != null)
          ? json['logo']['url']
          : '',
      isActive: json['isActive'] ?? false,
    );
  }

  BrandModel copyWith({
    String? id,
    String? name,
    String? slug,
    String? description,
    String? country,
    String? logoUrl,
    bool? isActive,
  }) {
    return BrandModel(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      description: description ?? this.description,
      country: country ?? this.country,
      logoUrl: logoUrl ?? this.logoUrl,
      isActive: isActive ?? this.isActive,
    );
  }
}
