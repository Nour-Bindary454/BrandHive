import 'package:bloc/bloc.dart';

import 'package:brand/features/verify/data/models/confirm_email_model.dart';
import 'package:brand/features/verify/data/repository/confirm_email_repository.dart';

part 'confirm_email_state.dart';

class ConfirmEmailCubit extends Cubit<ConfirmEmailState> {
  final ConfirmEmailRepository repo;

  ConfirmEmailCubit(this.repo) : super(ConfirmEmailInitial());

  Future<void> confirmEmail({
    required String email,
    required String otp,
  }) async {
    emit(ConfirmEmailLoading());

    final result = await repo.confirmEmail(
      request: ConfirmEmailRequestModel(email: email, otp: otp),
    );

    result.fold(
      (failure) => emit(ConfirmEmailError(failure.errMessage)),
      (message) => emit(ConfirmEmailSuccess()),
    );
  }
}
