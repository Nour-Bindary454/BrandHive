import 'package:brand/features/admin_dashboard/data/models/admin_support_message_model.dart';
import 'package:brand/features/admin_dashboard/presentation/view_model/admin_support_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminSupportMessageCard extends StatelessWidget {
  final AdminSupportMessageModel message;

  const AdminSupportMessageCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
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
              Expanded(
                child: Text(
                  message.fullName,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1E293B),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              _buildStatusChip(message.status),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            message.email,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF64748B),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            message.message,
            style: TextStyle(
              fontSize: 13.sp,
              color: const Color(0xFF334155),
              height: 1.4,
            ),
          ),
          if (message.adminReply != null) ...[
            SizedBox(height: 12.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Reply:".tr(),
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF475569),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    message.adminReply!,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF475569),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            SizedBox(height: 12.h),
            Align(
              alignment: Alignment.centerLeft,
              child: OutlinedButton.icon(
                onPressed: () => _showReplyDialog(context),
                icon: Icon(Icons.reply, size: 16.sp),
                label: Text("Reply".tr()),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF2D4373),
                  side: const BorderSide(color: Color(0xFF2D4373)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ),
          ],
          SizedBox(height: 12.h),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              _formatDate(message.createdAt),
              style: TextStyle(
                fontSize: 10.sp,
                color: const Color(0xFF94A3B8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    final (label, color) = switch (status.toLowerCase()) {
      'resolved' => ('Resolved', Colors.green),
      'inprogress' || 'in_progress' => ('In Progress', Colors.blue),
      _ => ('Open', Colors.orange),
    };

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        label.tr(),
        style: TextStyle(
          color: color,
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _formatDate(String isoString) {
    try {
      final dateTime = DateTime.parse(isoString);
      return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
    } catch (_) {
      return isoString;
    }
  }

  void _showReplyDialog(BuildContext context) {
    final controller = TextEditingController();
    final cubit = context.read<AdminSupportCubit>();
    showDialog(
      context: context,
      builder: (dialogCtx) => BlocProvider.value(
        value: cubit,
        child: AlertDialog(
          title: Text("Reply to Support Message".tr()),
          content: TextField(
            controller: controller,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: "Enter your reply...".tr(),
              border: const OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogCtx),
              child: Text("Cancel".tr()),
            ),
            ElevatedButton(
              onPressed: () {
                final text = controller.text.trim();
                if (text.isNotEmpty) {
                  Navigator.pop(dialogCtx);
                  cubit.replyToMessage(message.id, text);
                }
              },
              child: Text("Send".tr()),
            ),
          ],
        ),
      ),
    );
  }
}
