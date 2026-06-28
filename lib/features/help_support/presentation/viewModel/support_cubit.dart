import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:brand/core/services/cache_helper.dart';
import 'package:brand/features/help_support/data/repository/support_repo.dart';
import 'support_state.dart';

class SupportCubit extends Cubit<SupportState> {
  final SupportRepository repository;

  SupportCubit(this.repository) : super(SupportState());

  Future<void> sendSupportMessage({
    required String fullName,
    required String email,
    required String message,
  }) async {
    if (fullName.trim().isEmpty || email.trim().isEmpty || message.trim().isEmpty) {
      emit(state.copyWith(
        errorMessage: "Please fill all fields",
      ));
      return;
    }

    emit(state.copyWith(isLoading: true));

    final String? userId = CacheHelper.getData(key: 'id');

    final result = await repository.sendSupportMessage(
      data: {
        "fullName": fullName.trim(),
        "email": email.trim(),
        "message": message.trim(),
      },
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: failure.errMessage,
        ));
      },
      (response) {
        emit(state.copyWith(
          isLoading: false,
          successMessage: response.message,
        ));
      },
    );
  }
}
