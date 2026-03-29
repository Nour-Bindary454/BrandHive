import 'package:brand/core/sharedWidgets/basic_button.dart';
import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/sharedWidgets/basic_text_field.dart';
import 'package:brand/core/sharedWidgets/shared_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return SharedStack(
      t1: 'Create Account To',
      t2: 'Get Started',
      widget: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.width * 0.085,
        ),
        child: Column(
          children: [
            BasicTextField(
              label: 'Full Name',
              hint: 'Enter your full name',
              controller: TextEditingController(),
              isPassword: false,
            ),
            BasicTextField(
              label: 'Email',
              hint: 'Example@gmail.com',
              controller: TextEditingController(),
              isPassword: false,
            ),
            BasicTextField(
              label: 'Password',
              hint: 'At least 8 character',
              controller: TextEditingController(),
              isPassword: true,
            ),
            BasicTextField(
              label: 'Confirm Password',
              hint: 'Re-enter your password',
              controller: TextEditingController(),
              isPassword: true,
            ),
            SizedBox(height: 20.h),
            BasicButton(
              onPressed: () {},
              text: "Create Account",
              colors: [
                BasicColors.linearGradientSLight,
                BasicColors.linearGradientSDark,
              ],
              radius: 7.65,
            ),
            SizedBox(height: 40.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BasicText(
                  text: 'Already have an account?',
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
