import 'package:equatable/equatable.dart';

class AddressModel extends Equatable {
  final String? id;
  final String user;
  final String fullName;
  final String phone;
  final String street;
  final String city;
  final String governorate;
  final String? postalCode;
  final String country;
  final bool isDefault;
  final String label;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const AddressModel({
    this.id,
    this.user = '',
    required this.fullName,
    required this.phone,
    required this.street,
    required this.city,
    required this.governorate,
    this.postalCode,
    required this.country,
    this.isDefault = false,
    this.label = 'Home',
    this.createdAt,
    this.updatedAt,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['_id'],
      user: json['user'] ?? '',
      fullName: json['fullName'] ?? '',
      phone: json['phone'] ?? '',
      street: json['street'] ?? '',
      city: json['city'] ?? '',
      governorate: json['governorate'] ?? '',
      postalCode: json['postalCode'],
      country: json['country'] ?? '',
      isDefault: json['isDefault'] ?? false,
      label: json['label'] ?? 'Home',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      'fullName': fullName,
      'phone': phone,
      'street': street,
      'city': city,
      'governorate': governorate,
      'postalCode': postalCode,
      'country': country,
      'isDefault': isDefault,
      'label': label,
    };
  }

  AddressModel copyWith({
    String? id,
    String? user,
    String? fullName,
    String? phone,
    String? street,
    String? city,
    String? governorate,
    String? postalCode,
    String? country,
    bool? isDefault,
    String? label,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AddressModel(
      id: id ?? this.id,
      user: user ?? this.user,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      street: street ?? this.street,
      city: city ?? this.city,
      governorate: governorate ?? this.governorate,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
      isDefault: isDefault ?? this.isDefault,
      label: label ?? this.label,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        user,
        fullName,
        phone,
        street,
        city,
        governorate,
        postalCode,
        country,
        isDefault,
        label,
        createdAt,
        updatedAt,
      ];
}
