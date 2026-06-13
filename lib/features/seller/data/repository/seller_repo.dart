import 'package:brand/features/checkout/data/models/order_model.dart';
import 'package:brand/features/seller/data/model/seller_models.dart';

abstract class SellerRepository {
  Future<SellerDashboardData> getDashboard();
  Future<List<SellerProductModel>> getProducts();
  Future<SellerProductModel> getProductDetails(String id);
  Future<SellerProductModel> createProduct(Map<String, dynamic> body);
  Future<SellerProductModel> updateProduct(String id, Map<String, dynamic> body);
  Future<void> deleteProduct(String id);
  Future<List<SellerInventoryAlert>> getStockAlerts();
  Future<void> adjustStock(String id, int quantity);
  Future<List<OrderModel>> getOrders({String? status});
  Future<OrderModel> getOrderDetails(String id);
  Future<SellerAnalyticsData> getAnalytics();
  Future<List<SellerReviewModel>> getReviews();
}
