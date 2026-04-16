import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProTipCard extends StatelessWidget {
  const ProTipCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BasicText(
            text: 'Pro Tip',
            fontSize: 13,
            color: const Color(0xFF0F172A),
            isBold: true,
          ),
          SizedBox(height: 8.h),
          BasicText(
            text: 'Adding high-quality photos increases sales by 40%.\nUpdate your product gallery today.',
            fontSize: 11,
            color: Colors.grey.shade600,
            isBold: false,
          ),
        ],
      ),
    );
  }
}
