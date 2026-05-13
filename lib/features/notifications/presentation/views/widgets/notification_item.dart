import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationItem extends StatelessWidget {
  final String id;
  final String title;
  final String subtitle;
  final String timeAgo;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final bool isUnread;
  final VoidCallback? onMarkRead;
  final VoidCallback? onDelete;

  const NotificationItem({
    super.key,
    this.id = '',
    required this.title,
    required this.subtitle,
    required this.timeAgo,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    this.isUnread = false,
    this.onMarkRead,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isUnread ? const Color(0xFFF8FAFC) : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isUnread ? const Color(0xFFBAE6FD) : const Color(0xFFF1F5F9),
          width: 1.5,
        ),
        boxShadow: isUnread
            ? null
            : [
                BoxShadow(
                  color: (Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black).withOpacity(0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Stack(
        children: [
          if (isUnread)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                width: 8.w,
                height: 8.w,
                decoration: const BoxDecoration(
                  color: Color(0xFF3B82F6),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: iconBgColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(icon, color: iconColor, size: 20.sp),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BasicText(
                          text: title,
                          fontSize: 14.sp,
                          color: const Color(0xFF1E293B),
                          isBold: true,
                        ),
                        SizedBox(height: 4.h),
                        BasicText(
                          text: subtitle,
                          fontSize: 12.sp,
                          color: const Color(0xFF64748B),
                          isBold: false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              Row(
                children: [
                  BasicText(
                    text: timeAgo,
                    fontSize: 11.sp,
                    color: const Color(0xFF94A3B8),
                    isBold: false,
                  ),
                  const Spacer(),
                  if (isUnread)
                    Padding(
                      padding: EdgeInsets.only(right: 15.w),
                      child: InkWell(
                        onTap: onMarkRead,
                        child: BasicText(
                          text: "Mark read",
                          fontSize: 12.sp,
                          color: const Color(0xFF3B82F6),
                          isBold: false,
                        ),
                      ),
                    ),
                  InkWell(
                    onTap: onDelete,
                    child: BasicText(
                      text: "Delete",
                      fontSize: 12.sp,
                      color: const Color(0xFF64748B),
                      isBold: false,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
