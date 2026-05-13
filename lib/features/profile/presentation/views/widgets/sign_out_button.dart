import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/sharedWidgets/basic_colors.dart';
import '../../../../../core/sharedWidgets/basic_text.dart';

class SignOutButton extends StatelessWidget {
  final VoidCallback onTap;

  const SignOutButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: (Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black).withOpacity(0.15),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.logout,
              size: 20.sp,
              color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
            ),
            SizedBox(width: 8.w),
            BasicText(
              text: 'sign_out'.tr(),
              fontSize: 14.sp,
              color: const Color(0xFFFF4D4D), // Red color
              isBold: true,
            ),
          ],
        ),
      ),
    );
  }
}
