import 'package:brand/core/services/service_locator.dart';
import 'package:brand/features/admin_dashboard/presentation/view_model/admin_notification_cubit.dart';
import 'package:brand/features/admin_dashboard/presentation/views/widgets/admin_notification_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminSendNotificationView extends StatelessWidget {
  const AdminSendNotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AdminNotificationCubit>(),
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
            'Send Notification'.tr(),
            style: TextStyle(
              color: const Color(0xFF1E293B),
              fontFamily: 'Poppins',
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: const SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: AdminNotificationForm(),
        ),
      ),
    );
  }
}
