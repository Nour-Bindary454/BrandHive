import 'package:brand/features/admin_dashboard/data/models/admin_models.dart';
import 'package:brand/features/admin_dashboard/data/repository/admin_repo.dart';
import 'package:brand/features/admin_dashboard/presentation/view_model/admin_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminCubit extends Cubit<AdminState> {
  final AdminRepository repo;

  AdminCubit(this.repo) : super(AdminInitial());

  Future<void> getDashboardData() async {
    emit(AdminLoading());

    final statsResult = await repo.getDashboardStats();
    final requestsResult = await repo.getBrandRequests();

    statsResult.fold(
      (failure) => emit(AdminError(failure.errMessage)),
      (stats) {
        requestsResult.fold(
          (failure) => emit(AdminError(failure.errMessage)),
          (requests) => emit(AdminSuccess(stats: stats, requests: requests)),
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
    
    emit(AdminSuccess(stats: currentState.stats, requests: updatedRequests));

    final result = await repo.updateBrandStatus(id, status);

    result.fold(
      (failure) {
        // Rollback on failure (in a real app you'd fetch data again or keep original list)
        getDashboardData(); 
      },
      (_) => null,
    );
  }
}
