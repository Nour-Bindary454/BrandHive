import 'package:brand/core/sharedWidgets/basic_button.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/sharedWidgets/basic_text_field.dart';
import 'package:brand/core/utils/toast/toast.dart';
import 'package:brand/features/help_support/presentation/viewModel/support_cubit.dart';
import 'package:brand/features/help_support/presentation/viewModel/support_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SupportFormSection extends StatefulWidget {
  const SupportFormSection({super.key});

  @override
  State<SupportFormSection> createState() => _SupportFormSectionState();
}

class _SupportFormSectionState extends State<SupportFormSection> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _clearForm() {
    _nameController.clear();
    _emailController.clear();
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SupportCubit, SupportState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          Toast.showErrorToast(msg: state.errorMessage!, context: context);
        } else if (state.successMessage != null) {
          Toast.showSuccessToast(msg: state.successMessage!, context: context);
          _clearForm();
        }
      },
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: (Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black).withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BasicText(
              text: "Send a Message",
              fontSize: 22.sp,
              color: const Color(0xFF2D4373),
              isBold: true,
            ),
            SizedBox(height: 25.h),
            BasicTextField(
              label: "Full Name",
              hint: "Your name",
              controller: _nameController,
              isPassword: false,
            ),
            BasicTextField(
              label: "Email",
              hint: "you@example.com",
              controller: _emailController,
              isPassword: false,
            ),
            BasicText(
              text: "Message",
              fontSize: 12.sp,
              color: const Color(0xFF5B5B5C),
              isBold: true,
            ),
            SizedBox(height: 8.h),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: TextField(
                controller: _messageController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "How can we help?",
                  hintStyle: TextStyle(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                    fontFamily: 'Poppins',
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(15.w),
                ),
              ),
            ),
            SizedBox(height: 30.h),
            BlocBuilder<SupportCubit, SupportState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return BasicButton(
                  text: "Send Message",
                  colors: const [Color(0xFF2D4373)],
                  radius: 12.r,
                  onPressed: () {
                    context.read<SupportCubit>().sendSupportMessage(
                          fullName: _nameController.text,
                          email: _emailController.text,
                          message: _messageController.text,
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
