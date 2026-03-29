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

  CategoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
  });
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

class HomeBrand {
  final String id;
  final String name;
  final String category;
  final String coverImageUrl;
  final String logoText;

  HomeBrand({
    required this.id,
    required this.name,
    required this.category,
    required this.coverImageUrl,
    required this.logoText,
  });
}

class HomeProduct {
  final String id;
  final String brandName;
  final String category;
  final String name;
  final String imageUrl;
  final double price;
  final int matchPercentage;
  final double rating;

  HomeProduct({
    required this.id,
    required this.brandName,
    required this.category,
    required this.name,
    required this.imageUrl,
    required this.price,
    this.matchPercentage = 0,
    this.rating = 0.0,
  });
}
