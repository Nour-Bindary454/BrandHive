import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'api_services.dart';
import '../../features/signup/data/repository/register_repos.dart';
import '../../features/signup/data/repository/register_repo_impl.dart';
import '../../features/signup/presentation/view_model/cubit/register_cubit.dart';
import '../../features/login/data/repository/login_repos.dart';
import '../../features/login/data/repository/login_repository_impl.dart';
import '../../features/login/presentation/viewsModel/login_cubit.dart';

final sl = GetIt.instance;

void setup() {
  //  Core
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<ApiService>(() => ApiService(sl()));

  //  Signup
  sl.registerLazySingleton<RegisterRepository>(() => RegisterRepoImpl(sl()));
  sl.registerFactory(() => RegisterCubit(sl()));

  //  Login
  sl.registerLazySingleton<LoginRepository>(() => LoginRepoImpl(sl()));

  sl.registerFactory(() => LoginCubit(sl()));
}
