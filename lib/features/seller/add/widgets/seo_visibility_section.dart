import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/features/seller/add/widgets/add_product_text_field.dart';
import 'package:brand/features/seller/settings/widgets/settings_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SeoVisibilitySection extends StatefulWidget {
  const SeoVisibilitySection({super.key});

  @override
  State<SeoVisibilitySection> createState() => _SeoVisibilitySectionState();
}

class _SeoVisibilitySectionState extends State<SeoVisibilitySection> {
  bool isPublishImmediately = true;

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BasicText(
            text: 'seo_visibility'.tr(),
            fontSize: 14,
            color: const Color(0xFF0F172A),
            isBold: true,
          ),
          SizedBox(height: 15.h),
          AddProductTextField(
            label: 'Tags (Comma separated)',
            hintText: 'e_g_handmade_egyptian_kilim_rug'.tr(),
          ),
          SizedBox(height: 15.h),
          GestureDetector(
            onTap: () {
              setState(() {
                isPublishImmediately = !isPublishImmediately;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Container(
                    width: 16.r,
                    height: 16.r,
                    decoration: BoxDecoration(
                      color: isPublishImmediately ? const Color(0xFFFACC15) : Colors.white,
                      border: Border.all(color: isPublishImmediately ? Colors.transparent : Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                    child: isPublishImmediately ? Icon(Icons.check, color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black, size: 12.sp) : const SizedBox(),
                  ),
                  SizedBox(width: 10.w),
                  BasicText(
                    text: 'publish_this_product_immediately'.tr(),
                    fontSize: 11,
                    color: const Color(0xFF0F172A),
                    isBold: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
