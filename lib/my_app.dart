import 'package:brand/core/services/api_services.dart';
import 'package:brand/core/services/service_locator.dart';
import 'package:brand/core/theme/app_theme.dart';
import 'package:brand/features/brand_profile/presentation/views/brand_profile_screen.dart';
import 'package:brand/features/forgetPassword/presentaion/views/forget_password.dart';
import 'package:brand/features/forgetPassword/presentaion/viewsModel/forget_cubit.dart';
import 'package:brand/features/help_support/presentation/views/help_support_view.dart';
import 'package:brand/features/home/presentation/view_models/cubit/home_cubit.dart';
import 'package:brand/features/home/presentation/views/home.dart';
import 'package:brand/features/notifications/presentation/views/notifications_view.dart';
import 'package:brand/features/orders/presentation/views/orders_view.dart';
import 'package:brand/features/settings/presentation/views/settings_view.dart';
import 'package:brand/features/settings/presentation/viewmodels/settings_view_model.dart';
import 'package:brand/features/login/presentation/views/login_view.dart';
import 'package:brand/features/main_layout/presentation/views/mainlayout.dart';
import 'package:brand/features/onboarding/presentation/views/onboarding.dart';
import 'package:brand/features/resetPassword/view/reset_password.dart';
import 'package:brand/features/signup/presentation/view_model/cubit/register_cubit.dart';
import 'package:brand/features/signup/presentation/views/signup.dart';
import 'package:brand/features/splash/presentation/views/splash_veiws.dart';
import 'package:brand/features/verify/presentation/view/verify.dart';
import 'package:brand/features/verify/presentation/view_model/cubit/confirm_email_cubit.dart';
import 'package:brand/features/forgetPassword/presentaion/viewsModel/verify_reset_code_cubit.dart';
import 'package:brand/features/welcome/presentation/views/welcome.dart';
import 'package:brand/features/seller_registration/presentation/views/seller_registration_view.dart';
import 'package:brand/features/seller_registration/presentation/views/seller_registration_success_view.dart';
import 'package:brand/features/payment_methods/presentation/views/payment_methods_view.dart';
import 'package:brand/features/wishlist/presentation/views/wishlist_view.dart';
import 'package:brand/features/seller/seller_main_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:brand/features/cart/data/repository/cart_repository.dart';
import 'package:brand/features/cart/services/cart_service.dart';
import 'package:brand/features/cart/presentation/viewmodel/cart_view_model.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:brand/features/notifications/presentation/viewmodel/notifications_cubit.dart';
import 'package:brand/features/wishlist/presentation/viewsModel/wishlist_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<NotificationsCubit>(create: (_) => sl<NotificationsCubit>()),
        BlocProvider<WishlistCubit>(create: (_) => sl<WishlistCubit>()),
        BlocProvider<HomeCubit>(create: (_) => sl<HomeCubit>()),
        Provider<CartRepository>(
          create: (_) => CartRepository(sl<ApiService>()),
        ),
        ProxyProvider<CartRepository, CartService>(
          update: (_, repo, __) => CartService(repo),
        ),
        ChangeNotifierProxyProvider<CartService, CartViewModel>(
          create: (context) => CartViewModel(context.read<CartService>()),
          update: (_, service, viewModel) =>
              viewModel ?? CartViewModel(service),
        ),

        ChangeNotifierProvider(create: (_) => SettingsViewModel()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return Consumer<SettingsViewModel>(
            builder: (context, settings, _) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                themeMode: settings.darkMode ? ThemeMode.dark : ThemeMode.light,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                initialRoute: '/',
                routes: {
                  '/': (context) => Splash(),
                  '/onboarding': (context) => Onboarding(),
                  '/welcome': (context) => Welcome(),
                  '/login': (context) => Login(),
                  '/signup': (context) => BlocProvider(
                    create: (_) => sl<RegisterCubit>(),
                    child: Signup(),
                  ),

                  '/forgetPassword': (context) => BlocProvider(
                    create: (_) => sl<ForgetPasswordCubit>(),
                    child: ForgetPassword(),
                  ),

                  '/brandProfile': (context) => BrandProfileScreen(),

                  '/home': (context) => const HomeScreen(),
                  '/mainlayout': (context) => Mainlayout(),
                  '/resetPassword': (context) {
                    final email =
                        ModalRoute.of(context)?.settings.arguments as String? ??
                        '';
                    return ResetPassword(email: email);
                  },
                  '/verify': (context) => MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (_) => sl<ConfirmEmailCubit>()),
                      BlocProvider(create: (_) => sl<VerifyResetCodeCubit>()),
                    ],
                    child: Verify(),
                  ),
                  '/sellerRegistration': (context) =>
                      const SellerRegistrationView(),
                  '/sellerRegistrationSuccess': (context) =>
                      const SellerRegistrationSuccessView(),
                  '/paymentMethods': (context) => const PaymentMethodsView(),
                  '/wishlist': (context) => const WishlistView(),
                  '/helpSupport': (context) => const HelpSupportView(),
                  '/settings': (context) => const SettingsView(),
                  '/notifications': (context) => const NotificationsView(),
                  '/orders': (context) => const OrdersView(),
                  '/sellerLayout': (context) => SellerMainLayout(),
                },
              );
            },
          );
        },
      ),
    );
  }
}
