import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsSectionTitle extends StatelessWidget {
  final String title;
  const SettingsSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, bottom: 10.h),
      child: BasicText(
        text: title,
        fontSize: 12.sp,
        color: Theme.of(context).textTheme.bodyMedium?.color ?? const Color(0xFF64748B),
        isBold: true,
      ),
    );
  }
}

class SettingsDivider extends StatelessWidget {
  const SettingsDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Theme.of(context).dividerColor.withValues(alpha: 0.2),
      height: 1,
      thickness: 1,
      indent: 60.w,
    );
  }
}
