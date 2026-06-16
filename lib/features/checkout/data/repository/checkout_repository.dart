import 'dart:convert';
import 'package:brand/core/services/cache_helper.dart';
import '../data_sources/checkout_remote_data_source.dart';
import '../models/address_model.dart';
import '../models/checkout_response_model.dart';
import '../models/order_model.dart';

class CheckoutRepository {
  final CheckoutRemoteDataSource _remoteDataSource;

  CheckoutRepository(this._remoteDataSource);

  Future<List<AddressModel>> getSavedAddresses() async {
    try {
      final cachedStr = CacheHelper.getData(key: 'saved_addresses');
      if (cachedStr != null && cachedStr.isNotEmpty) {
        final List<dynamic> decoded = jsonDecode(cachedStr);
        return decoded.map((e) => AddressModel.fromJson(e)).toList();
      }
      return await _remoteDataSource.fetchSavedAddresses();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveAddress(AddressModel address) async {
    try {
      final current = await getSavedAddresses();
      final exists = current.any((element) =>
          element.street.trim() == address.street.trim() &&
          element.city.trim() == address.city.trim() &&
          element.fullName.trim() == address.fullName.trim());
      if (!exists) {
        final addressWithId = AddressModel(
          id: address.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
          fullName: address.fullName,
          phone: address.phone,
          street: address.street,
          city: address.city,
          governorate: address.governorate,
          postalCode: address.postalCode,
          country: address.country,
        );
        current.add(addressWithId);
        final encoded = jsonEncode(current.map((e) => {
          '_id': e.id,
          'fullName': e.fullName,
          'phone': e.phone,
          'street': e.street,
          'city': e.city,
          'governorate': e.governorate,
          'postalCode': e.postalCode,
          'country': e.country,
        }).toList());
        await CacheHelper.saveData(key: 'saved_addresses', value: encoded);
      }
    } catch (e) {
      // ignore
    }
  }

  Future<CheckoutResponseModel> placeOrder(OrderModel order) async {
    try {
      return await _remoteDataSource.submitOrder(order);
    } catch (e) {
      rethrow;
    }
  }
}