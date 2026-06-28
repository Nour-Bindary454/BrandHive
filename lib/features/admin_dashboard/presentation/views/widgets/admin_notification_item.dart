import 'package:brand/features/admin_dashboard/data/models/admin_models.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AdminNotificationItem extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;

  const AdminNotificationItem({
    super.key,
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: !notification.isRead
              ? Border.all(color: Colors.blue.withOpacity(0.2))
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  notification.title,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1E293B),
                  ),
                ),
                if (!notification.isRead)
                  const CircleAvatar(radius: 4, backgroundColor: Colors.blue),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              notification.body,
              style: TextStyle(fontSize: 12.sp, color: const Color(0xFF64748B)),
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 12.sp, color: Colors.grey),
                SizedBox(width: 4.w),
                Text(
                  _formatDate(notification.createdAt),
                  style: TextStyle(fontSize: 11.sp, color: Colors.grey),
                ),
                const Spacer(),
                Text(
                  "View Request Details",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF2D4373),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12.sp,
                  color: const Color(0xFF2D4373),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('MMM d, h:mm a').format(date);
    } catch (e) {
      return dateStr;
    }
  }
}
