import 'package:brand/core/errors/failure.dart';
import 'package:brand/features/admin_dashboard/data/models/admin_models.dart';
import 'package:dartz/dartz.dart';

abstract class AdminRepository {
  Future<Either<Failure, List<AdminStatModel>>> getDashboardStats();
  Future<Either<Failure, List<AdminBrandRequest>>> getBrandRequests();
  Future<Either<Failure, Unit>> updateBrandStatus(String id, BrandStatus status);
  Future<Either<Failure, Unit>> deleteProduct(String id);
  Future<Either<Failure, Unit>> deleteBrand(String id);
  Future<Either<Failure, Unit>> toggleBrandStatus(String id, bool isActive);
  Future<Either<Failure, Unit>> toggleProductStatus(String id, bool isActive);
  Future<Either<Failure, List<AdminOrderModel>>> getAllOrders();
  Future<Either<Failure, List<NotificationModel>>> getNotifications();
}
