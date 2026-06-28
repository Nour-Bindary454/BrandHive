import 'package:brand/features/settings/presentation/views/widgets/settings_helpers.dart';
import 'package:brand/features/settings/presentation/views/widgets/settings_card.dart';
import 'package:brand/features/settings/presentation/views/widgets/settings_switch_item.dart';
import 'package:brand/features/settings/presentation/viewmodels/settings_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationsSection extends StatelessWidget {
  final SettingsViewModel viewModel;
  final bool isAdmin;
  const NotificationsSection({super.key, required this.viewModel, required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsSectionTitle(title: "notifications_section".tr()),
        SettingsCard(
          children: [
            SettingsSwitchItem(
              icon: CupertinoIcons.bell,
              iconBgColor: const Color(0xFFFEF3C7),
              iconColor: const Color(0xFFD97706),
              title: "push_notifications".tr(),
              value: viewModel.pushNotifications,
              onChanged: (val) => viewModel.togglePushNotifications(val),
            ),
            if (!isAdmin) ...[
              const SettingsDivider(),
              SettingsSwitchItem(
                icon: CupertinoIcons.mail,
                iconBgColor: const Color(0xFFFFEDD5),
                iconColor: const Color(0xFFEA580C),
                title: "email_promotions".tr(),
                value: viewModel.emailPromotions,
                onChanged: (val) => viewModel.toggleEmailPromotions(val),
              ),
              const SettingsDivider(),
              SettingsSwitchItem(
                icon: CupertinoIcons.cube,
                iconBgColor: const Color(0xFFD1FAE5),
                iconColor: const Color(0xFF059669),
                title: "order_updates".tr(),
                value: viewModel.orderUpdates,
                onChanged: (val) => viewModel.toggleOrderUpdates(val),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
