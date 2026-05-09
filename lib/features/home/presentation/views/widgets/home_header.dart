import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/features/home/data/models/home_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeHeader extends StatelessWidget {
  final UserProfile user;
  final VoidCallback onNotificationTap;

  const HomeHeader({
    super.key,
    required this.user,
    required this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              width: 8.w,
            ),
          ),
          child: CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(user.profileImageUrl),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.greeting,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                user.name,
                style: TextStyle(
                  fontSize: 18.sp,

                  color: Theme.of(context).colorScheme.onSurface,
                  fontFamily: 'Outfit',
                ),
              ),
            ],
          ),
        ),
        Stack(
          children: [
            IconButton(
              onPressed: onNotificationTap,
              icon: Icon(Icons.notifications_none_rounded, size: 28.sp),
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
            Positioned(
              right: 12.w,
              top: 12.h,
              child: Container(
                width: 8.w,
                height: 9.h,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
