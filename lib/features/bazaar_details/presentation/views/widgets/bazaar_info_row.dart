import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/sharedWidgets/basic_colors.dart';
import '../../../../../core/sharedWidgets/basic_text.dart';

class BazaarInfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String? thirdLine; // Used for multi-line location
  final Color? iconColor;

  const BazaarInfoRow({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.thirdLine,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 5.w),
        Icon(
          icon,
          size: 20.sp,
          color: iconColor ?? BasicColors.linearGradientLight, // Blue default
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BasicText(
                fontFamily: 'Outfit',
                text: title,
                fontSize: 14.sp,
                color: Theme.of(context).textTheme.bodyMedium?.color ?? Colors.grey,
                isBold: true,
              ),
              SizedBox(height: 2.h),
              BasicText(
                fontFamily: 'Outfit',
                text: subtitle,
                fontSize: 15.sp,
                color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
                isBold:
                    true, // Specifically bold for location name or phone text
              ),
              if (thirdLine != null && thirdLine!.isNotEmpty) ...[
                SizedBox(height: 2.h),
                BasicText(
                  text: thirdLine!,
                  fontSize: 12.sp,
                  color: Theme.of(context).textTheme.bodyMedium?.color ?? Colors.grey,
                  isBold: false, // Light description beneath
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
