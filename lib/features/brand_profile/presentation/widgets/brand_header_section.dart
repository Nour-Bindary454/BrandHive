import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/brand_model.dart';
import 'common_widgets.dart';

class BrandHeaderSection extends StatelessWidget {
  final Brand brand;
  final VoidCallback onFollowPressed;

  const BrandHeaderSection({
    super.key,
    required this.brand,
    required this.onFollowPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Transform.translate(
        offset: Offset(0, -20), // Slight overlap with app bar if needed
        child: Column(
          children: [
            // Overlapping Logo
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 80.w,
                    height: 80.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10.r,
                          offset: Offset(0, 4),
                        ),
                      ],
                      image: DecorationImage(
                        image: AssetImage(brand.logo),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: FollowButton(
                      isFollowed: brand.isFollowed,
                      onPressed: onFollowPressed,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            // Brand Info
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    brand.name,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      RatingWidget(
                        rating: brand.rating,
                        reviewCount: brand.reviewCount,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.w),
                        width: 1.w,
                        height: 12.h,
                        color: Colors.grey[300],
                      ),
                      Text(
                        'Accessories',
                        style: TextStyle(color: Colors.grey, fontSize: 13.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    brand.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.grey[700],
                      height: 1.4.h,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 14.sp,
                        color: Colors.grey[600],
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '${brand.location} • Member since ${brand.memberSince}',
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            Divider(height: 1.h, color: Color(0xFFEEEEEE)),
            SizedBox(height: 24.h),
            // Collection Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Text(
                    'Collection',
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    '(5)',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
