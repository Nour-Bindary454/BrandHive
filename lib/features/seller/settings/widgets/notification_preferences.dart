import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/features/seller/settings/widgets/settings_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationPreferences extends StatefulWidget {
  const NotificationPreferences({super.key});

  @override
  State<NotificationPreferences> createState() => _NotificationPreferencesState();
}

class _NotificationPreferencesState extends State<NotificationPreferences> {
  bool newOrders = true;
  bool inventoryLow = true;
  bool messages = true;
  bool promotions = true;

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BasicText(
            text: 'notification_preferences'.tr(),
            fontSize: 14,
            color: const Color(0xFF1F2937),
            isBold: true,
          ),
          SizedBox(height: 15.h),
          _buildToggle(
            'New Orders',
            'Get notified when you receive a new order',
            newOrders,
            (val) => setState(() => newOrders = val),
          ),
          _buildToggle(
            'Inventory Low',
            'Alert when product stock is running low',
            inventoryLow,
            (val) => setState(() => inventoryLow = val),
          ),
          _buildToggle(
            'Messages',
            'Notifications for customer messages',
            messages,
            (val) => setState(() => messages = val),
          ),
          _buildToggle(
            'Promotions',
            'Special offers and promotional campaigns',
            promotions,
            (val) => setState(() => promotions = val),
          ),
        ],
      ),
    );
  }

  Widget _buildToggle(String title, String subtitle, bool value, ValueChanged<bool> onChanged) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BasicText(
                  text: title,
                  fontSize: 11,
                  color: const Color(0xFF1F2937),
                  isBold: true,
                ),
                SizedBox(height: 4.h),
                BasicText(
                  text: subtitle,
                  fontSize: 10,
                  color: Colors.grey.shade500,
                  isBold: false,
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: const Color(0xFF2962FF), // Vibrant blue toggle
            inactiveTrackColor: Colors.grey.shade300,
            inactiveThumbColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
