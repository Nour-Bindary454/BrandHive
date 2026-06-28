class ReviewModel {
  final String id;
  final String userName;
  final String? userImage;
  final double rating;
  final String comment;
  final DateTime date;

  const ReviewModel({
    required this.id,
    required this.userName,
    this.userImage,
    required this.rating,
    required this.comment,
    required this.date,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    String userNameStr = 'Unknown User';
    String? userImageStr;
    final user = json['user'];
    if (user is Map) {
      userNameStr = user['name'] ?? user['userName'] ?? 'Unknown User';
      userImageStr = user['image'] ?? user['avatar'] ?? user['userImage'];
    } else if (user is String) {
      userNameStr = user;
    } else {
      userNameStr = json['userName'] ?? 'Unknown User';
      userImageStr = json['userImage'];
    }

    return ReviewModel(
      id: (json['_id'] ?? json['id'] ?? '').toString(),
      userName: userNameStr,
      userImage: userImageStr,
      rating: (json['rating'] ?? 5.0 as num).toDouble(),
      comment: json['comment'] ?? '',
      date: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt']) ?? DateTime.now()
          : (json['date'] != null
              ? DateTime.tryParse(json['date']) ?? DateTime.now()
              : DateTime.now()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'userImage': userImage,
      'rating': rating,
      'comment': comment,
      'date': date.toIso8601String(),
    };
  }
}
