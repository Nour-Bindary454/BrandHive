import 'package:bloc/bloc.dart';
import 'package:brand/core/services/dio_helper.dart';
import 'package:brand/features/login/data/repository/login_repos.dart';
import 'package:brand/features/login/presentation/viewsModel/login_states.dart';

import 'package:brand/core/services/cache_helper.dart';

import 'package:brand/core/services/token_manager.dart';

class LoginCubit extends Cubit<LoginStates> {
  final LoginRepository repo;

  LoginCubit(this.repo) : super(LoginInitState());

  Future<void> login({required String email, required String password}) async {
    //  validation
    if (email.isEmpty || password.isEmpty) {
      emit(LoginError("Please fill all fields"));
      return;
    }

    //  loading
    emit(LoginLoading());

    //  call repository
    final result = await repo.login(
      data: {"email": email, "password": password},
    );

    //  handle result
    result.fold(
      (failure) {
        emit(LoginError(failure.errMessage));
      },
      (response) async {
        if (response.accessToken != null) {
          await CacheHelper.saveData(
            key: 'token',
            value: response.accessToken!,
          );

          if (response.user != null) {
            await CacheHelper.saveData(
              key: 'id',
              value: response.user!.id ?? '',
            );
            await CacheHelper.saveData(
              key: 'name',
              value: response.user!.name ?? 'User',
            );
            await CacheHelper.saveData(
              key: 'email',
              value: response.user!.email ?? '',
            );
            await CacheHelper.saveData(
              key: 'role',
              value: response.user!.role ?? 'user',
            );
          }

          await TokenManager.saveToken(response.accessToken!);

          await DioHelper.updateToken();
        }

        emit(LoginSuccess(response));
      },
    );
  }
}
