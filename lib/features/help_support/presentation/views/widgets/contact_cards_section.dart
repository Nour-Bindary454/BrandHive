import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';

class ContactCardsSection extends StatelessWidget {
  const ContactCardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildContactCard(
            context: context,
            icon: Icons.email_outlined,
            iconColor: const Color(0xFFE27B5A),
            title: "EMAIL",
            subtitle: "hello@brandhive.eg",
          ),
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: _buildContactCard(
            context: context,
            icon: Icons.phone_outlined,
            iconColor: const Color(0xFFE34848),
            title: "PHONE",
            subtitle: "+20 100 XXX",
          ),
        ),
      ],
    );
  }

  Widget _buildContactCard({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 28.sp),
          SizedBox(height: 10.h),
          BasicText(
            text: title,
            fontSize: 12.sp,
            color: const Color(0xFF6B7280),
            isBold: true,
          ),
          SizedBox(height: 5.h),
          BasicText(
            text: subtitle,
            fontSize: 13.sp,
            color: const Color(0xFF1E293B),
            isBold: true,
          ),
        ],
      ),
    );
  }
}
