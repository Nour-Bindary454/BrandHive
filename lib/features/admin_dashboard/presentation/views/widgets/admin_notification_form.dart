import 'package:brand/core/sharedWidgets/basic_button.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/sharedWidgets/basic_text_field.dart';
import 'package:brand/core/utils/toast/toast.dart';
import 'package:brand/features/admin_dashboard/presentation/view_model/admin_notification_cubit.dart';
import 'package:brand/features/admin_dashboard/presentation/view_model/admin_notification_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminNotificationForm extends StatefulWidget {
  const AdminNotificationForm({super.key});

  @override
  State<AdminNotificationForm> createState() => _AdminNotificationFormState();
}

class _AdminNotificationFormState extends State<AdminNotificationForm> {
  final _userIdController = TextEditingController();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final _typeController = TextEditingController(text: 'general');
  final _orderIdController = TextEditingController();

  @override
  void dispose() {
    _userIdController.dispose();
    _titleController.dispose();
    _bodyController.dispose();
    _typeController.dispose();
    _orderIdController.dispose();
    super.dispose();
  }

  void _clearForm() {
    _userIdController.clear();
    _titleController.clear();
    _bodyController.clear();
    _typeController.text = 'general';
    _orderIdController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminNotificationCubit, AdminNotificationState>(
      listener: (context, state) {
        if (state.error != null) {
          Toast.showErrorToast(msg: state.error!, context: context);
        } else if (state.successMessage != null) {
          Toast.showSuccessToast(msg: state.successMessage!, context: context);
          _clearForm();
        }
      },
      child: Container(
        padding: EdgeInsets.all(20.w),
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
            BasicTextField(label: "User ID".tr(), hint: "Enter user ID".tr(), controller: _userIdController, isPassword: false),
            BasicTextField(label: "Notification Title".tr(), hint: "Enter notification title".tr(), controller: _titleController, isPassword: false),
            BasicTextField(label: "Notification Type".tr(), hint: "e.g., general, order_placed".tr(), controller: _typeController, isPassword: false),
            BasicTextField(label: "Order ID (Optional)".tr(), hint: "e.g., 12345".tr(), controller: _orderIdController, isPassword: false),
            BasicText(text: "Notification Body".tr(), fontSize: 12.sp, color: const Color(0xFF5B5B5C), isBold: true),
            SizedBox(height: 8.h),
            Container(
              decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(12.r)),
              child: TextField(
                controller: _bodyController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Enter notification message...".tr(),
                  hintStyle: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp, fontFamily: 'Poppins'),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(15.w),
                ),
              ),
            ),
            SizedBox(height: 30.h),
            BlocBuilder<AdminNotificationCubit, AdminNotificationState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return BasicButton(
                  text: "Send Notification".tr(),
                  colors: const [Color(0xFF2D4373)],
                  radius: 12.r,
                  onPressed: () {
                    context.read<AdminNotificationCubit>().sendNotification(
                          userId: _userIdController.text,
                          title: _titleController.text,
                          body: _bodyController.text,
                          type: _typeController.text,
                          orderId: _orderIdController.text,
                        );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
