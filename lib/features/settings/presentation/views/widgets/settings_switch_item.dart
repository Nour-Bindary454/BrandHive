import 'package:flutter/material.dart';
import 'package:brand/features/settings/presentation/views/widgets/settings_item_container.dart';

class SettingsSwitchItem extends StatelessWidget {
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingsSwitchItem({
    super.key,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsItemContainer(
      icon: icon,
      iconBgColor: iconBgColor,
      iconColor: iconColor,
      title: title,
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.white,
        activeTrackColor: const Color(0xFF2D4373),
        inactiveThumbColor: Colors.white,
        inactiveTrackColor: const Color(0xFFE2E8F0),
      ),
    );
  }
}
