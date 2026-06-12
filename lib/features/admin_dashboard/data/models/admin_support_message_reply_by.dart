class AdminSupportMessageReplyBy {
  final String id;
  final String email;

  AdminSupportMessageReplyBy({required this.id, required this.email});

  factory AdminSupportMessageReplyBy.fromJson(Map<String, dynamic> json) {
    return AdminSupportMessageReplyBy(
      id: json['_id'] ?? '',
      email: json['email'] ?? '',
    );
  }
}
