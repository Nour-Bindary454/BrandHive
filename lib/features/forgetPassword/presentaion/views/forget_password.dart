import 'package:brand/core/sharedWidgets/basic_button.dart';
import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/sharedWidgets/basic_text_field.dart';
import 'package:brand/core/utils/appImages/png_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
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
              color: Colors.black,
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
                    color: Colors.black,
                    isBold: false,
                  ),
                  BasicText(
                    text: "associated with your account.",
                    fontSize: 12.sp,
                    color: Colors.black,
                    isBold: false,
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.h),
            BasicTextField(
              label: 'Email',
              hint: 'Example@gmail.com',
              controller: TextEditingController(),
              isPassword: false,
            ),
            SizedBox(height: 20.h),
            BasicButton(
              text: 'Send Code',
              onPressed: () {},
              colors: [BasicColors.buttonColorLight],
              radius: 8,
            ),
            SizedBox(height: 90.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BasicText(
                  text: 'Remember password?',
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
    );
  }
}
