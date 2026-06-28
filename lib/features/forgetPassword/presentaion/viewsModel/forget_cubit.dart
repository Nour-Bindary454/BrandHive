import 'package:brand/features/forgetPassword/data/repository/forget_repo.dart';
import 'package:brand/features/forgetPassword/presentaion/viewsModel/forget_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordStates> {
  final ForgetPasswordRepository repo;

  ForgetPasswordCubit(this.repo) : super(ForgetPasswordInitial());

  Future<void> forgetPassword(String email) async {
    emit(ForgetPasswordLoading());

    final result = await repo.forgetPassword(data: {"email": email});

    result.fold(
      (failure) => emit(ForgetPasswordError(failure.errMessage)),
      (response) => emit(ForgetPasswordSuccess(response.message ?? "Success")),
    );
  }
}
