import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:brand/features/settings/presentation/views/widgets/settings_item_container.dart';

class SettingsDropdownItem extends StatelessWidget {
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final String title;
  final String value;
  final VoidCallback? onTap;

  const SettingsDropdownItem({
    super.key,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.title,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsItemContainer(
      icon: icon,
      iconBgColor: iconBgColor,
      iconColor: iconColor,
      title: title,
      onTap: onTap,
      trailing: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark ? const Color(0xFF334155) : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            BasicText(
              text: value,
              fontSize: 13.sp,
              color: Theme.of(context).textTheme.bodyMedium?.color ?? const Color(0xFF475569),
              isBold: false,
            ),
            SizedBox(width: 4.w),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Theme.of(context).textTheme.bodyMedium?.color ?? const Color(0xFF475569),
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }
}
