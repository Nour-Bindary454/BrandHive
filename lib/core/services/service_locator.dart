import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'api_services.dart';
import 'end_points.dart';

import '../../features/signup/data/repository/register_repos.dart';
import '../../features/signup/data/repository/register_repo_impl.dart';
import '../../features/signup/presentation/view_model/cubit/register_cubit.dart';
import '../../features/forgetPassword/data/repository/forget_repo.dart';
import '../../features/forgetPassword/data/repository/forget_repo_impl.dart';
import '../../features/forgetPassword/presentaion/viewsModel/forget_cubit.dart';
import '../../features/login/data/repository/login_repos.dart';
import '../../features/login/data/repository/login_repository_impl.dart';
import '../../features/login/presentation/viewsModel/login_cubit.dart';
import '../../features/verify/data/repository/confirm_email_repository.dart';
import '../../features/verify/data/repository/confirm_email_impl.dart';
import '../../features/verify/presentation/view_model/cubit/confirm_email_cubit.dart';
import '../../features/forgetPassword/data/repository/verify_reset_code_repository.dart';
import '../../features/forgetPassword/data/repository/verify_reset_code_repo_impl.dart';
import '../../features/forgetPassword/presentaion/viewsModel/verify_reset_code_cubit.dart';

final sl = GetIt.instance;

void setup() {
  // 🔹 Core services
  sl.registerLazySingleton<Dio>(() => Dio());

  sl.registerLazySingleton<ApiService>(() => ApiService(sl<Dio>()));

  // 🔹 Repository
  sl.registerLazySingleton<RegisterRepository>(() => RegisterRepoImpl(sl()));
  sl.registerLazySingleton<ForgetPasswordRepository>(() => ForgetPasswordRepoImpl(sl()));
  sl.registerLazySingleton<LoginRepository>(() => LoginRepoImpl(sl()));
  sl.registerLazySingleton<ConfirmEmailRepository>(() => ConfirmEmailRepoImpl(sl()));
  sl.registerLazySingleton<VerifyResetCodeRepository>(() => VerifyResetCodeRepoImpl(sl()));

  // 🔹 Cubit
  sl.registerFactory(() => RegisterCubit(sl()));
  sl.registerFactory(() => ForgetPasswordCubit(sl()));
  sl.registerFactory(() => LoginCubit(sl()));
  sl.registerFactory(() => ConfirmEmailCubit(sl()));
  sl.registerFactory(() => VerifyResetCodeCubit(sl()));
}
