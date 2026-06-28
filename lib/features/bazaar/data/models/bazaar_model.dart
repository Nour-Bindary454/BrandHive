class BazaarModel {
  final String id;
  final String name;
  final String description;
  final String address;
  final String contactInfo;
  final String? imageUrl;
  final String? status;
  final bool? isActive;
  final String? sellerId;
  final String? rejectionReason;

  BazaarModel({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.contactInfo,
    this.imageUrl,
    this.status,
    this.isActive,
    this.sellerId,
    this.rejectionReason,
  });

  factory BazaarModel.fromJson(Map<String, dynamic> json) {
    String? img;
    if (json['logo'] != null) {
      if (json['logo'] is Map && json['logo']['url'] != null) {
        img = json['logo']['url'].toString();
      } else {
        img = json['logo'].toString();
      }
    } else if (json['image'] != null) {
      if (json['image'] is Map && json['image']['url'] != null) {
        img = json['image']['url'].toString();
      } else {
        img = json['image'].toString();
      }
    } else if (json['imageUrl'] != null) {
      img = json['imageUrl'].toString();
    }

    String? sId;
    if (json['seller'] != null) {
      if (json['seller'] is Map && json['seller']['_id'] != null) {
        sId = json['seller']['_id'].toString();
      } else {
        sId = json['seller'].toString();
      }
    }

    return BazaarModel(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['storeName'] ?? json['name'] ?? json['title'] ?? '',
      description: json['description'] ?? '',
      address: json['address'] ?? json['location'] ?? '',
      contactInfo: json['phone'] ?? json['contactInfo'] ?? json['whatsapp'] ?? '',
      imageUrl: img,
      status: json['status'],
      isActive: json['isActive'],
      sellerId: sId,
      rejectionReason: json['rejectionReason'],
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
      'sellerId': sellerId,
      'rejectionReason': rejectionReason,
    };
  }
}
