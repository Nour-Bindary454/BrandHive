class BrandRequestResponse {
  final bool success;
  final String message;
  final BrandRequestData? data;

  BrandRequestResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory BrandRequestResponse.fromJson(Map<String, dynamic> json) {
    return BrandRequestResponse(
      success: json['success'] ?? true,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? BrandRequestData.fromJson(json['data'])
          : null,
    );
  }
}

class BrandRequestData {
  final String? name;
  final String? description;
  final String? country;
  final String? website;
  final BrandLogo? logo;
  final List<String> categories;
  final String? requestedBy;
  final String? whatsappLink;
  final bool shipsInternationally;
  final String? status;
  final String? rejectionReason;
  final String? createdAt;
  final String? updatedAt;

  BrandRequestData({
    this.name,
    this.description,
    this.country,
    this.website,
    this.logo,
    this.categories = const [],
    this.requestedBy,
    this.whatsappLink,
    this.shipsInternationally = false,
    this.status,
    this.rejectionReason,
    this.createdAt,
    this.updatedAt,
  });

  factory BrandRequestData.fromJson(Map<String, dynamic> json) {
    return BrandRequestData(
      name: json['name'],
      description: json['description'],
      country: json['country'],
      website: json['website'],
      logo: json['logo'] != null ? BrandLogo.fromJson(json['logo']) : null,
      categories: json['categories'] != null
          ? List<String>.from(json['categories'])
          : [],
      requestedBy: json['requestedBy'],
      whatsappLink: json['whatsappLink'],
      shipsInternationally: json['shipsInternationally'] ?? false,
      status: json['status'],
      rejectionReason: json['rejectionReason'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class BrandLogo {
  final String? url;
  final String? publicId;

  BrandLogo({this.url, this.publicId});

  factory BrandLogo.fromJson(Map<String, dynamic> json) {
    return BrandLogo(
      url: json['url'],
      publicId: json['publicId'],
    );
  }
}
