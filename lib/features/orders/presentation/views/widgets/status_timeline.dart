import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/features/checkout/data/models/status_history_model.dart';
import 'package:intl/intl.dart';

class StatusTimeline extends StatelessWidget {
  final List<StatusHistoryModel> history;

  const StatusTimeline({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    if (history.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: history.length,
      itemBuilder: (context, index) {
        final item = history[index];
        final isLast = index == history.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 16.w,
                  height: 16.w,
                  decoration: const BoxDecoration(
                    color: BasicColors.buttonColorDark,
                    shape: BoxShape.circle,
                  ),
                ),
                if (!isLast)
                  Container(
                    width: 2.w,
                    height: 50.h,
                    color: BasicColors.buttonColorDark.withOpacity(0.3),
                  ),
              ],
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BasicText(
                    text: item.status.toUpperCase(),
                    fontSize: 14.sp,
                    isBold: true,
                    color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
                  ),
                  SizedBox(height: 4.h),
                  BasicText(
                    text: DateFormat('dd MMM yyyy, hh:mm a').format(item.timestamp),
                    fontSize: 12.sp,
                    color: Colors.grey.shade600,
                    isBold: false,
                  ),
                  if (item.note != null && item.note!.isNotEmpty) ...[
                    SizedBox(height: 4.h),
                    BasicText(
                      text: item.note!,
                      fontSize: 12.sp,
                      color: Colors.grey.shade500,
                      isBold: false,
                    ),
                  ],
                  if (!isLast) SizedBox(height: 24.h),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
