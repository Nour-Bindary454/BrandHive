import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/utils/appImages/png_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OverviewHeader extends StatelessWidget {
  const OverviewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w, bottom: 25.h),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.r),
          bottomRight: Radius.circular(24.r),
        ),
        boxShadow: [
          BoxShadow(
            color: (Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black).withOpacity(0.01),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row (Welcome, Avatar, Logout)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BasicText(
                    text: 'welcome_back'.tr().tr(),
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    isBold: false,
                  ),
                  SizedBox(height: 4.h),
                  BasicText(
                    text: 'nile_weavers'.tr().tr(),
                    fontSize: 22,
                    color: const Color(0xFF0F172A), // Deep blue/black
                    isBold: true,
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 44.r,
                    height: 44.r,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6F0FC),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: BasicText(
                        text: 'nw'.tr().tr(),
                        fontSize: 14,
                        color: const Color(0xFF4C79BD),
                        isBold: true,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Container(
                    width: 44.r,
                    height: 44.r,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Center(
                      child: ImageIcon(AssetImage(PngImages.logout), color: Colors.grey.shade400, size: 20.sp),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 25.h),
          
          // Cards Row
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Primary Card (Revenue)
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: const Color(0xFF5384DB), // Vibrant Blue
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(6.r),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: ImageIcon(AssetImage(PngImages.dollar), color: Colors.white, size: 18.sp),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Row(
                                children: [
                                  BasicText(
                                    text: '12'.tr().tr(),
                                    fontSize: 11,
                                    color: Colors.white,
                                    isBold: true,
                                  ),
                                  SizedBox(width: 2.w),
                                  Icon(Icons.arrow_outward, color: Colors.white, size: 10.sp),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25.h), // spacer in case spaceBetween doesn't push enough if constrained perfectly
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BasicText(
                              text: 'total_revenue'.tr().tr(),
                              fontSize: 13,
                              color: Colors.white,
                              isBold: true,
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                BasicText(
                                  text: '45_200'.tr().tr(),
                                  fontSize: 24,
                                  color: Colors.white,
                                  isBold: true,
                                ),
                                SizedBox(width: 6.w),
                                BasicText(
                                  text: 'egp'.tr().tr(),
                                  fontSize: 13,
                                  color: Colors.white.withOpacity(0.9),
                                  isBold: true,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                
                // Secondary Card (Active Orders)
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(
                          color: (Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black).withOpacity(0.01),
                          blurRadius: 4,
                        )
                      ]
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ImageIcon(
                          AssetImage(PngImages.orders),
                          color: const Color(0xFFD0D5DD),
                          size: 24.sp,
                        ),
                        SizedBox(height: 25.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BasicText(
                              text: 'active_orders'.tr().tr(),
                              fontSize: 13,
                              color: const Color(0xFF475467),
                              isBold: true,
                            ),
                            SizedBox(height: 4.h),
                            BasicText(
                              text: '12'.tr().tr(),
                              fontSize: 24,
                              color: const Color(0xFF0F172A),
                              isBold: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
