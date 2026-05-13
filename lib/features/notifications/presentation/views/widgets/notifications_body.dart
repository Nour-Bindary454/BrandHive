import 'package:brand/core/sharedWidgets/backarrow.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/features/notifications/presentation/viewmodel/notifications_cubit.dart';
import 'package:brand/features/notifications/presentation/viewmodel/notifications_state.dart';
import 'package:brand/features/notifications/presentation/views/widgets/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                    BlocBuilder<NotificationsCubit, NotificationsState>(
                      buildWhen: (prev, curr) =>
                          prev.unreadCount != curr.unreadCount,
                      builder: (context, state) {
                        return BasicText(
                          text: state.unreadCount > 0
                              ? "${state.unreadCount} new"
                              : "All read",
                          fontSize: 13.sp,
                          color: const Color(0xFF3B82F6),
                          isBold: true,
                        );
                      },
                    ),
                  ],
                ),
                const Spacer(),
                BlocBuilder<NotificationsCubit, NotificationsState>(
                  buildWhen: (prev, curr) =>
                      prev.unreadCount != curr.unreadCount,
                  builder: (context, state) {
                    if (state.unreadCount == 0) return const SizedBox.shrink();
                    return InkWell(
                      onTap: () {
                        context.read<NotificationsCubit>().markAllAsRead();
                      },
                      child: BasicText(
                        text: "Mark all read",
                        fontSize: 13.sp,
                        color: const Color(0xFF3B82F6),
                        isBold: true,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),

          // Divider
          const Divider(color: Color(0xFFF1F5F9), thickness: 1, height: 1),

          // List
          Expanded(
            child: BlocBuilder<NotificationsCubit, NotificationsState>(
              builder: (context, state) {
                if (state.isLoading && state.notifications.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.error != null && state.notifications.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BasicText(
                          text: state.error!,
                          fontSize: 14.sp,
                          color: const Color(0xFF64748B),
                          isBold: false,
                        ),
                        SizedBox(height: 12.h),
                        InkWell(
                          onTap: () => context
                              .read<NotificationsCubit>()
                              .fetchNotifications(forceRefresh: true),
                          child: BasicText(
                            text: "Retry",
                            fontSize: 14.sp,
                            color: const Color(0xFF3B82F6),
                            isBold: true,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                if (state.notifications.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.notifications_none_rounded,
                            size: 48.sp, color: const Color(0xFF94A3B8)),
                        SizedBox(height: 12.h),
                        BasicText(
                          text: "No notifications yet",
                          fontSize: 14.sp,
                          color: const Color(0xFF64748B),
                          isBold: false,
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.all(20.w),
                  itemCount: state.notifications.length,
                  itemBuilder: (context, index) {
                    final notification = state.notifications[index];
                    return NotificationItem(
                      id: notification.id,
                      title: notification.title,
                      subtitle: notification.body,
                      timeAgo: _formatTimeAgo(notification.createdAt),
                      icon: _getIconForType(notification.type),
                      iconBgColor: _getBgColorForType(notification.type),
                      iconColor: _getIconColorForType(notification.type),
                      isUnread: !notification.isRead,
                      onMarkRead: () {
                        context
                            .read<NotificationsCubit>()
                            .markAsRead(notification.id);
                      },
                      onDelete: () {
                        context
                            .read<NotificationsCubit>()
                            .deleteNotification(notification.id);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForType(String type) {
    switch (type.toLowerCase()) {
      case 'order':
        return Icons.inventory_2_outlined;
      case 'message':
        return Icons.chat_bubble_outline_rounded;
      case 'sale':
      case 'offer':
        return Icons.local_offer_outlined;
      case 'wishlist':
      case 'stock':
        return Icons.favorite_border_rounded;
      case 'feature':
        return Icons.bolt_rounded;
      case 'shipping':
        return Icons.local_shipping_outlined;
      default:
        return Icons.notifications_outlined;
    }
  }

  Color _getBgColorForType(String type) {
    switch (type.toLowerCase()) {
      case 'order':
        return const Color(0xFFDBEAFE);
      case 'message':
        return const Color(0xFFD1FAE5);
      case 'sale':
      case 'offer':
        return const Color(0xFFFFEDD5);
      case 'wishlist':
      case 'stock':
        return const Color(0xFFFCE7F3);
      case 'feature':
        return const Color(0xFFEDE9FE);
      case 'shipping':
        return const Color(0xFFDBEAFE);
      default:
        return const Color(0xFFE2E8F0);
    }
  }

  Color _getIconColorForType(String type) {
    switch (type.toLowerCase()) {
      case 'order':
        return const Color(0xFF2563EB);
      case 'message':
        return const Color(0xFF059669);
      case 'sale':
      case 'offer':
        return const Color(0xFFEA580C);
      case 'wishlist':
      case 'stock':
        return const Color(0xFFDB2777);
      case 'feature':
        return const Color(0xFF7C3AED);
      case 'shipping':
        return const Color(0xFF2563EB);
      default:
        return const Color(0xFF64748B);
    }
  }

  String _formatTimeAgo(String createdAt) {
    if (createdAt.isEmpty) return '';
    try {
      final date = DateTime.parse(createdAt);
      final now = DateTime.now();
      final diff = now.difference(date);

      if (diff.inMinutes < 1) return 'Just now';
      if (diff.inMinutes < 60) return '${diff.inMinutes} mins ago';
      if (diff.inHours < 24) return '${diff.inHours} hours ago';
      if (diff.inDays < 7) return '${diff.inDays} days ago';
      return '${(diff.inDays / 7).floor()} weeks ago';
    } catch (_) {
      return createdAt;
    }
  }
}
