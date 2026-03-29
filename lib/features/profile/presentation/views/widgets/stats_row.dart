import 'package:brand/features/profile/data/models/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/sharedWidgets/basic_colors.dart';
import '../../../../../core/sharedWidgets/basic_text.dart';

class StatsRow extends StatelessWidget {
  final ProfileStats stats;

  const StatsRow({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: _buildStatCard(stats.orders.toString(), 'ORDERS')),
          SizedBox(width: 12.w),
          Expanded(child: _buildStatCard(stats.reviews.toString(), 'REVIEWS')),
          SizedBox(width: 12.w),
          Expanded(child: _buildStatCard(stats.points.toString(), 'POINTS')),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        color: BasicColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: BasicColors.grey.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          BasicText(
            text: value,
            fontSize: 20.sp,
            color: BasicColors.buttonColorDark,
            isBold: true,
          ),
          SizedBox(height: 4.h),
          BasicText(
            text: label,
            fontSize: 10.sp,
            color: BasicColors.grey,
            isBold: true,
          ),
        ],
      ),
    );
  }
}
