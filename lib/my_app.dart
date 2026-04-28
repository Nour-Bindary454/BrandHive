import 'package:brand/core/services/api_services.dart';
import 'package:brand/core/services/service_locator.dart';
import 'package:brand/features/forgetPassword/presentaion/views/forget_password.dart';
import 'package:brand/features/forgetPassword/presentaion/viewsModel/forget_cubit.dart';
import 'package:brand/features/home/presentation/views/home.dart';
import 'package:brand/features/login/presentation/views/login_view.dart';
import 'package:brand/features/main_layout/presentation/views/mainlayout.dart';
import 'package:brand/features/onboarding/presentation/views/onboarding.dart';
import 'package:brand/features/resetPassword/view/reset_password.dart';
import 'package:brand/features/signup/data/repository/register_repo_impl.dart';
import 'package:brand/features/signup/data/repository/register_repos.dart';
import 'package:brand/features/signup/presentation/view_model/cubit/register_cubit.dart';
import 'package:brand/features/signup/presentation/views/signup.dart';
import 'package:brand/features/splash/presentation/views/splash_veiws.dart';
import 'package:brand/features/verify/presentation/view/verify.dart';
import 'package:brand/features/verify/presentation/view_model/cubit/confirm_email_cubit.dart';
import 'package:brand/features/welcome/presentation/views/welcome.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:brand/features/cart/data/repository/cart_repository.dart';
import 'package:brand/features/cart/services/cart_service.dart';
import 'package:brand/features/cart/presentation/viewmodel/cart_view_model.dart';
import 'package:brand/features/checkout/data/data_sources/checkout_remote_data_source.dart';
import 'package:brand/features/checkout/data/repository/checkout_repository.dart';
import 'package:brand/features/checkout/presentation/viewmodels/checkout_view_model.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CartRepository>(create: (_) => CartRepository()),
        ProxyProvider<CartRepository, CartService>(
          update: (_, repo, __) => CartService(repo),
        ),
        ChangeNotifierProxyProvider<CartService, CartViewModel>(
          create: (context) => CartViewModel(context.read<CartService>()),
          update: (_, service, viewModel) =>
              viewModel ?? CartViewModel(service),
        ),
        Provider<CheckoutRemoteDataSource>(
          create: (_) => CheckoutRemoteDataSource(),
        ),
        ProxyProvider<CheckoutRemoteDataSource, CheckoutRepository>(
          update: (_, remoteDataSource, __) =>
              CheckoutRepository(remoteDataSource),
        ),
        ChangeNotifierProxyProvider<CheckoutRepository, CheckoutViewModel>(
          create: (context) =>
              CheckoutViewModel(context.read<CheckoutRepository>()),
          update: (_, repo, viewModel) => viewModel ?? CheckoutViewModel(repo),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
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
              '/home': (context) => HomeScreen(),
              '/mainlayout': (context) => Mainlayout(),
              '/resetPassword': (context) => ResetPassword(),
              '/verify': (context) => BlocProvider(
                create: (_) => sl<ConfirmEmailCubit>(),
                child: Verify(),
              ),
            },
          );
        },
      ),
    );
  }
}
