import 'package:flutter/foundation.dart';
import 'package:brand/features/admin_dashboard/data/models/admin_models.dart';
import 'package:brand/features/admin_dashboard/data/repository/admin_repo.dart';
import 'package:brand/features/admin_dashboard/presentation/view_model/admin_states.dart';
import 'package:brand/features/home/data/models/home_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminCubit extends Cubit<AdminState> {
  final AdminRepository repo;

  AdminCubit(this.repo) : super(AdminInitial());

  Future<void> getDashboardData() async {
    emit(AdminLoading());

    final statsResult = await repo.getDashboardStats();
    final requestsResult = await repo.getBrandRequests();
    final categoriesResult = await repo.getCategories();
    final notificationsResult = await repo.getNotifications();

    statsResult.fold((failure) => emit(AdminError(failure.errMessage)), (
      stats,
    ) {
      requestsResult.fold((failure) => emit(AdminError(failure.errMessage)), (
        requests,
      ) async {
        // Fetch categories but don't fail if they can't be fetched
        final categoriesResult = await repo.getCategories();
        List<CategoryModel> categories = [];
        categoriesResult.fold((_) => null, (c) => categories = c);

        // Map category IDs to names
        final categoryMap = {for (var c in categories) c.id: c.name};
        final mappedRequests = requests.map((r) {
          final raw = r.rawData;
          String categoryName = r.category;

          // Try to extract from categories list in rawData
          if (raw['categories'] is List && raw['categories'].isNotEmpty) {
            final catList = raw['categories'] as List;
            final names = catList
                .map((id) => categoryMap[id.toString()] ?? id.toString())
                .toList();
            categoryName = names.join(', ');
          } else if (categoryMap.containsKey(r.category)) {
            categoryName = categoryMap[r.category]!;
          }

          return r.copyWith(category: categoryName);
        }).toList();

        notificationsResult.fold(
          (failure) =>
              emit(AdminSuccess(stats: stats, requests: mappedRequests)),
          (notifications) => emit(
            AdminSuccess(
              stats: stats,
              requests: mappedRequests,
              notifications: notifications,
            ),
          ),
        );
      });
    });
  }

  Future<void> updateRequestStatus(
    String id,
    BrandStatus status, {
    String? reason,
  }) async {
    if (state is! AdminSuccess) return;

    final currentState = state as AdminSuccess;

    // Optimistic update
    final updatedRequests = currentState.requests.map((r) {
      if (r.id == id) {
        return r.copyWith(status: status, rejectionReason: reason);
      }
      return r;
    }).toList();

    emit(
      AdminSuccess(
        stats: currentState.stats,
        requests: updatedRequests,
        notifications: currentState.notifications,
      ),
    );

    final result = await repo.updateBrandStatus(id, status, reason: reason);

    result.fold(
      (failure) {
        // Rollback on failure (in a real app you'd fetch data again or keep original list)
        getDashboardData();
      },
      (_) async {
        if (status == BrandStatus.approved) {
          try {
            // Find the approved request in currentState to get rawData
            final request = currentState.requests.firstWhere((r) => r.id == id);
            final userObj = request.rawData['user'];
            String? userId;
            if (userObj != null) {
              if (userObj is Map) {
                userId = userObj['_id'] ?? userObj['id'];
              } else if (userObj is String) {
                userId = userObj;
              }
            }

            if (userId != null && userId.isNotEmpty) {
              debugPrint("🚀 [AdminCubit] Sending approval notification to user: $userId");
              await repo.sendNotification(
                data: {
                  "userId": userId,
                  "type": "general",
                  "title": "Brand Approved",
                  "body": "Your brand request has been approved! You are now a seller.",
                },
              );
            } else {
              debugPrint("⚠️ [AdminCubit] Could not find user ID in brand request rawData");
            }
          } catch (e) {
            debugPrint("❌ [AdminCubit] Error sending brand approval notification: $e");
          }
        }
      },
    );
  }

  Future<void> deleteProduct(String id) async {
    emit(AdminActionLoading());
    final result = await repo.deleteProduct(id);
    result.fold(
      (failure) => emit(AdminActionError(failure.errMessage)),
      (_) => emit(
        AdminActionSuccess(
          'Product deleted successfully',
          id: id,
          action: 'delete_product',
        ),
      ),
    );
  }

  Future<void> deleteBrand(String id) async {
    final result = await repo.deleteBrand(id);
    result.fold(
      (failure) => null,
      (_) => emit(
        AdminActionSuccess('brand_deleted', id: id, action: 'delete_brand'),
      ),
    );
  }

  Future<void> toggleBrandStatus(String id, bool isActive) async {
    final result = await repo.toggleBrandStatus(id, isActive);
    result.fold(
      (failure) => null,
      (_) => emit(
        AdminActionSuccess(
          isActive ? 'brand_deactivated' : 'brand_activated',
          id: id,
          action: 'toggle_brand',
        ),
      ),
    );
  }

  Future<void> toggleProductStatus(String id, bool isActive) async {
    emit(AdminActionLoading());
    final result = await repo.toggleProductStatus(id, isActive);
    result.fold(
      (failure) => emit(AdminActionError(failure.errMessage)),
      (_) => emit(
        AdminActionSuccess(
          isActive ? 'product_deactivated' : 'product_activated',
          id: id,
          action: 'toggle_product',
        ),
      ),
    );
  }

  Future<void> getAllOrders() async {
    emit(AdminOrdersLoading());
    final result = await repo.getAllOrders();
    result.fold(
      (failure) => emit(AdminOrdersError(failure.errMessage)),
      (orders) => emit(AdminOrdersSuccess(orders)),
    );
  }
}
