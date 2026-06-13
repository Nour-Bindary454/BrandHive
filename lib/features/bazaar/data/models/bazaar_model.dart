class BazaarModel {
  final String id;
  final String name;
  final String description;
  final String address;
  final String contactInfo;
  final String? imageUrl;
  final String? status;
  final bool? isActive;

  BazaarModel({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.contactInfo,
    this.imageUrl,
    this.status,
    this.isActive,
  });

  factory BazaarModel.fromJson(Map<String, dynamic> json) {
    String? img;
    if (json['image'] != null) {
      if (json['image'] is Map && json['image']['url'] != null) {
        img = json['image']['url'].toString();
      } else {
        img = json['image'].toString();
      }
    } else if (json['imageUrl'] != null) {
      img = json['imageUrl'].toString();
    }
    return BazaarModel(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'] ?? json['title'] ?? '',
      description: json['description'] ?? '',
      address: json['address'] ?? json['location'] ?? '',
      contactInfo: json['contactInfo'] ?? json['phone'] ?? json['whatsapp'] ?? '',
      imageUrl: img,
      status: json['status'],
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'address': address,
      'contactInfo': contactInfo,
      'imageUrl': imageUrl,
      'status': status,
      'isActive': isActive,
    };
  }
}
