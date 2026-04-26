import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'api_services.dart';
import 'end_points.dart';

import '../../features/signup/data/repository/register_repos.dart';
import '../../features/signup/data/repository/register_repo_impl.dart';
import '../../features/signup/presentation/view_model/cubit/register_cubit.dart';

final sl = GetIt.instance;

void setup() {
  // 🔹 Core services
  sl.registerLazySingleton<Dio>(() => Dio());

  sl.registerLazySingleton<ApiService>(() => ApiService(sl<Dio>()));

  // 🔹 Repository
  sl.registerLazySingleton<RegisterRepository>(() => RegisterRepoImpl(sl()));

  // 🔹 Cubit
  sl.registerFactory(() => RegisterCubit(sl()));
}
