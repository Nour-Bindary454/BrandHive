import 'package:flutter/foundation.dart';
import 'package:brand/core/errors/failure.dart';
import 'package:brand/core/services/api_services.dart';
import 'package:brand/core/services/end_points.dart';
import 'package:brand/features/admin_dashboard/data/models/admin_models.dart';
import 'package:brand/features/admin_dashboard/data/models/admin_support_message_model.dart';
import 'package:brand/features/admin_dashboard/data/models/admin_support_messages_response.dart';
import 'package:brand/features/admin_dashboard/data/models/admin_support_message_reply_response.dart';
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

  @override
  Future<Either<Failure, List<AdminSupportMessageModel>>> getSupportMessages() async {
    try {
      final response = await apiService.getData(endPoint: EndPoints.support);
      final model = AdminSupportMessagesResponse.fromJson(response.data);
      return right(model.data);
    } catch (e) {
      return left(
        e is DioException
            ? ServerFailure.fromDioError(e)
            : ServerFailure(e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, AdminSupportMessageModel>> replyToSupportMessage(String id, String reply) async {
    try {
      final response = await apiService.postData(
        endPoint: "${EndPoints.support}/$id/reply",
        data: {"reply": reply},
      );
      final model = AdminSupportMessageReplyResponse.fromJson(response.data);
      if (model.data != null) {
        return right(model.data!);
      }
      return left(ServerFailure("Invalid reply data received"));
    } catch (e) {
      return left(
        e is DioException
            ? ServerFailure.fromDioError(e)
            : ServerFailure(e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, String>> sendNotification({
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await apiService.postData(
        endPoint: "${EndPoints.notifications}/send",
        data: data,
      );
      return right(response.data['message'] ?? 'Notification sent');
    } catch (e) {
      return left(
        e is DioException
            ? ServerFailure.fromDioError(e)
            : ServerFailure(e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, String?>> getUserIdByEmail(String email) async {
    try {
      final cleanEmail = email.trim().toLowerCase();
      debugPrint("🔍 [AdminRepositoryImpl] Lookup user ID for email: '$cleanEmail'");

      int page = 1;
      bool hasMore = true;

      while (hasMore) {
        debugPrint("🔍 [AdminRepositoryImpl] Fetching page $page with limit=100");
        final response = await apiService.getData(
          endPoint: "admin/users",
          query: {"page": "$page", "limit": "100"},
        );

        final List<dynamic> data = response.data['data'] ?? response.data ?? [];
        debugPrint("🔍 [AdminRepositoryImpl] Page $page response count: ${data.length}");

        if (data.isEmpty) {
          hasMore = false;
          break;
        }

        for (final u in data) {
          if (u is Map) {
            final uEmail = u['email']?.toString().trim().toLowerCase();
            if (uEmail == cleanEmail) {
              final id = u['_id'] ?? u['id'];
              debugPrint("🔍 [AdminRepositoryImpl] Found matching user: $uEmail with ID: $id");
              if (id != null) return right(id.toString());
            }
          }
        }

        if (data.length < 100) {
          hasMore = false;
        } else {
          page++;
        }
      }

      debugPrint("⚠️ [AdminRepositoryImpl] No user found with email: '$cleanEmail' after pagination check");
      return right(null);
    } catch (e) {
      debugPrint("❌ [AdminRepositoryImpl] Error fetching users: $e");
      return left(
        e is DioException
            ? ServerFailure.fromDioError(e)
            : ServerFailure(e.toString()),
      );
    }
  }
}
