import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProcessingActionButtons extends StatelessWidget {
  const ProcessingActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFF5384DB), width: 1.2),
      ),
      alignment: Alignment.center,
      child: BasicText(
        text: 'Mark as ready',
        fontSize: 12,
        color: const Color(0xFF5384DB),
        isBold: true,
      ),
    );
  }
}
