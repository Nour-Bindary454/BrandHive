import 'package:brand/core/services/service_locator.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/features/admin_dashboard/presentation/view_model/admin_support_cubit.dart';
import 'package:brand/features/admin_dashboard/presentation/view_model/admin_support_state.dart';
import 'package:brand/features/admin_dashboard/presentation/views/widgets/admin_support_message_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminSupportMessagesView extends StatelessWidget {
  const AdminSupportMessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AdminSupportCubit>()..getSupportMessages(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, size: 18.sp, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Support Messages'.tr(),
            style: TextStyle(
              color: const Color(0xFF1E293B),
              fontFamily: 'Poppins',
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: BlocBuilder<AdminSupportCubit, AdminSupportState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.error != null) {
              return Center(
                child: BasicText(
                  text: state.error!,
                  fontSize: 13.sp,
                  color: Colors.red,
                  isBold: true,
                ),
              );
            }

            if (state.messages.isEmpty) {
              return Center(
                child: BasicText(
                  text: "No support messages found".tr(),
                  color: const Color(0xFF64748B),
                  isBold: false,
                  fontSize: 14.sp,
                ),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              itemCount: state.messages.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return AdminSupportMessageCard(message: state.messages[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
