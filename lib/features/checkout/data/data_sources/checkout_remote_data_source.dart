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
    // Note: If there's no specific address endpoint yet, we might keep it mocked
    // or use a profile/user endpoint. For now, assuming EndPoints.orders might have a related one
    // or we use a hardcoded endpoint for addresses if available.
    // Given the task, I'll stick to the orders integration.

    // For now, keeping mock addresses as there's no address endpoint in EndPoints
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      // AddressModel(
      //   id: 'addr1',
      //   firstName: 'Muhamed',
      //   lastName: 'Hassan',
      //   phoneNumber: '+20 123 456 7890',
      //   streetAddress: '15 El Tahrir St.',
      //   city: 'Cairo',
      //   areaDistrict: 'Zamalek',
      // ),
    ];
  }

  /// Place an order via API
  Future<CheckoutResponseModel> submitOrder(OrderModel order) async {
    final response = await _apiService.postData(
      endPoint: EndPoints.orders,
      data: order.toJson(),
    );

    return CheckoutResponseModel.fromJson(response.data);
  }
}
