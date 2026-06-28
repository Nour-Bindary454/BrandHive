import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/features/settings/presentation/views/widgets/sections/sign_out_button.dart';
import 'package:brand/features/seller/settings/widgets/contact_info.dart';
import 'package:brand/features/seller/settings/widgets/danger_zone.dart';
import 'package:brand/features/seller/settings/widgets/legal_policies.dart';
import 'package:brand/features/seller/settings/widgets/notification_preferences.dart';
import 'package:brand/features/seller/settings/widgets/payment_info.dart';
import 'package:brand/features/seller/settings/widgets/security.dart';
import 'package:brand/features/seller/settings/widgets/store_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: BasicText(
                  text: 'store_settings'.tr(),
                  fontSize: 18,
                  color: const Color(0xFF1F2937),
                  isBold: true,
                ),
              ),
              SizedBox(height: 20.h),
              const StoreInfo(),
              const ContactInfo(),
              const PaymentInfo(),
              const NotificationPreferences(),
              const Security(),
              const LegalPolicies(),
              const DangerZone(),
              SizedBox(height: 20.h),
              const SignOutButton(),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
