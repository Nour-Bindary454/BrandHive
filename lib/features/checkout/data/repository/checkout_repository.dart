import '../data_sources/checkout_remote_data_source.dart';
import '../models/address_model.dart';
import '../models/order_model.dart';

class CheckoutRepository {
  final CheckoutRemoteDataSource _remoteDataSource;

  CheckoutRepository(this._remoteDataSource);

  Future<List<AddressModel>> getSavedAddresses() async {
    try {
      return await _remoteDataSource.fetchSavedAddresses();
    } catch (e) {
      // Handle logging or mapping to failures
      rethrow;
    }
  }

  Future<String> placeOrder(OrderModel order) async {
    try {
      final orderId = await _remoteDataSource.submitOrder(order);
      return orderId;
    } catch (e) {
      rethrow;
    }
  }
}
