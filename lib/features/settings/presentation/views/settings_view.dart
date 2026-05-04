import 'package:brand/features/settings/presentation/views/widgets/settings_body.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF8F9FA), // Off-white background
      body: SettingsBody(),
    );
  }
}
