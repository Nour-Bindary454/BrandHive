import 'package:brand/features/admin_dashboard/data/models/admin_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BrandStatusTag extends StatelessWidget {
  final BrandStatus status;

  const BrandStatusTag({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    String text;

    switch (status) {
      case BrandStatus.pending:
        bgColor = const Color(0xFFFFF7ED);
        textColor = const Color(0xFF9A3412);
        text = "Pending";
        break;
      case BrandStatus.approved:
        bgColor = const Color(0xFFF0FDF4);
        textColor = const Color(0xFF166534);
        text = "Approved";
        break;
      case BrandStatus.rejected:
        bgColor = const Color(0xFFFEF2F2);
        textColor = const Color(0xFF991B1B);
        text = "Rejected";
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}
