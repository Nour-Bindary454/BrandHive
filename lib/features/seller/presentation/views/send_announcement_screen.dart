import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/utils/toast/toast.dart';
import 'package:brand/features/bazaar/presentation/cubit/bazaar_cubit.dart';
import 'package:brand/features/bazaar/presentation/cubit/bazaar_states.dart';
import 'package:brand/features/seller/add/widgets/add_product_text_field.dart';
import 'package:brand/features/seller/settings/widgets/settings_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendAnnouncementScreen extends StatefulWidget {
  const SendAnnouncementScreen({super.key});

  @override
  State<SendAnnouncementScreen> createState() => _SendAnnouncementScreenState();
}

class _SendAnnouncementScreenState extends State<SendAnnouncementScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<BazaarCubit>().sendAnnouncement(
          title: _titleController.text.trim(),
          message: _messageController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: const Color(0xFF0F172A), size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
        title: BasicText(
          text: 'Send Announcement'.tr(),
          fontSize: 18.sp,
          color: const Color(0xFF0F172A),
          isBold: true,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocConsumer<BazaarCubit, BazaarState>(
          listener: (context, state) {
            if (state is AnnouncementSuccess) {
              Toast.showSuccessToast(msg: state.message.tr(), context: context);
              Navigator.pop(context);
            } else if (state is AnnouncementFailure) {
              Toast.showErrorToast(msg: state.message.tr(), context: context);
            }
          },
          builder: (context, state) {
            final isLoading = state is AnnouncementLoading;

            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    /// Fields Section
                    SettingsCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BasicText(
                            text: 'New Broadcast Announcement'.tr(),
                            fontSize: 14,
                            color: const Color(0xFF0F172A),
                            isBold: true,
                          ),
                          SizedBox(height: 8.h),
                          BasicText(
                            text: 'This message will immediately appear on Customer Home feeds, Bazaar details, and Notifications.'.tr(),
                            fontSize: 11,
                            color: Colors.grey.shade500,
                          ),
                          SizedBox(height: 20.h),
                          AddProductTextField(
                            label: 'Title *',
                            hintText: 'e.g. Big Sale!',
                            controller: _titleController,
                            validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                          ),
                          SizedBox(height: 15.h),
                          AddProductTextField(
                            label: 'Message *',
                            hintText: 'e.g. 50% discount on all products...',
                            controller: _messageController,
                            maxLines: 5,
                            validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                          ),
                        ],
                      ),
                    ),

                    /// Action Buttons
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: isLoading ? null : () => Navigator.pop(context),
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                                side: const BorderSide(color: Color(0xFF2D4373), width: 1.2),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
                              ),
                              child: BasicText(
                                text: 'cancel'.tr(),
                                fontSize: 14,
                                color: const Color(0xFF2D4373),
                                isBold: true,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: isLoading ? null : _submit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2D4373),
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
                                elevation: 0,
                              ),
                              child: isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                    )
                                  : BasicText(
                                      text: 'Send Announcement'.tr(),
                                      fontSize: 14,
                                      color: Colors.white,
                                      isBold: true,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
