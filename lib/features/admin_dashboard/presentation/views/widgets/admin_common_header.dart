import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminCommonHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AdminCommonHeader({
    super.key,
    required this.title,
    this.subtitle = "BrandHive Platform Management",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 20.h,
        left: 24.w,
        right: 24.w,
        bottom: 30.h,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF2D4373),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.r),
          bottomRight: Radius.circular(30.r),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2D4373).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 26.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Outfit',
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white.withOpacity(0.7),
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
