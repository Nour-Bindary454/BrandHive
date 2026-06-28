class SupportResponseData {
  final String id;

  SupportResponseData({required this.id});

  factory SupportResponseData.fromJson(Map<String, dynamic> json) {
    return SupportResponseData(
      id: json['id'] ?? '',
    );
  }
}
