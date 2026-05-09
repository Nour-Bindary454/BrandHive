import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/features/home/data/models/home_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BazaarsEventsSection extends StatelessWidget {
  final List<EventModel> events;
  final VoidCallback onViewAllTap;

  const BazaarsEventsSection({
    super.key,
    required this.events,
    required this.onViewAllTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'bazaars_events'.tr(),
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 20.sp,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
                color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
              ),
            ),
            TextButton(
              onPressed: onViewAllTap,
              child: Text(
                'view_all'.tr(),
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A78B8),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: events.length,
          separatorBuilder: (context, index) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            final event = events[index];
            return Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark 
                    ? const Color(0xFF1E293B) 
                    : const Color.fromARGB(255, 212, 228, 254),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 15.sp,
                        color: BasicColors.buttonColorLight,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        event.date,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.sp,

                          fontWeight: FontWeight.bold,
                          color: BasicColors.buttonColorLight,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    event.title,
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    event.location,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
