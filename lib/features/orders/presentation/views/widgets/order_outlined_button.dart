import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderOutlinedButton extends StatelessWidget {
  final String text;
  final IconData icon;

  const OrderOutlinedButton({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFF1E293B), width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16.sp, color: const Color(0xFF1E293B)),
          SizedBox(width: 5.w),
          BasicText(
            text: text,
            fontSize: 13.sp,
            color: const Color(0xFF1E293B),
            isBold: false,
          ),
        ],
      ),
    );
  }
}
