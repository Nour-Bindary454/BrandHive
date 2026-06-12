import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:brand/features/admin_dashboard/data/repository/admin_repo.dart';
import 'admin_notification_state.dart';

class AdminNotificationCubit extends Cubit<AdminNotificationState> {
  final AdminRepository repository;

  AdminNotificationCubit(this.repository) : super(AdminNotificationState());

  Future<void> sendNotification({
    required String userId,
    required String title,
    required String body,
    required String type,
    String? orderId,
  }) async {
    if (userId.trim().isEmpty || title.trim().isEmpty || body.trim().isEmpty || type.trim().isEmpty) {
      emit(state.copyWith(error: "Please fill all required fields"));
      return;
    }

    emit(state.copyWith(isLoading: true));

    final Map<String, dynamic> payload = {
      "userId": userId,
      "type": type,
      "title": title,
      "body": body,
      if (orderId != null && orderId.trim().isNotEmpty)
        "data": {
          "orderId": orderId,
        },
    };

    final result = await repository.sendNotification(data: payload);

    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          error: failure.errMessage,
        ));
      },
      (successMsg) {
        emit(state.copyWith(
          isLoading: false,
          successMessage: successMsg,
        ));
      },
    );
  }
}
