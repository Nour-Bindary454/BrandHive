import 'package:brand/core/errors/failure.dart';
import 'package:brand/features/admin_dashboard/data/models/admin_models.dart';
import 'package:dartz/dartz.dart';

abstract class AdminRepository {
  Future<Either<Failure, List<AdminStatModel>>> getDashboardStats();
  Future<Either<Failure, List<AdminBrandRequest>>> getBrandRequests();
  Future<Either<Failure, Unit>> updateBrandStatus(String id, BrandStatus status);
}
