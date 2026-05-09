import 'package:brand/features/profile/data/models/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/sharedWidgets/basic_colors.dart';
import '../../../../../core/sharedWidgets/basic_text.dart';

class MenuItemTile extends StatelessWidget {
  final MenuItemModel item;
  final VoidCallback onTap;
  final bool isLast;

  const MenuItemTile({
    super.key,
    required this.item,
    required this.onTap,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: Row(
          children: [
            Icon(
              item.icon,
              size: 24.sp,
              color: (Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black).withOpacity(0.8),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: BasicText(
                text: item.title,
                fontSize: 14.sp,
                color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
                isBold: true,
              ),
            ),
            if (item.badgeText != null)
              Container(
                margin: EdgeInsets.only(right: 8.w),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: item.isBadgeRed
                      ? const Color(0xFFFFE5E5)
                      : const Color(0xFFE2EAF8),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: BasicText(
                  text: item.badgeText!,
                  fontSize: 10.sp,
                  color: item.isBadgeRed
                      ? const Color(0xFFFF4D4D)
                      : BasicColors.buttonColorDark,
                  isBold: true,
                ),
              ),
            Icon(Icons.chevron_right, size: 20.sp, color: Theme.of(context).textTheme.bodyMedium?.color),
          ],
        ),
      ),
    );
  }
}
