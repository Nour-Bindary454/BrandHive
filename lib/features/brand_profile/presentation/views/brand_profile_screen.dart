import 'package:brand/features/brand_profile/data/models/product_model.dart';
import 'package:brand/features/cart/presentation/cart_screen.dart';
import 'package:brand/features/home/data/models/home_models.dart';
import 'package:brand/features/seller/add/widgets/product_details_section.dart';
import 'package:brand/features/seller/products/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/brand_header_section.dart';
import 'widgets/product_card.dart';

class BrandProfileScreen extends StatelessWidget {
  const BrandProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brand = ModalRoute.of(context)!.settings.arguments as BrandModel;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cover Image + Header Overlap
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Cover Image
                    SizedBox(
                      width: double.infinity,
                      height: 250.h,
                      child: Transform.scale(
                        scale: 1.35,
                        child: Image.network(brand.logoUrl, fit: BoxFit.cover),
                      ),
                    ),

                    // Brand Header
                    Positioned(
                      bottom: -130.h,
                      left: 0,
                      right: 0,
                      child: BrandHeaderSection(brand: brand),
                    ),
                  ],
                ),

                SizedBox(height: 150.h),
                // Collection Title
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      Text(
                        'Collection',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        '(12)',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 12.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.59,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                    itemCount: 6,
                    itemBuilder: (context, index) => const ProductCard(),
                  ),
                ),
                SizedBox(height: 32.h),
              ],
            ),
          ),

          // Pinned Back Button
          Positioned(
            top: MediaQuery.of(context).padding.top + 8.h,
            left: 16.w,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
              style: IconButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.8),
                shape: const CircleBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
