import 'package:brand/core/errors/failure.dart';
import 'package:brand/core/services/api_services.dart';
import 'package:brand/features/admin_dashboard/data/models/admin_models.dart';
import 'package:brand/features/admin_dashboard/data/repository/admin_repo.dart';
import 'package:brand/features/admin_dashboard/data/repository/admin_requests_helper.dart';
import 'package:brand/features/admin_dashboard/data/repository/admin_stats_helper.dart';
import 'package:brand/features/admin_dashboard/data/repository/admin_management_helper.dart';
import 'package:brand/features/admin_dashboard/data/repository/admin_orders_helper.dart';
import 'package:brand/features/home/data/models/home_models.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AdminRepositoryImpl
    with
        AdminRequestsHelper,
        AdminStatsHelper,
        AdminManagementHelper,
        AdminOrdersHelper
    implements AdminRepository {
  final ApiService apiService;
  AdminRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, List<AdminStatModel>>> getDashboardStats() async {
    try {
      final stats = await fetchDashboardStats(apiService);
      return right(stats);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AdminBrandRequest>>> getBrandRequests() async {
    try {
      final requests = await fetchBrandRequestsList(apiService);
      return right(requests);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateBrandStatus(
    String id,
    BrandStatus status, {
    String? reason,
  }) async {
    try {
      final action = status == BrandStatus.approved ? 'approve' : 'reject';
      final data = (status == BrandStatus.rejected && reason != null)
          ? {'rejectionReason': reason}
          : null;

      await apiService.patchData(
        endPoint: "brand/requests/$id/$action",
        data: data,
      );
      return right(unit);
    } catch (e) {
      return left(
        e is DioException
            ? ServerFailure.fromDioError(e)
            : ServerFailure(e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteProduct(String id) async {
    try {
      await performDeleteProduct(apiService, id);
      return right(unit);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteBrand(String id) async {
    try {
      await performDeleteBrand(apiService, id);
      return right(unit);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> toggleBrandStatus(
    String id,
    bool isActive,
  ) async {
    try {
      await performToggleBrandStatus(apiService, id, isActive);
      return right(unit);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> toggleProductStatus(
    String id,
    bool isActive,
  ) async {
    try {
      await performToggleProductStatus(apiService, id, isActive);
      return right(unit);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    try {
      final categories = await fetchCategoriesList(apiService);
      return right(categories);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AdminOrderModel>>> getAllOrders() async {
    try {
      final orders = await fetchAllOrders(apiService);
      return right(orders);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<NotificationModel>>> getNotifications() async {
    try {
      final notifications = await fetchNotifications(apiService);
      return right(notifications);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
