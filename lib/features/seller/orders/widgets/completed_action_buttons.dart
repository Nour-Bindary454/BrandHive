import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompletedActionButtons extends StatelessWidget {
  const CompletedActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BasicText(
            text: 'view_details'.tr().tr(),
            fontSize: 12,
            color: Colors.grey.shade500,
            isBold: true,
          ),
          SizedBox(width: 4.w),
          Icon(Icons.arrow_forward_ios, size: 10.sp, color: Colors.grey.shade500),
        ],
      ),
    );
  }
}
