import 'package:brand/core/errors/failure.dart';
import 'package:brand/features/resetPassword/data/repository/chang_pass_repo.dart';
import 'package:brand/features/resetPassword/viewsModel/change_pass_states.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ChangePassCubit extends Cubit<ChangePassState> {
  final ChangePassRepo repo;

  ChangePassCubit(this.repo) : super(ChangePassInitial());

  void changePassword({required String email, required String password}) async {
    emit(ChangePassLoading());

    try {
      final message = await repo.changePassword(
        email: email,
        password: password,
      );

      emit(ChangePassSuccess(message));
    } on DioException catch (e) {
      if (e.error is ServerFailure) {
        emit(ChangePassFailure((e.error as ServerFailure).errMessage));
      } else {
        emit(ChangePassFailure(e.toString()));
      }
    } catch (e) {
      emit(ChangePassFailure(e.toString()));
    }
  }
}
