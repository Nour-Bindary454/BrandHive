import 'package:easy_localization/easy_localization.dart';
import 'package:brand/features/home/data/models/home_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:brand/core/sharedWidgets/favorite_button.dart';

class RecommendedForYouSection extends StatelessWidget {
  final List<HomeProduct> products;
  final VoidCallback onViewMoreTap;
  final Function(String id) onProductTap;

  const RecommendedForYouSection({
    super.key,
    required this.products,
    required this.onViewMoreTap,
    required this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🔹 Title
        Row(
          children: [
            Icon(Icons.star),
            SizedBox(width: 8.w),
            Text(
              'recommended_for_you'.tr(),
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),

        // 🔹 Products List (Cards separated)
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
              child: InkWell(
                onTap: () => onProductTap(product.id),
                borderRadius: BorderRadius.circular(20.r),
                child: Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.08),
                        blurRadius: 10.r,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // 🔸 Image
                      Container(
                        width: 80.w,
                        height: 80.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          image: DecorationImage(
                            image: NetworkImage(product.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      SizedBox(width: 16.w),

                      // 🔸 Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.brandName.toUpperCase(),
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              product.name,
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w800,
                                  color: Theme.of(context).colorScheme.onSurface,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 10.h),

                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 4.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                      255,
                                      113,
                                      224,
                                      115,
                                    ).withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Text(
                                    '${product.matchPercentage}% Match',
                                    style: TextStyle(
                                        color: Colors.green,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      '${product.price.toInt()}',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w900,
                                          color: Theme.of(context).colorScheme.onSurface,
                                      ),
                                    ),
                                    SizedBox(width: 2.w),
                                    Text(
                                      'egp'.tr(),
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(width: 12.w),

                      // 🔸 Favorite Button
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Theme.of(context).dividerColor),
                        ),
                        child: FavoriteButton(
                          productId: product.id,
                          initialIsFavorite: false,
                          size: 18.sp,
                          padding: EdgeInsets.all(5.r),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),

        SizedBox(height: 12.h),

        // 🔹 View More
        Center(
          child: InkWell(
            onTap: onViewMoreTap,
            child: Text(
              'view_all'.tr(),
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
