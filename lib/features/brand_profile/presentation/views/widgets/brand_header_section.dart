import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:brand/features/home/data/models/home_models.dart';

import 'common_widgets.dart';

class BrandHeaderSection extends StatelessWidget {
  final BrandModel brand;

  const BrandHeaderSection({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 19.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Logo, Name, and Stats
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 80.r,
                height: 80.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  image: DecorationImage(
                    image: NetworkImage(brand.logoUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      brand.name,
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 7.h),
                    RatingWidget(rating: 4.5, reviewCount: 128),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Description
          Text(
            brand.description.isNotEmpty
                ? brand.description
                : 'Premium products with amazing quality.',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12.5.sp,
              color: Colors.grey[700],
              height: 1.6.h,
            ),
          ),
          SizedBox(height: 16.h),

          // Location & Info
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 16.sp,
                color: Colors.grey[500],
              ),
              SizedBox(width: 4.w),
              Text(
                brand.country.isNotEmpty
                    ? '${brand.country} • Member since 2024'
                    : 'Member since 2024',
                style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
