class Brand {
  final String id;
  final String name;
  final String logo;
  final String coverImage;
  final double rating;
  final int reviewCount;
  final String description;
  final String location;
  final String memberSince;
  final bool isFollowed;

  Brand({
    required this.id,
    required this.name,
    required this.logo,
    required this.coverImage,
    required this.rating,
    required this.reviewCount,
    required this.description,
    required this.location,
    required this.memberSince,
    this.isFollowed = false,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
      coverImage: json['coverImage'],
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'],
      description: json['description'],
      location: json['location'],
      memberSince: json['memberSince'],
      isFollowed: json['isFollowed'] ?? false,
    );
  }

  Brand copyWith({bool? isFollowed}) {
    return Brand(
      id: id,
      name: name,
      logo: logo,
      coverImage: coverImage,
      rating: rating,
      reviewCount: reviewCount,
      description: description,
      location: location,
      memberSince: memberSince,
      isFollowed: isFollowed ?? this.isFollowed,
    );
  }
}
