import 'package:brand/core/sharedWidgets/backarrow.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/features/notifications/presentation/views/widgets/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationsBody extends StatelessWidget {
  const NotificationsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 10.h),
          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                const CustomBackarrow(),
                SizedBox(width: 15.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BasicText(
                      text: "Notifications",
                      fontSize: 20.sp,
                      color: const Color(0xFF1E293B),
                      isBold: true,
                    ),
                    BasicText(
                      text: "2 new",
                      fontSize: 13.sp,
                      color: const Color(0xFF3B82F6),
                      isBold: true,
                    ),
                  ],
                ),
                const Spacer(),
                InkWell(
                  onTap: () {},
                  child: BasicText(
                    text: "Mark all read",
                    fontSize: 13.sp,
                    color: const Color(0xFF3B82F6),
                    isBold: true,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),

          // Divider
          const Divider(color: Color(0xFFF1F5F9), thickness: 1, height: 1),
          
          // List
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20.w),
              children: const [
                NotificationItem(
                  title: "Order Confirmed",
                  subtitle: "Your order #EGY-8839201 has been confirmed",
                  timeAgo: "2 mins ago",
                  icon: Icons.inventory_2_outlined,
                  iconBgColor: Color(0xFFDBEAFE),
                  iconColor: Color(0xFF2563EB),
                  isUnread: true,
                ),
                NotificationItem(
                  title: "New Message",
                  subtitle: "Nile Weavers replied to your message",
                  timeAgo: "15 mins ago",
                  icon: Icons.chat_bubble_outline_rounded,
                  iconBgColor: Color(0xFFD1FAE5),
                  iconColor: Color(0xFF059669),
                  isUnread: true,
                ),
                NotificationItem(
                  title: "Flash Sale Alert!",
                  subtitle: "50% off on Handwoven Rugs - Ends in 2 hours",
                  timeAgo: "1 hour ago",
                  icon: Icons.local_offer_outlined,
                  iconBgColor: Color(0xFFFFEDD5),
                  iconColor: Color(0xFFEA580C),
                ),
                NotificationItem(
                  title: "Item Back in Stock",
                  subtitle: "The Brass Pendant Light you liked is now in stock",
                  timeAgo: "3 hours ago",
                  icon: Icons.favorite_border_rounded,
                  iconBgColor: Color(0xFFFCE7F3),
                  iconColor: Color(0xFFDB2777),
                ),
                NotificationItem(
                  title: "New Feature Available",
                  subtitle: "Check out our new Seller Analytics dashboard",
                  timeAgo: "Yesterday",
                  icon: Icons.bolt_rounded,
                  iconBgColor: Color(0xFFEDE9FE),
                  iconColor: Color(0xFF7C3AED),
                ),
                NotificationItem(
                  title: "Shipped",
                  subtitle: "Your order is on the way. Track your delivery",
                  timeAgo: "2 days ago",
                  icon: Icons.local_shipping_outlined,
                  iconBgColor: Color(0xFFDBEAFE),
                  iconColor: Color(0xFF2563EB),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
