import 'package:brand/features/admin_dashboard/data/models/admin_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusChip extends StatelessWidget {
  final BrandStatus status;
  
  const StatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      BrandStatus.pending => ('Pending Review', Colors.orange),
      BrandStatus.approved => ('Approved', Colors.green),
      BrandStatus.rejected => ('Rejected', Colors.red),
    };
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(label,
          style: TextStyle(color: color, fontSize: 11.sp, fontWeight: FontWeight.w600)),
    );
  }
}
