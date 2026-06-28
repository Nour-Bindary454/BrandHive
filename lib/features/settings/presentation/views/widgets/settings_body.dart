import 'package:brand/core/services/cache_helper.dart';
import 'package:brand/core/sharedWidgets/backarrow.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/features/admin_dashboard/presentation/views/widgets/admin_common_header.dart';
import 'package:brand/features/settings/presentation/viewmodels/settings_view_model.dart';
import 'package:brand/features/settings/presentation/views/widgets/sections/notifications_section.dart';
import 'package:brand/features/settings/presentation/views/widgets/sections/preferences_section.dart';
import 'package:brand/features/settings/presentation/views/widgets/sections/account_section.dart';
import 'package:brand/features/settings/presentation/views/widgets/sections/admin_section.dart';
import 'package:brand/features/settings/presentation/views/widgets/sections/sign_out_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsViewModel>(
      builder: (context, viewModel, child) {
        final isAdmin =
            CacheHelper.getData(key: 'role')?.toLowerCase() == 'admin';
        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, isAdmin),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 25.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NotificationsSection(
                        viewModel: viewModel,
                        isAdmin: isAdmin,
                      ),
                      SizedBox(height: 25.h),
                      PreferencesSection(
                        viewModel: viewModel,
                        isAdmin: isAdmin,
                      ),
                      SizedBox(height: 25.h),
                      AccountSection(isAdmin: isAdmin),
                      if (isAdmin) ...[
                        SizedBox(height: 25.h),
                        const AdminSection(),
                      ],
                      SizedBox(height: 40.h),
                      const SignOutButton(),
                    ],
                  ),
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, bool isAdmin) {
    if (isAdmin) {
      return AdminCommonHeader(
        title: 'settings'.tr(),
        subtitle: 'App preferences and account security',
      );
    }
    return Padding(
      padding: EdgeInsets.only(top: 50.h, left: 20.w, right: 20.w),
      child: Row(
        children: [
          const CustomBackarrow(),
          SizedBox(width: 20.w),
          BasicText(
            text: "settings".tr(),
            fontSize: 24.sp,
            color:
                Theme.of(context).textTheme.bodyLarge?.color ??
                const Color(0xFF1E293B),
            isBold: true,
          ),
        ],
      ),
    );
  }
}
