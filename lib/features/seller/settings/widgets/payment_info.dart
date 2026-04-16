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
            text: 'Payment Information',
            fontSize: 14,
            color: const Color(0xFF1F2937),
            isBold: true,
          ),
          SizedBox(height: 15.h),
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: Colors.white,
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
                      text: 'Primary Payout Method',
                      fontSize: 10,
                      color: Colors.grey.shade500,
                      isBold: false,
                    ),
                    SizedBox(height: 8.h),
                    BasicText(
                      text: 'Banque Misr',
                      fontSize: 12,
                      color: const Color(0xFF1F2937),
                      isBold: true,
                    ),
                    SizedBox(height: 4.h),
                    BasicText(
                      text: 'Account ending in 4267',
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
                      text: 'Edit',
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
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BasicText(
                    text: 'Add Another Payment Method',
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
