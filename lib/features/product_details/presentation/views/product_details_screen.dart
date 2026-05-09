import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/features/brand_profile/data/models/product_model.dart';
import 'package:brand/core/sharedWidgets/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          // Content
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Stack(
                  children: [
                    SizedBox(
                      height: 400.h,
                      width: double.infinity,
                      child: product.image.startsWith('http')
                          ? Image.network(
                              product.image.isEmpty ? 'https://placehold.co/400x500/png' : product.image,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              product.image,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                                child: const Icon(Icons.image_not_supported, size: 50),
                              ),
                            ),
                    ),
                    // Back Button
                    Positioned(
                      top: 50.h,
                      left: 20.w,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: EdgeInsets.all(8.r),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.9),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                                blurRadius: 10.r,
                              ),
                            ],
                          ),
                          child: Icon(Icons.arrow_back_ios_new, size: 20.sp, color: Theme.of(context).iconTheme.color),
                        ),
                      ),
                    ),
                    // Favorite Button
                    Positioned(
                      top: 50.h,
                      right: 20.w,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.9),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                              blurRadius: 10.r,
                            ),
                          ],
                        ),
                        child: FavoriteButton(
                          productId: product.id,
                          initialIsFavorite: product.isFavorite,
                          size: 22.sp,
                          padding: EdgeInsets.all(8.r),
                        ),
                      ),
                    ),
                  ],
                ),

                // Details Section
                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Brand
                      Text(
                        product.brandName.isNotEmpty ? product.brandName.toUpperCase() : 'unknown_brand'.tr(),
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                          letterSpacing: 1.5,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      
                      // Product Name
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

                      // Rating & Reviews
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 20.sp),
                          SizedBox(width: 4.w),
                          Text(
                            product.rating.toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            '(120 Reviews)',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),

                      // Description
                      Text(
                        'description'.tr(),
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        product.description.isNotEmpty 
                            ? product.description 
                            : 'no_description'.tr(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14.sp,
                          height: 1.5,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                        ),
                      ),
                      SizedBox(height: 100.h), // Space for bottom bar
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Bar (Price & Add to Cart)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.05),
                    offset: const Offset(0, -4),
                    blurRadius: 16.r,
                  ),
                ],
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Price
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'total_price'.tr(),
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${product.price.toInt()} ',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                                fontSize: 24.sp,
                                fontFamily: 'Outfit',
                              ),
                            ),
                            TextSpan(
                              text: product.currency,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  // Add to Cart Button
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.shopping_bag_outlined, color: Theme.of(context).colorScheme.onPrimary, size: 20.sp),
                          SizedBox(width: 8.w),
                          Text(
                            'add_to_cart'.tr(),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Outfit',
                            ),
                          ),
                        ],
                      ),
                    ),
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
