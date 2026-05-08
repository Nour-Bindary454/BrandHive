import 'package:brand/core/sharedWidgets/backarrow.dart';
import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/features/settings/presentation/views/widgets/settings_arrow_item.dart';
import 'package:brand/features/settings/presentation/views/widgets/settings_card.dart';
import 'package:brand/features/settings/presentation/views/widgets/settings_dropdown_item.dart';
import 'package:brand/features/settings/presentation/views/widgets/settings_switch_item.dart';
import 'package:brand/features/settings/presentation/viewmodels/settings_view_model.dart';
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
        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  // Header
                  Row(
                    children: [
                      const CustomBackarrow(),
                      SizedBox(width: 20.w),
                      BasicText(
                        text: "settings".tr(),
                        fontSize: 20.sp,
                        color: Theme.of(context).textTheme.bodyLarge?.color ?? const Color(0xFF1E293B),
                        isBold: true,
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),

                  // Notifications Section
                  _buildSectionTitle(context, "notifications_section".tr()),
                  SettingsCard(
                    children: [
                      SettingsSwitchItem(
                        icon: Icons.notifications_none_rounded,
                        iconBgColor: const Color(0xFFFEF3C7),
                        iconColor: const Color(0xFFD97706),
                        title: "push_notifications".tr(),
                        value: viewModel.pushNotifications,
                        onChanged: (val) =>
                            viewModel.togglePushNotifications(val),
                      ),
                      _buildDivider(context),
                      SettingsSwitchItem(
                        icon: Icons.email_outlined,
                        iconBgColor: const Color(0xFFFFEDD5),
                        iconColor: const Color(0xFFEA580C),
                        title: "email_promotions".tr(),
                        value: viewModel.emailPromotions,
                        onChanged: (val) =>
                            viewModel.toggleEmailPromotions(val),
                      ),
                      _buildDivider(context),
                      SettingsSwitchItem(
                        icon: Icons.inventory_2_outlined,
                        iconBgColor: const Color(0xFFD1FAE5),
                        iconColor: const Color(0xFF059669),
                        title: "order_updates".tr(),
                        value: viewModel.orderUpdates,
                        onChanged: (val) => viewModel.toggleOrderUpdates(val),
                      ),
                    ],
                  ),
                  SizedBox(height: 25.h),

                  // Preferences Section
                  _buildSectionTitle(context, "preferences_section".tr()),
                  SettingsCard(
                    children: [
                      SettingsDropdownItem(
                        icon: Icons.language_outlined,
                        iconBgColor: const Color(0xFFCCFBF1),
                        iconColor: const Color(0xFF0D9488),
                        title: "language".tr(),
                        value: context.locale.languageCode.toUpperCase(),
                        onTap: () {
                          _showLanguageBottomSheet(context, viewModel);
                        },
                      ),
                      _buildDivider(context),
                      SettingsDropdownItem(
                        icon: Icons.payments_outlined,
                        iconBgColor: const Color(0xFFDBEAFE),
                        iconColor: const Color(0xFF2563EB),
                        title: "currency".tr(),
                        value: "EGP",
                      ),
                      _buildDivider(context),
                      SettingsSwitchItem(
                        icon: Icons.dark_mode_outlined,
                        iconBgColor: const Color(0xFFEDE9FE),
                        iconColor: const Color(0xFF7C3AED),
                        title: "dark_mode".tr(),
                        value: viewModel.darkMode,
                        onChanged: (val) => viewModel.toggleDarkMode(val),
                      ),
                    ],
                  ),
                  SizedBox(height: 25.h),

                  // Account Section
                  _buildSectionTitle(context, "account_section".tr()),
                  SettingsCard(
                    children: [
                      SettingsArrowItem(
                        icon: Icons.person_outline,
                        iconBgColor: const Color(0xFFE0F2FE),
                        iconColor: const Color(0xFF0284C7),
                        title: "edit_profile".tr(),
                        onTap: () {},
                      ),
                      _buildDivider(context),
                      SettingsArrowItem(
                        icon: Icons.lock_outline,
                        iconBgColor: const Color(0xFFFCE7F3),
                        iconColor: const Color(0xFFDB2777),
                        title: "privacy_security".tr(),
                        onTap: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 40.h),

                  // Sign Out Button
                  Center(
                    child: TextButton.icon(
                      onPressed: () {
                        // Handle Sign Out
                      },
                      icon: const Icon(
                        Icons.logout_rounded,
                        color: Color(0xFFDC2626),
                      ),
                      label: BasicText(
                        text: "sign_out".tr(),
                        fontSize: 16.sp,
                        color: const Color(0xFFDC2626),
                        isBold: true,
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showLanguageBottomSheet(
    BuildContext context,
    SettingsViewModel viewModel,
  ) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BasicText(
                text: "language".tr(),
                fontSize: 18.sp,
                isBold: true,
                color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
              ),
              SizedBox(height: 20.h),
              _buildLangOption(context, viewModel, 'English', 'en'),
              _buildLangOption(context, viewModel, 'العربية', 'ar'),
              _buildLangOption(context, viewModel, 'Deutsch', 'de'),
              _buildLangOption(context, viewModel, 'Français', 'fr'),
              SizedBox(height: 20.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLangOption(
    BuildContext context,
    SettingsViewModel viewModel,
    String title,
    String code,
  ) {
    final bool isSelected = context.locale.languageCode == code;
    return ListTile(
      title: BasicText(
        text: title,
        fontSize: 16.sp,
        isBold: isSelected,
        color: BasicColors.buttonColorLight,
      ),
      trailing: isSelected
          ? const Icon(Icons.check, color: Color(0xFF2D4373))
          : null,
      onTap: () {
        viewModel.changeLanguage(context, code);
        Navigator.pop(context);
      },
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, bottom: 10.h),
      child: BasicText(
        text: title,
        fontSize: 12.sp,
        color: Theme.of(context).textTheme.bodyMedium?.color ?? const Color(0xFF64748B),
        isBold: true,
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Divider(
      color: Theme.of(context).dividerColor.withValues(alpha: 0.2),
      height: 1,
      thickness: 1,
      indent: 60.w,
    );
  }
}
