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
    final response = await _apiService.getData(endPoint: EndPoints.addresses);
    
    // The response is a Map containing a 'data' key which is a List
    final List<dynamic> data = response.data['data'] ?? [];
    return data.map((json) => AddressModel.fromJson(json)).toList();
  }

  /// Place an order via API
  Future<CheckoutResponseModel> submitOrder(OrderModel order) async {
    final response = await _apiService.postData(
      endPoint: EndPoints.orders,
      data: {
        'shippingAddress': {
          'fullName': order.shippingAddress.fullName,
          'phone': order.shippingAddress.phone,
          'street': order.shippingAddress.street,
          'city': order.shippingAddress.city,
          'governorate': order.shippingAddress.governorate,
          if (order.shippingAddress.postalCode != null) 'postalCode': order.shippingAddress.postalCode,
          'country': order.shippingAddress.country,
        },
        'paymentMethod': order.paymentMethod,
      },
    );

    return CheckoutResponseModel.fromJson(response.data);
  }

  /// Clear the cart after placing the order
  Future<void> clearCart() async {
    await _apiService.deleteData(endPoint: 'cart/clear');
  }
}
