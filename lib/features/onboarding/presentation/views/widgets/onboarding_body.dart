import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:brand/core/sharedWidgets/basic_text.dart'; // تأكدي من المسارات بتاعتك

class OnboardingBody extends StatelessWidget {
  final String image, t1, t2, s1, s2;

  const OnboardingBody({
    super.key,
    required this.image,
    required this.t1,
    required this.t2,
    required this.s1,
    required this.s2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 80.h, left: 20.w, right: 20.w),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(image, height: 280.h, fit: BoxFit.contain),
            SizedBox(height: 30.h),
            BasicText(
              text: t1,
              fontSize: 24.sp,
              isBold: true,
              color: Colors.white,
            ),
            BasicText(
              text: t2,
              fontSize: 24.sp,
              isBold: true,
              color: Colors.white,
            ),
            SizedBox(height: 20.h),
            BasicText(
              text: s1,
              fontSize: 20.sp,
              isBold: false,
              color: Colors.white,
            ),
            BasicText(
              text: s2,
              fontSize: 20.sp,
              isBold: false,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
