import 'package:brand/core/services/cache_helper.dart';
import 'package:brand/features/brand_profile/data/models/product_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductInfoSection extends StatelessWidget {
  final Product product;
  const ProductInfoSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.brandName.isNotEmpty ? product.brandName.toUpperCase() : 'brand'.tr().toUpperCase(),
            style: TextStyle(
              fontFamily: 'Outfit',
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              letterSpacing: 1.5,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            product.name,
            style: TextStyle(
              fontFamily: 'Outfit',
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
              height: 1.2,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: 20.sp),
              SizedBox(width: 4.w),
              Text(
                product.rating.toStringAsFixed(1),
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 8.w),
              Text(
                '(120 Reviews)',
                style: TextStyle(fontSize: 14.sp, color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Text(
            'description'.tr(),
            style: TextStyle(fontFamily: 'Outfit', fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.h),
          Text(
            product.description.isNotEmpty ? product.description : 'no_description'.tr(),
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14.sp,
              height: 1.5,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}
