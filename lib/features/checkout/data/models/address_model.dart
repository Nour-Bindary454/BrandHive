class AddressModel {
  final String id; // added for saved addresses
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String streetAddress;
  final String city;
  final String areaDistrict;

  AddressModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.streetAddress,
    required this.city,
    required this.areaDistrict,
  });

  String get fullName => '$firstName $lastName';
  String get fullAddress => '$streetAddress, $areaDistrict, $city';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'streetAddress': streetAddress,
      'city': city,
      'areaDistrict': areaDistrict,
    };
  }
}
