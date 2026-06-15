import 'package:brand/core/errors/failure.dart';
import 'package:brand/features/admin_dashboard/data/models/admin_models.dart';
import 'package:brand/features/admin_dashboard/data/models/admin_support_message_model.dart';
import 'package:brand/features/home/data/models/home_models.dart';
import 'package:dartz/dartz.dart';

abstract class AdminRepository {
  Future<Either<Failure, List<AdminStatModel>>> getDashboardStats();
  Future<Either<Failure, List<AdminBrandRequest>>> getBrandRequests();
  Future<Either<Failure, Unit>> updateBrandStatus(String id, BrandStatus status, {String? reason});
  Future<Either<Failure, Unit>> deleteProduct(String id);
  Future<Either<Failure, Unit>> deleteBrand(String id);
  Future<Either<Failure, Unit>> toggleBrandStatus(String id, bool isActive);
  Future<Either<Failure, Unit>> toggleProductStatus(String id, bool isActive);
  Future<Either<Failure, List<CategoryModel>>> getCategories();
  Future<Either<Failure, List<AdminOrderModel>>> getAllOrders();
  Future<Either<Failure, Unit>> updateOrderStatus(String id, String status);
  Future<Either<Failure, List<NotificationModel>>> getNotifications();
  Future<Either<Failure, List<AdminSupportMessageModel>>> getSupportMessages();
  Future<Either<Failure, AdminSupportMessageModel>> replyToSupportMessage(String id, String reply);
  Future<Either<Failure, String>> sendNotification({required Map<String, dynamic> data});
  Future<Either<Failure, String?>> getUserIdByEmail(String email);
}
