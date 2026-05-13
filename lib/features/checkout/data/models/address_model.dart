class AddressModel {
  final String? id;
  final String fullName;
  final String phone;
  final String street;
  final String city;
  final String governorate;
  final String? postalCode;
  final String country;

  AddressModel({
    this.id,
    required this.fullName,
    required this.phone,
    required this.street,
    required this.city,
    required this.governorate,
    this.postalCode,
    required this.country,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['_id'],
      fullName: json['fullName'] ?? '',
      phone: json['phone'] ?? '',
      street: json['street'] ?? '',
      city: json['city'] ?? '',
      governorate: json['governorate'] ?? '',
      postalCode: json['postalCode'],
      country: json['country'] ?? '',
    );
  }

  String get fullAddress => '$street, $city, $governorate, $country';

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'phone': phone,
      'street': street,
      'city': city,
      'governorate': governorate,
      'postalCode': postalCode,
      'country': country,
    };
  }
}
