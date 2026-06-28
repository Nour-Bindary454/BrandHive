import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:brand/features/settings/presentation/views/widgets/settings_item_container.dart';

class SettingsArrowItem extends StatelessWidget {
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final String title;
  final VoidCallback onTap;

  const SettingsArrowItem({
    super.key,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsItemContainer(
      icon: icon,
      iconBgColor: iconBgColor,
      iconColor: iconColor,
      title: title,
      onTap: onTap,
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: const Color(0xFF94A3B8),
        size: 24.sp,
      ),
    );
  }
}
