import 'package:brand/core/sharedWidgets/backarrow.dart';
import 'package:brand/core/sharedWidgets/basic_button.dart';
import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/sharedWidgets/basic_text_field.dart';
import 'package:brand/features/passwordChanged/password_changed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BasicColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),

              CustomBackarrow(),
              SizedBox(height: 45.h),
              BasicText(
                text: 'Reset Password',
                fontSize: 28,
                color: BasicColors.black,
                isBold: true,
              ),
              BasicText(
                text: 'Please type something you’ll remember',
                fontSize: 12,
                color: const Color.fromARGB(255, 28, 28, 28),
                isBold: false,
              ),
              SizedBox(height: 45.h),
              Column(
                children: [
                  SizedBox(width: double.infinity),
                  BasicTextField(
                    label: 'New Password',
                    hint: 'At least 8 characters',
                    controller: TextEditingController(),
                    isPassword: true,
                  ),
                  SizedBox(height: 10.h),
                  BasicTextField(
                    label: 'Confirm Password',
                    hint: 'repeat password',
                    controller: TextEditingController(),
                    isPassword: true,
                  ),
                  SizedBox(height: 45.h),
                  BasicButton(
                    text: 'Reset Password',
                    colors: const [Color(0xFF2D4373)],
                    radius: 12.r,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PasswordChanged(),
                        ),
                      );
                    },
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
