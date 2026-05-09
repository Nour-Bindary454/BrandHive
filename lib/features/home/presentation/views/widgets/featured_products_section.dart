import 'package:easy_localization/easy_localization.dart';
import 'package:brand/features/home/data/models/home_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:brand/core/sharedWidgets/favorite_button.dart';

class FeaturedProductsSection extends StatelessWidget {
  final List<HomeProduct> products;
  final VoidCallback onViewAllTap;
  final Function(String id) onProductTap;
  final Function(String id) onAddToCartTap;
  final Function(String id) onFavoriteTap;

  const FeaturedProductsSection({
    super.key,
    required this.products,
    required this.onViewAllTap,
    required this.onProductTap,
    required this.onAddToCartTap,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'featured_products'.tr(),
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
                color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
              ),
            ),
            TextButton(
              onPressed: onViewAllTap,
              child: Text(
                'view_all'.tr(),
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A78B8),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        // Staggered Grid equivalent using Wrap or GridView
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.65, // Adjust for image + text height
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return InkWell(
              onTap: () => onProductTap(product.id),
              borderRadius: BorderRadius.circular(20.r),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.05),
                      blurRadius: 10.r,
                      offset: Offset(0, 4),
                    ),
                  ],
                  border: Border.all(color: Colors.grey.shade100),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Image
                    Expanded(
                      flex: 6,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.r),
                                topRight: Radius.circular(20.r),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                  product.imageUrl.isEmpty 
                                      ? 'https://placehold.co/300x300/png' 
                                      : product.imageUrl
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8.h,
                            right: 8.w,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.9),
                                shape: BoxShape.circle,
                              ),
                              child: FavoriteButton(
                                productId: product.id,
                                initialIsFavorite: false,
                                size: 18.sp,
                                padding: EdgeInsets.all(6.r),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Content Details
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.all(12.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  product.brandName.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w800,
                                    color: const Color.fromARGB(
                                      255,
                                      88,
                                      123,
                                      160,
                                    ),
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                      size: 10.sp,
                                    ),
                                    SizedBox(width: 2.w),
                                    Text(
                                      product.rating.toString(),
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              product.name,
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w800,
                                color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
                                height: 1.2.h,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      '${product.price.toInt()}',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 2.w),
                                    Text(
                                      'egp'.tr(),
                                      style: TextStyle(
                                        fontSize: 8.sp,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () => onAddToCartTap(product.id),
                                  child: Container(
                                    padding: EdgeInsets.all(4.r),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF2C5A9C), // Dark blue
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      size: 16.sp,
                                      color: Colors.white,
                                    ),
                                  ),
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
            );
          },
        ),
      ],
    );
  }
}
