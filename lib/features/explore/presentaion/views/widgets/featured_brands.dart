import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeaturedBrands extends StatelessWidget {
  FeaturedBrands({super.key});

  final List<Map<String, dynamic>> brands = [
    {'initials': 'NW', 'name': 'Nile...', 'rating': '4.9'},
    {'initials': 'CL', 'name': 'Cairo...', 'rating': '4.7'},
    {'initials': 'LB', 'name': 'Lotus...', 'rating': '4.8'},
    {'initials': 'SS', 'name': 'Siwa Salt', 'rating': '4.6'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BasicText(
              text: 'featured_brands'.tr().tr(),
              fontSize: 18,
              color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
              isBold: true,
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  BasicText(
                    text: 'all_brands'.tr().tr(),
                    fontSize: 12,
                    color: Color(0xFF2D4373), // Dark blue
                    isBold: true,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12.sp,
                    color: Color(0xFF2D4373),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 15.h),
        SizedBox(
          height: 110.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: brands.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: 15.w),
                child: Container(
                  width: 85.w,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: (Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black).withOpacity(0.04),
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: Offset(0, 2),
                      ),
                    ],
                    border: Border.all(color: Colors.grey.withOpacity(0.1)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 45.r,
                        height: 45.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFD6E2FC), // Light blue background
                        ),
                        child: Center(
                          child: Text(
                            brands[index]['initials']!,
                            style: TextStyle(
                              color: Color(0xFF2D4373), // Dark blue text
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: Text(
                          brands[index]['name']!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 12.sp),
                          SizedBox(width: 2.w),
                          Text(
                            brands[index]['rating']!,
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
