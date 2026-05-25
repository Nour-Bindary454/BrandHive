import 'package:brand/features/admin_dashboard/data/models/admin_models.dart';
import 'package:brand/features/admin_dashboard/presentation/views/brand_request_details_screen.dart';
import 'package:brand/features/admin_dashboard/presentation/views/widgets/brand_status_tag.dart';
import 'package:brand/features/admin_dashboard/presentation/views/widgets/rejection_dialog_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BrandRequestItem extends StatefulWidget {
  final AdminBrandRequest request;
  final void Function(BrandStatus, String?) onStatusChange;

  const BrandRequestItem({
    super.key,
    required this.request,
    required this.onStatusChange,
  });

  @override
  State<BrandRequestItem> createState() => _BrandRequestItemState();
}

class _BrandRequestItemState extends State<BrandRequestItem> {
  final _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPending = widget.request.status == BrandStatus.pending;

    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BrandRequestDetailsScreen(
            request: widget.request,
            onStatusChange: widget.onStatusChange,
          ),
        ),
      ),
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.r),
        decoration: _itemDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 8.h),
            _buildSubInfo(),
            if (isPending) ...[SizedBox(height: 16.h), _buildActionButtons()],
            if (widget.request.status == BrandStatus.approved) ...[
              SizedBox(height: 16.h),
              _buildApprovedNote(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        widget.request.name,
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF1E293B),
        ),
      ),
      BrandStatusTag(status: widget.request.status),
    ],
  );

  Widget _buildSubInfo() => Row(
    children: [
      Icon(Icons.location_on, size: 14.sp, color: Colors.red[400]),
      SizedBox(width: 4.w),
      Text(
        "${widget.request.location} · ${widget.request.category} · ${widget.request.date}",
        style: TextStyle(fontSize: 12.sp, color: const Color(0xFF64748B)),
      ),
    ],
  );

  Widget _buildActionButtons() => Row(
    children: [
      Expanded(
        child: ElevatedButton.icon(
          onPressed: () => widget.onStatusChange(BrandStatus.approved, null),
          icon: Icon(Icons.check, size: 16.sp),
          label: const Text("Approve"),
          style: _actionButtonStyle(const Color(0xFF1E293B), Colors.white),
        ),
      ),
      SizedBox(width: 12.w),
      Expanded(
        child: OutlinedButton.icon(
          onPressed: () => RejectionDialogHelper.show(
            context: context,
            controller: _reasonController,
            onStatusChange: widget.onStatusChange,
          ),
          icon: Icon(Icons.close, size: 16.sp),
          label: const Text("Reject"),
          style: _outlineButtonStyle(const Color(0xFFE11D48)),
        ),
      ),
    ],
  );

  Widget _buildApprovedNote() => Row(
    children: [
      Icon(Icons.check_circle_outline, size: 16.sp, color: Colors.green),
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
  );

  BoxDecoration _itemDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20.r),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.03),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  );

  ButtonStyle _actionButtonStyle(Color bg, Color fg) =>
      ElevatedButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: fg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      );

  ButtonStyle _outlineButtonStyle(Color color) => OutlinedButton.styleFrom(
    foregroundColor: color,
    side: BorderSide(color: color),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
  );
}
