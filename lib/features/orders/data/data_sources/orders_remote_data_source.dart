import 'package:brand/core/services/api_services.dart';
import 'package:brand/core/services/end_points.dart';
import 'package:brand/features/checkout/data/models/order_model.dart';
import 'package:brand/features/checkout/data/models/checkout_response_model.dart';

class OrdersRemoteDataSource {
  final ApiService _apiService;

  OrdersRemoteDataSource(this._apiService);

  Future<List<OrderModel>> getMyOrders() async {
    final response = await _apiService.getData(
      endPoint: '${EndPoints.orders}/my-orders',
    );
    final List<dynamic> data = response.data['data'] ?? [];
    return data.map((json) => OrderModel.fromJson(json)).toList();
  }

  Future<OrderModel> getOrderDetails(String orderId) async {
    final response = await _apiService.getData(
      endPoint: '${EndPoints.orders}/my-orders/$orderId',
    );
    return OrderModel.fromJson(response.data['data'] ?? response.data);
  }

  Future<void> cancelOrder(String orderId, String reason) async {
    await _apiService.postData(
      endPoint: '${EndPoints.orders}/my-orders/$orderId/cancel',
      data: {'reason': reason},
    );
  }

  Future<CheckoutResponseModel> retryPayment(String orderId) async {
    final response = await _apiService.postData(
      endPoint: 'payment/retry/$orderId',
      data: {},
    );
    return CheckoutResponseModel.fromJson(response.data);
  }

  /// Simulate a successful payment webhook for testing
  Future<void> simulatePaymentWebhook(String orderId, double amount) async {
    await _apiService.postData(
      endPoint: EndPoints.paymentWebhook,
      data: {
        "obj": {
          "order": {"id": orderId},
          "success": true,
          "amount_cents": (amount * 100).toInt(),
        }
      },
    );
  }

  // Admin endpoints
  Future<List<OrderModel>> getAllAdminOrders() async {
    final response = await _apiService.getData(
      endPoint: '${EndPoints.orders}/admin/all',
    );
    final List<dynamic> data = response.data['data'] ?? [];
    return data.map((json) => OrderModel.fromJson(json)).toList();
  }

  Future<OrderModel> updateOrderStatus(String orderId, String status, String note) async {
    final response = await _apiService.patchData(
      endPoint: '${EndPoints.orders}/admin/$orderId/status',
      data: {
        'status': status,
        'note': note,
      },
    );
    return OrderModel.fromJson(response.data['data'] ?? response.data);
  }
}
