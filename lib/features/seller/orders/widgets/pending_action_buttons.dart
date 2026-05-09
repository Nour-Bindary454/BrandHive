import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PendingActionButtons extends StatelessWidget {
  const PendingActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Colors.red.shade400),
            ),
            alignment: Alignment.center,
            child: BasicText(
              text: 'decline'.tr().tr(),
              fontSize: 12,
              color: Colors.red.shade400,
              isBold: true,
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1C64F2), // Vibrant blue
              borderRadius: BorderRadius.circular(8.r),
            ),
            alignment: Alignment.center,
            child: BasicText(
              text: 'accept_order'.tr().tr(),
              fontSize: 12,
              color: Colors.white,
              isBold: true,
            ),
          ),
        ),
      ],
    );
  }
}
