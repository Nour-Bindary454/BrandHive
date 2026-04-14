import 'package:brand/features/forgetPassword/presentaion/views/forget_password.dart';
import 'package:brand/features/home/presentation/views/home.dart';
import 'package:brand/features/login/presentation/views/login_view.dart';
import 'package:brand/features/main_layout/presentation/views/mainlayout.dart';
import 'package:brand/features/onboarding/presentation/views/onboarding.dart';
import 'package:brand/features/orderSuccess/order_success.dart';
import 'package:brand/features/signup/presentation/views/signup.dart';
import 'package:brand/features/splash/presentation/views/splash_veiws.dart';
import 'package:brand/features/welcome/presentation/views/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
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
            '/signup': (context) => Signup(),
            '/forgetPassword': (context) => ForgetPassword(),
            '/home': (context) => HomeScreen(),
            '/mainlayout': (context) => Mainlayout(),
          },
        );
      },
    );
  }
}
