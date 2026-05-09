import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/sharedWidgets/basic_colors.dart';
import '../../../../../core/sharedWidgets/basic_text.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String imageUrl;
  final String membership;

  const ProfileHeader({
    Key? key,
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.membership,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              padding: EdgeInsets.all(4.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).cardColor,
                  width: 3.w,
                ),
                boxShadow: [
                  BoxShadow(
                    color: (Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black).withOpacity(0.05),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 45.r,
                backgroundImage: NetworkImage(imageUrl),
                backgroundColor: BasicColors.grey.withOpacity(0.2),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(4.r),
                decoration: BoxDecoration(
                  color: BasicColors.buttonColorDark,
                  shape: BoxShape.circle,
                  border: Border.all(color: Theme.of(context).cardColor, width: 2.w),
                ),
                child: Icon(
                  Icons.settings_outlined,
                  color: Theme.of(context).cardColor,
                  size: 16.sp,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        BasicText(
          text: name,
          fontSize: 20.sp,
          color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
          isBold: true,
        ),
        SizedBox(height: 4.h),
        BasicText(
          text: email,
          fontSize: 14.sp,
          color: Theme.of(context).textTheme.bodyMedium?.color ?? Colors.grey,
          isBold: false,
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: const Color(0xFFE2EAF8), // Light blue background
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: BasicText(
            text: membership,
            fontSize: 12.sp,
            color: BasicColors.buttonColorDark,
            isBold: true,
          ),
        ),
      ],
    );
  }
}
