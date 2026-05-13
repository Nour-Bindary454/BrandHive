import 'package:brand/core/services/api_services.dart';
import 'package:brand/core/services/end_points.dart';
import '../models/address_model.dart';

class AddressRemoteDataSource {
  final ApiService _apiService;

  AddressRemoteDataSource(this._apiService);

  Future<List<AddressModel>> getAllAddresses() async {
    final response = await _apiService.getData(endPoint: EndPoints.addresses);
    final List<dynamic> data = response.data['data'] ?? [];
    return data.map((json) => AddressModel.fromJson(json)).toList();
  }

  Future<AddressModel> getAddress(String id) async {
    final response = await _apiService.getData(
      endPoint: '${EndPoints.addresses}/$id',
    );
    return AddressModel.fromJson(response.data['data'] ?? response.data);
  }

  Future<AddressModel> addAddress(AddressModel address) async {
    final response = await _apiService.postData(
      endPoint: EndPoints.addresses,
      data: address.toJson(),
    );
    return AddressModel.fromJson(response.data['data'] ?? response.data);
  }

  Future<AddressModel> updateAddress(AddressModel address) async {
    final response = await _apiService.putData(
      endPoint: '${EndPoints.addresses}/${address.id}',
      data: address.toJson(),
    );
    return AddressModel.fromJson(response.data['data'] ?? response.data);
  }

  Future<void> deleteAddress(String id) async {
    await _apiService.deleteData(
      endPoint: '${EndPoints.addresses}/$id',
    );
  }

  Future<double> getShippingFee(String governorate) async {
    final response = await _apiService.postData(
      endPoint: EndPoints.shippingFee,
      data: {'governorate': governorate},
    );
    // Adjust parsing based on actual backend response structure
    return (response.data['fee'] ?? 0).toDouble();
  }
}
