import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_button.dart';
import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/sharedWidgets/basic_text_field.dart';
import 'package:brand/core/utils/appImages/png_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:brand/features/forgetPassword/presentaion/viewsModel/forget_cubit.dart';
import 'package:brand/features/forgetPassword/presentaion/viewsModel/forget_states.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
        padding: EdgeInsets.only(
          top: 80.h,
          left: 37.w,
          right: 37.w,
          bottom: 50.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: MediaQuery.of(context).size.width),
            Image.asset(PngImages.forget_password),
            BasicText(
              text: "Forget Password?",
              fontSize: 32.sp,
              color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
              isBold: true,
            ),
            SizedBox(height: 10.h),
            Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BasicText(
                    text: "Don’t worry! It happens. Please enter the email",
                    fontSize: 11.5.sp,
                    color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
                    isBold: false,
                  ),
                  BasicText(
                    text: "associated with your account.",
                    fontSize: 12.sp,
                    color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
                    isBold: false,
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.h),
            BasicTextField(
              label: 'Email',
              hint: 'Example@gmail.com',
              controller: _emailController,
              isPassword: false,
            ),
            SizedBox(height: 20.h),
            BlocConsumer<ForgetPasswordCubit, ForgetPasswordStates>(
              listener: (context, state) {
                if (state is ForgetPasswordSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                  Navigator.pushReplacementNamed(
                    context, 
                    '/verify', 
                    arguments: {
                      'email': _emailController.text,
                      'isForgetPassword': true,
                    },
                  );
                } else if (state is ForgetPasswordError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                if (state is ForgetPasswordLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return BasicButton(
                  text: 'send_code'.tr(),
                  onPressed: () {
                    if (_emailController.text.isNotEmpty) {
                      context.read<ForgetPasswordCubit>().forgetPassword(_emailController.text);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('please_enter_an_email'.tr())),
                      );
                    }
                  },
                  colors: const [BasicColors.buttonColorLight],
                  radius: 8,
                );
              },
            ),
            SizedBox(height: 90.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BasicText(
                  text: 'remember_password'.tr(),
                  fontSize: 14.sp,
                  isBold: false,
                  color: BasicColors.linearGradientDark,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: BasicText(
                    text: "Log In",
                    fontSize: 14.sp,
                    color: BasicColors.linearGradientDark,
                    isBold: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      ),
    );
  }
}
