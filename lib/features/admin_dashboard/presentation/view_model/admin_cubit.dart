import 'package:brand/features/admin_dashboard/data/models/admin_models.dart';
import 'package:brand/features/admin_dashboard/data/repository/admin_repo.dart';
import 'package:brand/features/admin_dashboard/presentation/view_model/admin_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminCubit extends Cubit<AdminState> {
  final AdminRepository repo;

  AdminCubit(this.repo) : super(AdminInitial());

  Future<void> getDashboardData() async {
    emit(AdminLoading());

    final statsResult = await repo.getDashboardStats();
    final requestsResult = await repo.getBrandRequests();
    final notificationsResult = await repo.getNotifications();

    statsResult.fold(
      (failure) => emit(AdminError(failure.errMessage)),
      (stats) {
        requestsResult.fold(
          (failure) => emit(AdminError(failure.errMessage)),
          (requests) {
            notificationsResult.fold(
              (failure) => emit(AdminSuccess(stats: stats, requests: requests)),
              (notifications) => emit(AdminSuccess(
                stats: stats,
                requests: requests,
                notifications: notifications,
              )),
            );
          },
        );
      },
    );
  }

  Future<void> updateRequestStatus(String id, BrandStatus status) async {
    if (state is! AdminSuccess) return;

    final currentState = state as AdminSuccess;
    
    // Optimistic update
    final updatedRequests = currentState.requests.map((r) {
      if (r.id == id) return r.copyWith(status: status);
      return r;
    }).toList();
    
    emit(AdminSuccess(
      stats: currentState.stats,
      requests: updatedRequests,
      notifications: currentState.notifications,
    ));

    final result = await repo.updateBrandStatus(id, status);

    result.fold(
      (failure) {
        // Rollback on failure (in a real app you'd fetch data again or keep original list)
        getDashboardData(); 
      },
      (_) => null,
    );
  }

  Future<void> deleteProduct(String id) async {
    emit(AdminActionLoading());
    final result = await repo.deleteProduct(id);
    result.fold(
      (failure) => emit(AdminActionError(failure.errMessage)),
      (_) => emit(AdminActionSuccess('Product deleted successfully', id: id, action: 'delete_product')),
    );
  }

  Future<void> deleteBrand(String id) async {
    final result = await repo.deleteBrand(id);
    result.fold(
      (failure) => null,
      (_) => emit(AdminActionSuccess('brand_deleted', id: id, action: 'delete_brand')),
    );
  }

  Future<void> toggleBrandStatus(String id, bool isActive) async {
    final result = await repo.toggleBrandStatus(id, isActive);
    result.fold(
      (failure) => null,
      (_) => emit(AdminActionSuccess(isActive ? 'brand_deactivated' : 'brand_activated', id: id, action: 'toggle_brand')),
    );
  }

  Future<void> toggleProductStatus(String id, bool isActive) async {
    emit(AdminActionLoading());
    final result = await repo.toggleProductStatus(id, isActive);
    result.fold(
      (failure) => emit(AdminActionError(failure.errMessage)),
      (_) => emit(AdminActionSuccess(
        isActive ? 'product_deactivated' : 'product_activated',
        id: id,
        action: 'toggle_product',
      )),
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
