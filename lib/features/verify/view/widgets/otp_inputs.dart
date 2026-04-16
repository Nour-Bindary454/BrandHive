import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpInputs extends StatelessWidget {
  final String otpCode;

  const OtpInputs({super.key, required this.otpCode});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(4, (index) {
        return Container(
          width: 70.w,
          height: 70.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: Colors.grey.shade300,
              width: 1,
            ),
          ),
          child: Center(
            child: BasicText(
              text: index < otpCode.length ? otpCode[index] : '',
              fontSize: 28,
              color: const Color(0xFF333333),
              isBold: false,
            ),
          ),
        );
      }),
    );
  }
}
