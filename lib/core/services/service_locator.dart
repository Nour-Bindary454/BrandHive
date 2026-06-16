import 'package:brand/features/seller_registration/data/repository/seller_reg_impl.dart';
import 'package:brand/features/seller_registration/data/repository/seller_reg_repo.dart';
import 'package:brand/features/seller_registration/presentation/viewModel/seller_reg_cubit.dart';
import 'package:brand/features/seller/data/repository/seller_repo.dart';
import 'package:brand/features/seller/data/repository/seller_repo_impl.dart';
import 'package:brand/features/seller/presentation/view_model/seller_cubit.dart';
import 'package:brand/features/help_support/data/repository/support_repo.dart';
import 'package:brand/features/help_support/data/repository/support_repo_impl.dart';
import 'package:brand/features/help_support/presentation/viewModel/support_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'api_services.dart';

import 'package:brand/features/bazaar/data/repository/bazaar_repository_impl.dart';
import 'package:brand/features/bazaar/domain/repository/bazaar_repository.dart';
import 'package:brand/features/bazaar/presentation/cubit/bazaar_cubit.dart';

import 'package:brand/features/coupon/data/repository/coupon_repository_impl.dart';
import 'package:brand/features/coupon/domain/repository/coupon_repository.dart';
import 'package:brand/features/coupon/presentation/cubit/coupon_cubit.dart';

import 'package:brand/features/event/data/repository/event_repository_impl.dart';
import 'package:brand/features/event/domain/repository/event_repository.dart';
import 'package:brand/features/event/presentation/cubit/event_cubit.dart';


// ================= Repositories =================
import '../../features/signup/data/repository/register_repo_impl.dart';
import '../../features/signup/data/repository/register_repos.dart';

import '../../features/login/data/repository/login_repository_impl.dart';
import '../../features/login/data/repository/login_repos.dart';

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

// ================= Data Sources =================
import '../../features/checkout/data/data_sources/checkout_remote_data_source.dart';
import '../../features/checkout/data/repository/checkout_repository.dart';
import '../../features/orders/data/repository/orders_repo.dart';
import '../../features/orders/data/repository/orders_repo_impl.dart';

import '../../features/address/data/data_sources/address_remote_data_source.dart';
import '../../features/address/data/repository/address_repository.dart';

import '../../features/orders/data/data_sources/orders_remote_data_source.dart';
import '../../features/orders/data/repository/orders_repository.dart';

// ================= Seller Request (NEW FIX) =================

// ================= Cubits =================
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
import '../../features/admin_dashboard/presentation/view_model/admin_support_cubit.dart';
import '../../features/admin_dashboard/presentation/view_model/admin_notification_cubit.dart';
import '../../features/checkout/presentation/viewmodels/checkout_cubit.dart';
import '../../features/address/presentation/viewmodels/address_cubit.dart';
import '../../features/orders/presentation/view_model/orders_cubit.dart';

import 'package:brand/features/product_details/presentation/view_model/similar_products_cubit.dart';


// ================= GetIt =================


// ================= GetIt =================
final sl = GetIt.instance;

void setup() {
  // Dio
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

  // Api Service
  sl.registerLazySingleton<ApiService>(() => ApiService(sl<Dio>()));

  // ================= Repositories =================
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

  sl.registerLazySingleton<AdminRepository>(() => AdminRepositoryImpl(sl()));

  // ================= NEW: Brand Request Repo =================
  sl.registerLazySingleton<BrandRequestRepo>(() => BrandRequestRepoImpl(sl()));
  sl.registerLazySingleton<SellerRepository>(() => SellerRepositoryImpl(sl()));
  sl.registerLazySingleton<BazaarRepository>(() => BazaarRepositoryImpl(sl()));
  sl.registerLazySingleton<CouponRepository>(() => CouponRepositoryImpl(sl()));
  sl.registerLazySingleton<EventRepository>(() => EventRepositoryImpl(sl()));

  // ================= Data Sources =================
  sl.registerLazySingleton<CheckoutRemoteDataSource>(
    () => CheckoutRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<CheckoutRepository>(() => CheckoutRepository(sl()));
  sl.registerLazySingleton<OrdersRepo>(() => OrdersRepoImpl(sl()));

  sl.registerLazySingleton<AddressRemoteDataSource>(
    () => AddressRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<AddressRepository>(() => AddressRepository(sl()));

  sl.registerLazySingleton<SupportRepository>(() => SupportRepoImpl(sl()));

  sl.registerLazySingleton<OrdersRemoteDataSource>(
    () => OrdersRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<OrdersRepository>(() => OrdersRepository(sl()));

  // ================= Cubits =================
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

  sl.registerFactory(() => WishlistCubit(sl()));
  sl.registerFactory(() => NewArrivalsCubit(sl()));
  sl.registerFactory(() => NotificationsCubit(sl()));
  sl.registerFactory(() => AdminCubit(sl()));

  sl.registerFactory(() => CheckoutCubit(sl()));

  sl.registerFactory(() => AddressCubit(sl()));
   sl.registerFactory(() => OrdersCubit(sl()));
  // ================= FIXED =================



  sl.registerFactory(() => BrandRequestCubit(sl()));
  sl.registerFactory(() => SellerCubit(sl(), sl()));
  sl.registerFactory(() => SupportCubit(sl()));
  sl.registerFactory(() => AdminSupportCubit(sl()));
  sl.registerFactory(() => AdminNotificationCubit(sl()));

  sl.registerFactory(() => BazaarCubit(sl()));
  sl.registerFactory(() => CouponCubit(sl()));
  sl.registerFactory(() => EventCubit(sl()));

  sl.registerFactory(() => SimilarProductsCubit(sl()));

}
