import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/backarrow.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerifyHeader extends StatelessWidget {
  final String email;
  const VerifyHeader({super.key, required this.email});

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
          text: 'please_check_your_nemail'.tr(),
          fontSize: 30,
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
            children: [
              const TextSpan(text: "We've sent a code to "),
              TextSpan(
                text: email,
                style: const TextStyle(
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
