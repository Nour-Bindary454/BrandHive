import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsCard extends StatelessWidget {
  final Widget child;
  final Color? borderColor;

  const SettingsCard({super.key, required this.child, this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: borderColor ?? Colors.grey.shade200),
      ),
      child: child,
    );
  }
}
