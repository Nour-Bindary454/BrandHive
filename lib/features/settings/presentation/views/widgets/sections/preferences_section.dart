import 'package:brand/features/settings/presentation/views/widgets/settings_helpers.dart';
import 'package:brand/features/settings/presentation/views/widgets/settings_card.dart';
import 'package:brand/features/settings/presentation/views/widgets/settings_dropdown_item.dart';
import 'package:brand/features/settings/presentation/views/widgets/settings_switch_item.dart';
import 'package:brand/features/settings/presentation/views/widgets/language_bottom_sheet.dart';
import 'package:brand/features/settings/presentation/viewmodels/settings_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PreferencesSection extends StatelessWidget {
  final SettingsViewModel viewModel;
  final bool isAdmin;
  const PreferencesSection({super.key, required this.viewModel, required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsSectionTitle(title: "preferences_section".tr()),
        SettingsCard(
          children: [
            SettingsDropdownItem(
              icon: CupertinoIcons.globe,
              iconBgColor: const Color(0xFFCCFBF1),
              iconColor: const Color(0xFF0D9488),
              title: "language".tr(),
              value: context.locale.languageCode.toUpperCase(),
              onTap: () => LanguageBottomSheet.show(context, viewModel),
            ),
            if (!isAdmin) ...[
              const SettingsDivider(),
              SettingsDropdownItem(
                icon: CupertinoIcons.money_dollar,
                iconBgColor: const Color(0xFFDBEAFE),
                iconColor: const Color(0xFF2563EB),
                title: "currency".tr(),
                value: "EGP",
              ),
            ],
            const SettingsDivider(),
            SettingsSwitchItem(
              icon: CupertinoIcons.moon,
              iconBgColor: const Color(0xFFEDE9FE),
              iconColor: const Color(0xFF7C3AED),
              title: "dark_mode".tr(),
              value: viewModel.darkMode,
              onChanged: (val) => viewModel.toggleDarkMode(val),
            ),
          ],
        ),
      ],
    );
  }
}
