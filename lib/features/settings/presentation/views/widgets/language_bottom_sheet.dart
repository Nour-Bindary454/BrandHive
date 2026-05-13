import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/features/settings/presentation/viewmodels/settings_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageBottomSheet extends StatelessWidget {
  final SettingsViewModel viewModel;

  const LanguageBottomSheet({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
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
          _buildLangOption(context, 'English', 'en'),
          _buildLangOption(context, 'العربية', 'ar'),
          _buildLangOption(context, 'Deutsch', 'de'),
          _buildLangOption(context, 'Français', 'fr'),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildLangOption(BuildContext context, String title, String code) {
    final bool isSelected = context.locale.languageCode == code;
    return ListTile(
      title: BasicText(
        text: title,
        fontSize: 16.sp,
        isBold: isSelected,
        color: BasicColors.buttonColorLight,
      ),
      trailing: isSelected ? const Icon(Icons.check, color: Color(0xFF2D4373)) : null,
      onTap: () {
        viewModel.changeLanguage(context, code);
        Navigator.pop(context);
      },
    );
  }

  static void show(BuildContext context, SettingsViewModel viewModel) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => LanguageBottomSheet(viewModel: viewModel),
    );
  }
}
