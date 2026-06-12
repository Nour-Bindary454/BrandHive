import 'package:brand/features/settings/presentation/views/widgets/settings_helpers.dart';
import 'package:brand/features/settings/presentation/views/widgets/settings_card.dart';
import 'package:brand/features/settings/presentation/views/widgets/settings_arrow_item.dart';
import 'package:brand/features/admin_dashboard/presentation/views/deactivated_products_view.dart';
import 'package:brand/features/admin_dashboard/presentation/views/deactivated_brands_view.dart';
import 'package:brand/features/admin_dashboard/presentation/views/admin_orders_view.dart';
import 'package:brand/features/admin_dashboard/presentation/views/admin_support_messages_view.dart';
import 'package:brand/features/admin_dashboard/presentation/views/admin_send_notification_view.dart';
import 'package:brand/features/home/presentation/view_models/cubit/home_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminSection extends StatelessWidget {
  const AdminSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsSectionTitle(title: "admin_section".tr()),
        SettingsCard(
          children: [
            SettingsArrowItem(
              icon: CupertinoIcons.eye_slash,
              iconBgColor: const Color(0xFFF1F5F9),
              iconColor: const Color(0xFF475569),
              title: "deactivated_products".tr(),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => BlocProvider.value(
                      value: context.read<HomeCubit>(),
                      child: const DeactivatedProductsView(),
                    ),
                  ),
                );
              },
            ),
            const SettingsDivider(),
            SettingsArrowItem(
              icon: CupertinoIcons.slash_circle,
              iconBgColor: const Color(0xFFFEF2F2),
              iconColor: const Color(0xFFEF4444),
              title: "deactivated_brands".tr(),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => BlocProvider.value(
                      value: context.read<HomeCubit>(),
                      child: const DeactivatedBrandsView(),
                    ),
                  ),
                );
              },
            ),
            const SettingsDivider(),
            SettingsArrowItem(
              icon: CupertinoIcons.cart,
              iconBgColor: const Color(0xFFE0F2FE),
              iconColor: const Color(0xFF0284C7),
              title: "all_orders".tr(),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminOrdersView(),
                  ),
                );
              },
            ),
            const SettingsDivider(),
            SettingsArrowItem(
              icon: CupertinoIcons.chat_bubble_2,
              iconBgColor: const Color(0xFFF5F3FF),
              iconColor: const Color(0xFF8B5CF6),
              title: "Support Messages".tr(),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminSupportMessagesView(),
                  ),
                );
              },
            ),
            const SettingsDivider(),
            SettingsArrowItem(
              icon: CupertinoIcons.bell,
              iconBgColor: const Color(0xFFFEF3C7),
              iconColor: const Color(0xFFD97706),
              title: "Send Notification".tr(),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminSendNotificationView(),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
