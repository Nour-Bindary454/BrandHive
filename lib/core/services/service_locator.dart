import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'api_services.dart';

// Repos
import '../../features/signup/data/repository/register_repo_impl.dart';
import '../../features/signup/data/repository/register_repos.dart';

import '../../features/login/data/repository/login_repos.dart';
import '../../features/login/data/repository/login_repository_impl.dart';

import '../../features/forgetPassword/data/repository/forget_repo.dart';
import '../../features/forgetPassword/data/repository/forget_repo_impl.dart';

import '../../features/verify/data/repository/confirm_email_repository.dart';
import '../../features/verify/data/repository/confirm_email_impl.dart';

import '../../features/forgetPassword/data/repository/verify_reset_code_repository.dart';
import '../../features/forgetPassword/data/repository/verify_reset_code_repo_impl.dart';

import '../../features/home/data/repository/home_repo.dart';
import '../../features/home/data/repository/home_repository_impl.dart';

import '../../features/resetPassword/data/repository/chang_pass_repo.dart';
import '../../features/resetPassword/data/repository/chang_pass_repo_impl.dart';

import '../../features/explore/data/repository/explore_repo.dart';
import '../../features/explore/data/repository/explore_repo_impl.dart';

import '../../features/brand_profile/data/repository/brand_profile_repo.dart';
import '../../features/brand_profile/data/repository/brand_profile_repo_impl.dart';

import '../../features/wishlist/data/repository/wishlist_repo.dart';
import '../../features/wishlist/data/repository/wishlist_repo_impl.dart';

import '../../features/newArrivals/data/repository/new_arrivals_repo.dart';
import '../../features/newArrivals/data/repository/new_arrivals_repo_impl.dart';

import '../../features/notifications/data/repository/notifications_repo.dart';
import '../../features/notifications/data/repository/notifications_repo_impl.dart';
import '../../features/admin_dashboard/data/repository/admin_repo.dart';
import '../../features/admin_dashboard/data/repository/admin_repo_impl.dart';

// Cubits
import '../../features/signup/presentation/view_model/cubit/register_cubit.dart';
import '../../features/login/presentation/viewsModel/login_cubit.dart';
import '../../features/forgetPassword/presentaion/viewsModel/forget_cubit.dart';
import '../../features/verify/presentation/view_model/cubit/confirm_email_cubit.dart';
import '../../features/forgetPassword/presentaion/viewsModel/verify_reset_code_cubit.dart';
import '../../features/home/presentation/view_models/cubit/home_cubit.dart';
import '../../features/resetPassword/viewsModel/change_pass_cubit.dart';
import '../../features/explore/presentaion/viewsModel/explore_cubit.dart';
import '../../features/brand_profile/presentation/view_models/brand_profile_cubit.dart';
import '../../features/category/presentation/view_models/category_cubit.dart';
import '../../features/wishlist/presentation/viewsModel/wishlist_cubit.dart';
import '../../features/newArrivals/presentation/viewModel/new_arrivals_cubit.dart';
import '../../features/notifications/presentation/viewmodel/notifications_cubit.dart';
import '../../features/admin_dashboard/presentation/view_model/admin_cubit.dart';

final sl = GetIt.instance;

void setup() {
  // 🔹 Dio + ApiService
  sl.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: 'https://brandhive-apis-production.up.railway.app/',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    ),
  );

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
    () => BrandProfileRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<WishlistRepository>(
    () => WishlistRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<NewArrivalsRepo>(
    () => NewArrivalsRepoImpl(sl()),
  );
  sl.registerLazySingleton<NotificationsRepository>(
    () => NotificationsRepoImpl(sl()),
  );
  sl.registerLazySingleton<AdminRepository>(
    () => AdminRepositoryImpl(),
  );

  // 🔹 Cubits
  sl.registerFactory(() => RegisterCubit(sl()));
  sl.registerFactory(() => LoginCubit(sl()));
  sl.registerFactory(() => ForgetPasswordCubit(sl()));
  sl.registerFactory(() => ConfirmEmailCubit(sl()));
  sl.registerFactory(() => VerifyResetCodeCubit(sl()));
  sl.registerLazySingleton(() => HomeCubit());
  sl.registerFactory(() => ChangePassCubit(sl()));

  sl.registerLazySingleton(() => ExploreCubit(sl())); //
  sl.registerLazySingleton(() => BrandProfileCubit());
  sl.registerLazySingleton(() => CategoryCubit());
  sl.registerLazySingleton(() => WishlistCubit(sl()));
  sl.registerLazySingleton(() => NewArrivalsCubit(sl()));
  sl.registerLazySingleton(() => NotificationsCubit(sl()));
  sl.registerLazySingleton(() => AdminCubit(sl()));
}
