import 'package:bloc/bloc.dart';
import 'package:brand/features/forgetPassword/data/repository/verify_reset_code_repository.dart';
import 'package:brand/features/forgetPassword/presentaion/viewsModel/verify_reset_code_states.dart';

class VerifyResetCodeCubit extends Cubit<VerifyResetCodeStates> {
  final VerifyResetCodeRepository repo;

  VerifyResetCodeCubit(this.repo) : super(VerifyResetCodeInitial());

  Future<void> verifyResetCode({required String email, required String otp}) async {
    emit(VerifyResetCodeLoading());

    final result = await repo.verifyResetCode(data: {"email": email, "otp": otp});

    result.fold(
      (failure) => emit(VerifyResetCodeError(failure.errMessage)),
      (message) => emit(VerifyResetCodeSuccess(message)),
    );
  }
}
