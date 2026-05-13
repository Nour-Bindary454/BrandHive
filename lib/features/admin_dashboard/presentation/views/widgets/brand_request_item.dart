import 'package:brand/features/admin_dashboard/data/models/admin_models.dart';
import 'package:brand/features/admin_dashboard/presentation/views/widgets/brand_status_tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BrandRequestItem extends StatelessWidget {
  final AdminBrandRequest request;
  final Function(BrandStatus) onStatusChange;

  const BrandRequestItem({
    super.key,
    required this.request,
    required this.onStatusChange,
  });

  @override
  Widget build(BuildContext context) {
    bool isPending = request.status == BrandStatus.pending;
    bool isApproved = request.status == BrandStatus.approved;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                request.name,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1E293B),
                ),
              ),
              BrandStatusTag(status: request.status),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(Icons.location_on, size: 14.sp, color: Colors.red[400]),
              SizedBox(width: 4.w),
              Text(
                "${request.location} · ${request.category} · ${request.date}",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          if (isPending)
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => onStatusChange(BrandStatus.approved),
                    icon: Icon(Icons.check, size: 16.sp),
                    label: const Text("Approve"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E293B),
                      foregroundColor: Colors.white,
                      shape: _roundedRectangle(context),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => onStatusChange(BrandStatus.rejected),
                    icon: Icon(Icons.close, size: 16.sp),
                    label: const Text("Reject"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFE11D48),
                      side: const BorderSide(color: Color(0xFFE11D48)),
                      shape: _roundedRectangle(context),
                    ),
                  ),
                ),
              ],
            )
          else if (isApproved)
            Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  size: 16.sp,
                  color: Colors.green,
                ),
                SizedBox(width: 8.w),
                Text(
                  "Approved and active",
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.green[700],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  OutlinedBorder _roundedRectangle(BuildContext context) {
    return RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r));
  }
}
