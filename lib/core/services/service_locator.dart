import 'package:brand/features/seller_registration/data/repository/seller_reg_impl.dart';
import 'package:brand/features/seller_registration/data/repository/seller_reg_repo.dart';
import 'package:brand/features/seller_registration/presentation/viewModel/seller_reg_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

// Services

import 'api_services.dart';

// Repositories
import '../../features/signup/data/repository/register_repo_impl.dart';
import '../../features/signup/data/repository/register_repos.dart';

import '../../features/login/data/repository/login_repository_impl.dart';
import '../../features/login/data/repository/login_repos.dart';

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

// Data Sources
import '../../features/checkout/data/data_sources/checkout_remote_data_source.dart';
import '../../features/checkout/data/repository/checkout_repository.dart';

import '../../features/address/data/data_sources/address_remote_data_source.dart';
import '../../features/address/data/repository/address_repository.dart';

import '../../features/orders/data/data_sources/orders_remote_data_source.dart';
import '../../features/orders/data/repository/orders_repository.dart';

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

import '../../features/newArrivals/data/repository/new_arrivals_repo.dart';
import '../../features/newArrivals/data/repository/new_arrivals_repo_impl.dart';

import '../../features/notifications/data/repository/notifications_repo.dart';
import '../../features/notifications/data/repository/notifications_repo_impl.dart';

import '../../features/admin_dashboard/data/repository/admin_repo.dart';
import '../../features/admin_dashboard/data/repository/admin_repo_impl.dart';

import '../../features/checkout/data/data_sources/checkout_remote_data_source.dart';
import '../../features/checkout/data/repository/checkout_repository.dart';

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
import '../../features/checkout/presentation/viewmodels/checkout_cubit.dart';
import '../../features/address/presentation/viewmodels/address_cubit.dart';
import '../../features/orders/presentation/viewmodels/orders_cubit.dart';
import '../../features/newArrivals/presentation/viewModel/new_arrivals_cubit.dart';
import '../../features/notifications/presentation/viewmodel/notifications_cubit.dart';
import '../../features/admin_dashboard/presentation/view_model/admin_cubit.dart';
import '../../features/checkout/presentation/viewmodels/checkout_cubit.dart';
// ================= GetIt =================

final sl = GetIt.instance;

void setup() {
  // ---------------- Dio ----------------
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

  // Dio + ApiService
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

  // ---------------- Repositories ----------------
  // ================= REPOSITORIES =================

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

  sl.registerLazySingleton<NewArrivalsRepo>(() => NewArrivalsRepoImpl(sl()));
  sl.registerLazySingleton<NotificationsRepository>(
    () => NotificationsRepoImpl(sl()),
  );
  sl.registerLazySingleton<AdminRepository>(() => AdminRepositoryImpl());

  // Checkout / Address / Orders
  sl.registerLazySingleton<NewArrivalsRepo>(() => NewArrivalsRepoImpl(sl()));
  sl.registerLazySingleton<NotificationsRepository>(
    () => NotificationsRepoImpl(sl()),
  );
  sl.registerLazySingleton<AdminRepository>(() => AdminRepositoryImpl(sl()));

  sl.registerLazySingleton<CheckoutRemoteDataSource>(
    () => CheckoutRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<CheckoutRepository>(() => CheckoutRepository(sl()));

  sl.registerLazySingleton<AddressRemoteDataSource>(
    () => AddressRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<AddressRepository>(() => AddressRepository(sl()));
  sl.registerLazySingleton<CheckoutRepository>(() => CheckoutRepository(sl()));

  sl.registerLazySingleton<OrdersRemoteDataSource>(
    () => OrdersRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<OrdersRepository>(() => OrdersRepository(sl()));
  sl.registerLazySingleton<BrandRequestRepo>(() => BrandRequestRepoImpl(sl()));

  // ---------------- Cubits (ALL FACTORY ONLY) ----------------
  // ================= CUBITS =================

  sl.registerFactory(() => RegisterCubit(sl()));
  sl.registerFactory(() => LoginCubit(sl()));
  sl.registerFactory(() => ForgetPasswordCubit(sl()));
  sl.registerFactory(() => ConfirmEmailCubit(sl()));
  sl.registerFactory(() => VerifyResetCodeCubit(sl()));

  sl.registerFactory(() => HomeCubit());
  sl.registerFactory(() => ChangePassCubit(sl()));

  sl.registerFactory(() => ExploreCubit(sl()));
  sl.registerFactory(() => BrandProfileCubit());
  sl.registerFactory(() => CategoryCubit());
  sl.registerFactory(() => ExploreCubit(sl()));
  sl.registerFactory(() => BrandProfileCubit());
  sl.registerFactory(() => CategoryCubit());
  sl.registerFactory(() => WishlistCubit(sl()));
  sl.registerFactory(() => NewArrivalsCubit(sl()));
  sl.registerFactory(() => NotificationsCubit(sl()));
  sl.registerFactory(() => AdminCubit(sl()));

  sl.registerFactory(() => NewArrivalsCubit(sl()));
  sl.registerFactory(() => NotificationsCubit(sl()));
  sl.registerFactory(() => AdminCubit(sl()));
  sl.registerFactory(() => CheckoutCubit(sl()));
  sl.registerFactory(() => AddressCubit(sl()));
  sl.registerFactory(() => OrdersCubit(sl()));
  sl.registerFactory(() => BrandRequestCubit(sl()));
}
