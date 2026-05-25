import 'package:brand/core/services/api_services.dart';
import 'package:brand/core/services/end_points.dart';

mixin AdminManagementHelper {
  Future<void> performDeleteProduct(ApiService apiService, String id) async {
    await apiService.deleteData(endPoint: "${EndPoints.products}/$id");
  }

  Future<void> performDeleteBrand(ApiService apiService, String id) async {
    await apiService.deleteData(endPoint: EndPoints.brandAction(id));
  }

  Future<void> performToggleBrandStatus(ApiService apiService, String id, bool isActive) async {
    final endPoint = isActive
        ? EndPoints.deactivateBrand(id)
        : EndPoints.activateBrand(id);
    await apiService.patchData(endPoint: endPoint);
  }

  Future<void> performToggleProductStatus(ApiService apiService, String id, bool isActive) async {
    final action = isActive ? "deactivate" : "activate";
    await apiService.patchData(endPoint: "${EndPoints.products}/$id/$action");
  }
}
