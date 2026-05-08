import 'package:brand/features/home/presentation/view_models/cubit/home_cubit.dart';
import 'package:brand/features/login/data/repository/login_repos.dart';
import 'package:brand/features/login/data/repository/login_repository_impl.dart';
import 'package:brand/features/login/presentation/viewsModel/login_cubit.dart';
import 'package:brand/features/brand_profile/data/repository/brand_profile_repo.dart';
import 'package:brand/features/brand_profile/data/repository/brand_profile_repo_impl.dart';
import 'package:brand/features/brand_profile/presentation/view_models/brand_profile_cubit.dart';

import 'package:brand/features/resetPassword/viewsModel/change_pass_cubit.dart';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'api_services.dart';

import '../../features/signup/data/repository/register_repos.dart';
import '../../features/signup/data/repository/register_repo_impl.dart';
import '../../features/signup/presentation/view_model/cubit/register_cubit.dart';

import '../../features/forgetPassword/data/repository/forget_repo.dart';
import '../../features/forgetPassword/data/repository/forget_repo_impl.dart';
import '../../features/forgetPassword/presentaion/viewsModel/forget_cubit.dart';

import '../../features/verify/data/repository/confirm_email_repository.dart';
import '../../features/verify/data/repository/confirm_email_impl.dart';
import '../../features/verify/presentation/view_model/cubit/confirm_email_cubit.dart';

import '../../features/forgetPassword/data/repository/verify_reset_code_repository.dart';
import '../../features/forgetPassword/data/repository/verify_reset_code_repo_impl.dart';
import '../../features/forgetPassword/presentaion/viewsModel/verify_reset_code_cubit.dart';
import '../../features/home/data/repository/home_repo.dart';
import '../../features/home/data/repository/home_repository_impl.dart';

import '../../features/resetPassword/data/repository/chang_pass_repo.dart';
import '../../features/resetPassword/data/repository/chang_pass_repo_impl.dart';
import '../../features/explore/data/repository/explore_repo.dart';
import '../../features/explore/data/repository/explore_repo_impl.dart';
import '../../features/explore/presentaion/viewsModel/explore_cubit.dart';

final sl = GetIt.instance;

void setup() {
  // 🔹 Core
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<ApiService>(() => ApiService(sl<Dio>()));

  // 🔹 Repositories
  sl.registerLazySingleton<RegisterRepository>(() => RegisterRepoImpl(sl()));
  sl.registerLazySingleton<LoginRepository>(() => LoginRepoImpl(sl()));
  sl.registerLazySingleton<ForgetPasswordRepository>(
    () => ForgetPasswordRepoImpl(sl()),
  );
  sl.registerLazySingleton<ConfirmEmailRepository>(
    () => ConfirmEmailRepoImpl(sl()),
  );
  sl.registerLazySingleton<VerifyResetCodeRepository>(
    () => VerifyResetCodeRepoImpl(sl()),
  );
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(sl()));
  sl.registerLazySingleton<ChangePassRepo>(() => ChangePassRepoImpl(sl()));
  sl.registerLazySingleton<ExploreRepository>(
    () => ExploreRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<BrandProfileRepository>(
    () => BrandProfileRepositoryImpl(sl<ApiService>()),
  );

  // 🔹 Cubits
  sl.registerFactory(() => RegisterCubit(sl()));
  sl.registerFactory(() => LoginCubit(sl()));
  sl.registerFactory(() => ForgetPasswordCubit(sl()));
  sl.registerFactory(() => ConfirmEmailCubit(sl()));
  sl.registerFactory(() => VerifyResetCodeCubit(sl()));
  sl.registerFactory(() => HomeCubit());
  sl.registerFactory(() => ChangePassCubit(sl()));
  sl.registerFactory<ExploreCubit>(() => ExploreCubit());
  sl.registerFactory<BrandProfileCubit>(() => BrandProfileCubit());
}
