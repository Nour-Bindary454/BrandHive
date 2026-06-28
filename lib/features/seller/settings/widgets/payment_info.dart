import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/features/seller/settings/widgets/settings_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentInfo extends StatelessWidget {
  const PaymentInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BasicText(
            text: 'payment_information'.tr(),
            fontSize: 14,
            color: const Color(0xFF1F2937),
            isBold: true,
          ),
          SizedBox(height: 15.h),
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BasicText(
                      text: 'primary_payout_method'.tr(),
                      fontSize: 10,
                      color: Colors.grey.shade500,
                      isBold: false,
                    ),
                    SizedBox(height: 8.h),
                    BasicText(
                      text: 'banque_misr'.tr(),
                      fontSize: 12,
                      color: const Color(0xFF1F2937),
                      isBold: true,
                    ),
                    SizedBox(height: 4.h),
                    BasicText(
                      text: 'account_ending_in_4267'.tr(),
                      fontSize: 10,
                      color: Colors.grey.shade500,
                      isBold: false,
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: BasicText(
                      text: 'edit'.tr(),
                      fontSize: 11,
                      color: const Color(0xFF4C79BD), // blue
                      isBold: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BasicText(
                    text: 'add_another_payment_method'.tr(),
                    fontSize: 11,
                    color: const Color(0xFF1F2937),
                    isBold: true,
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.grey.shade600,
                    size: 16.sp,
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
