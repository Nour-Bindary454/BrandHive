import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_button.dart';
import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/sharedWidgets/mixed_bg.dart';
import 'package:brand/core/utils/appImages/png_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MixedBg(
            lightColor: BasicColors.linearGradientSLight,
            darkColor: BasicColors.linearGradientSDark,
          ),
          Positioned(
            top: 100.h,
            right: 50.w,
            child: Image.asset(PngImages.polygon1),
          ),
          Positioned(
            top: 230.h,
            right: 170.w,
            child: Image.asset(PngImages.polygon2),
          ),
          Positioned(
            top: 150.h,
            left: -40,
            child: Image.asset(PngImages.polygon3),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 200.h),
                Image.asset(PngImages.logo2),
                SizedBox(height: 30.h),
                BasicText(
                  text: 'welcome'.tr(),
                  fontSize: 35.sp,
                  isBold: true,
                  color: Colors.white,
                ),
                SizedBox(height: 30.h),

                OutlinedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.white, width: 1.5.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    fixedSize: Size(
                      MediaQuery.of(context).size.width * 0.85,
                      44,
                    ),
                  ),
                  child: BasicText(
                    text: 'sign_in'.tr(),
                    fontSize: 17.sp,
                    isBold: false,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20.h),
                BasicButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/signup');
                  },
                  text: 'sign_up'.tr(),

                  radius: 24,
                  colors: [BasicColors.buttonColorDark],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
