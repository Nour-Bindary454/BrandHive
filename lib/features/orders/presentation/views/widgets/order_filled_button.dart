import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderFilledButton extends StatelessWidget {
  final String text;

  const OrderFilledButton({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFF2D4373),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: BasicText(
        text: text,
        fontSize: 13.sp,
        color: Colors.white,
        isBold: false,
      ),
    );
  }
}
