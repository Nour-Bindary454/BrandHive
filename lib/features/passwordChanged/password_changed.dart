import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_button.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordChanged extends StatelessWidget {
  const PasswordChanged({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Success Icon
              Container(
                width: 80.r,
                height: 80.r,
                decoration: const BoxDecoration(
                  color: Color(0xFF2D4373), // Dark blue circle
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 40.r,
                  // weight is only supported in some icon fonts, flutter standard icons use it if material 3 is fully utilized with weight
                ),
              ),

              SizedBox(height: 90.h),

              // Title
              BasicText(
                text: 'password_changed'.tr().tr(),
                fontSize: 24,
                color: const Color(0xFF1F1F1F), // Dark text
                isBold: true,
              ),

              SizedBox(height: 15.h),

              // Subtitle
              BasicText(
                text: 'your_password_has_been_nchanged_successfully'.tr().tr(),
                fontSize: 14,
                color: Colors.grey.shade600,
                isBold: false,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 60.h),

              // Back to login Button
              Center(
                child: BasicButton(
                  text: 'back_to_login'.tr().tr(),
                  colors: const [Color(0xFF2D4373)],
                  radius: 8.r,
                  onPressed: () {
                    // Navigate to login
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/login',
                      (route) => false,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
