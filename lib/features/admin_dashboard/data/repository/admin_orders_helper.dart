import 'package:brand/core/services/api_services.dart';
import 'package:brand/core/services/end_points.dart';
import 'package:brand/features/admin_dashboard/data/models/admin_models.dart';

mixin AdminOrdersHelper {
  Future<List<AdminOrderModel>> fetchAllOrders(ApiService apiService) async {
    final response = await apiService.getData(endPoint: EndPoints.adminOrders);
    final List data = response.data['data'] ?? [];
    return data.map((e) => AdminOrderModel.fromJson(e)).toList();
  }

  Future<void> performUpdateOrderStatus(
    ApiService apiService,
    String id,
    String status,
  ) async {
    await apiService.patchData(
      endPoint: EndPoints.updateOrderStatus(id),
      data: {'status': status.toLowerCase()},
    );
  }

  Future<List<NotificationModel>> fetchNotifications(ApiService apiService) async {
    final response = await apiService.getData(endPoint: EndPoints.notifications);
    final List data = response.data['data'] ?? [];
    return data.map((e) => NotificationModel.fromJson(e)).toList();
  }
}
