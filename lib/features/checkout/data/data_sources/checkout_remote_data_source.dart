import 'package:brand/core/services/api_services.dart';
import 'package:brand/core/services/end_points.dart';
import '../models/order_model.dart';
import '../models/address_model.dart';
import '../models/checkout_response_model.dart';

class CheckoutRemoteDataSource {
  final ApiService _apiService;

  CheckoutRemoteDataSource(this._apiService);

  /// Fetch saved addresses from API
  Future<List<AddressModel>> fetchSavedAddresses() async {
    // For now, keeping mock addresses empty as there's no address endpoint in EndPoints
    await Future.delayed(const Duration(milliseconds: 500));
    return [];
  }

  /// Place an order via API
  Future<CheckoutResponseModel> submitOrder(OrderModel order) async {
    final addressJson = order.shippingAddress.toJson();
    if (addressJson['governorate'] == null ||
        addressJson['governorate'].toString().trim().isEmpty) {
      addressJson['governorate'] = order.shippingAddress.city.trim().isNotEmpty
          ? order.shippingAddress.city.trim()
          : 'Cairo';
    }

    final dataToSend = {
      'shippingAddress': addressJson,
      'paymentMethod': order.paymentMethod,
    };
    print("SENDING_ORDER_DATA: $dataToSend");

    final response = await _apiService.postData(
      endPoint: EndPoints.orders,
      data: dataToSend,
    );

    return CheckoutResponseModel.fromJson(response.data);
  }
}
