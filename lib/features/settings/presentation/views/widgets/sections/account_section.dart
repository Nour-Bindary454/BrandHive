import 'package:brand/core/services/cache_helper.dart';
import 'package:brand/features/settings/presentation/views/widgets/settings_helpers.dart';
import 'package:brand/features/settings/presentation/views/widgets/settings_card.dart';
import 'package:brand/features/settings/presentation/views/widgets/settings_arrow_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountSection extends StatelessWidget {
  final bool isAdmin;
  const AccountSection({super.key, required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsSectionTitle(title: "account_section".tr()),
        SettingsCard(
          children: [
            if (!isAdmin) ...[
              SettingsArrowItem(
                icon: CupertinoIcons.person,
                iconBgColor: const Color(0xFFE0F2FE),
                iconColor: const Color(0xFF0284C7),
                title: "edit_profile".tr(),
                onTap: () {},
              ),
              const SettingsDivider(),
            ],
            SettingsArrowItem(
              icon: CupertinoIcons.lock,
              iconBgColor: const Color(0xFFFCE7F3),
              iconColor: const Color(0xFFDB2777),
              title: "change_password".tr(),
              onTap: () {
                final email = CacheHelper.getData(key: 'email') ?? '';
                Navigator.pushNamed(context, '/resetPassword', arguments: email);
              },
            ),
          ],
        ),
      ],
    );
  }
}
