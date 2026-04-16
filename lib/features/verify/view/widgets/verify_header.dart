import 'package:brand/core/sharedWidgets/backarrow.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerifyHeader extends StatelessWidget {
  const VerifyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Back Button
        CustomBackarrow(),
        SizedBox(height: 30.h),

        // Title
        BasicText(
          text: 'Please check your\nemail',
          fontSize: 28,
          color: const Color(0xFF333333),
          isBold: true,
        ),
        SizedBox(height: 15.h),

        // Subtitle
        RichText(
          text: TextSpan(
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 13.sp,
              fontFamily: 'Poppins',
            ),
            children: const [
              TextSpan(text: "We've sent a code to "),
              TextSpan(
                text: 'helloworld@gmail.com',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
