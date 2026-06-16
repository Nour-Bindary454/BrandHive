import 'package:brand/features/checkout/data/models/order_model.dart';
import 'package:brand/features/seller/data/model/seller_models.dart';
import 'package:brand/features/seller_registration/data/model/category_model.dart';
import 'package:brand/features/home/data/models/home_models.dart' hide CategoryModel;

abstract class SellerState {}

class SellerInitial extends SellerState {}

// ================= Dashboard States =================
class SellerDashboardLoading extends SellerState {}
class SellerDashboardSuccess extends SellerState {
  final SellerDashboardData data;
  SellerDashboardSuccess(this.data);
}
class SellerDashboardFailure extends SellerState {
  final String error;
  SellerDashboardFailure(this.error);
}

// ================= Products States =================
class SellerProductsLoading extends SellerState {}
class SellerProductsSuccess extends SellerState {
  final List<SellerProductModel> products;
  SellerProductsSuccess(this.products);
}
class SellerProductsFailure extends SellerState {
  final String error;
  SellerProductsFailure(this.error);
}

// ================= Product Details States =================
class SellerProductDetailLoading extends SellerState {}
class SellerProductDetailSuccess extends SellerState {
  final SellerProductModel product;
  SellerProductDetailSuccess(this.product);
}
class SellerProductDetailFailure extends SellerState {
  final String error;
  SellerProductDetailFailure(this.error);
}

// ================= Add/Update/Delete Product Action States =================
class SellerProductActionLoading extends SellerState {}
class SellerProductActionSuccess extends SellerState {
  final String message;
  final SellerProductModel? product;
  SellerProductActionSuccess(this.message, {this.product});
}
class SellerProductActionFailure extends SellerState {
  final String error;
  SellerProductActionFailure(this.error);
}

// ================= Stock Alert / Adjustment States =================
class SellerStockAlertsLoading extends SellerState {}
class SellerStockAlertsSuccess extends SellerState {
  final List<SellerInventoryAlert> alerts;
  SellerStockAlertsSuccess(this.alerts);
}
class SellerStockAlertsFailure extends SellerState {
  final String error;
  SellerStockAlertsFailure(this.error);
}

class SellerStockAdjustmentSuccess extends SellerState {
  final String message;
  SellerStockAdjustmentSuccess(this.message);
}

// ================= Orders States =================
class SellerOrdersLoading extends SellerState {}
class SellerOrdersSuccess extends SellerState {
  final List<OrderModel> orders;
  SellerOrdersSuccess(this.orders);
}
class SellerOrdersFailure extends SellerState {
  final String error;
  SellerOrdersFailure(this.error);
}

// ================= Order Details States =================
class SellerOrderDetailLoading extends SellerState {}
class SellerOrderDetailSuccess extends SellerState {
  final OrderModel order;
  SellerOrderDetailSuccess(this.order);
}
class SellerOrderDetailFailure extends SellerState {
  final String error;
  SellerOrderDetailFailure(this.error);
}

// ================= Analytics & Reviews States =================
class SellerAnalyticsLoading extends SellerState {}
class SellerAnalyticsSuccess extends SellerState {
  final SellerAnalyticsData data;
  SellerAnalyticsSuccess(this.data);
}
class SellerAnalyticsFailure extends SellerState {
  final String error;
  SellerAnalyticsFailure(this.error);
}

class SellerProductInsightsLoading extends SellerState {}
class SellerProductInsightsSuccess extends SellerState {
  final ProductInsightsData data;
  SellerProductInsightsSuccess(this.data);
}
class SellerProductInsightsFailure extends SellerState {
  final String error;
  SellerProductInsightsFailure(this.error);
}

class SellerReviewsLoading extends SellerState {}
class SellerReviewsSuccess extends SellerState {
  final List<SellerReviewModel> reviews;
  SellerReviewsSuccess(this.reviews);
}
class SellerReviewsFailure extends SellerState {
  final String error;
  SellerReviewsFailure(this.error);
}

// ================= Categories States =================
class SellerCategoriesLoading extends SellerState {}
class SellerCategoriesSuccess extends SellerState {
  final List<CategoryModel> categories;
  SellerCategoriesSuccess(this.categories);
}
class SellerCategoriesFailure extends SellerState {
  final String error;
  SellerCategoriesFailure(this.error);
}

// ================= Brand States =================
class SellerBrandLoading extends SellerState {}
class SellerBrandSuccess extends SellerState {
  final BrandModel? brand;
  SellerBrandSuccess(this.brand);
}
class SellerBrandFailure extends SellerState {
  final String error;
  SellerBrandFailure(this.error);
}
class SellerBrandActionSuccess extends SellerState {
  final String message;
  SellerBrandActionSuccess(this.message);
}
