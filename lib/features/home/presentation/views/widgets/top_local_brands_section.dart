import 'package:easy_localization/easy_localization.dart';
import 'package:brand/features/home/data/models/home_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopLocalBrandsSection extends StatelessWidget {
  final List<BrandModel> brands;
  final VoidCallback onViewAllTap;
  final Function(BrandModel brand) onBrandTap;

  const TopLocalBrandsSection({
    super.key,
    required this.brands,
    required this.onViewAllTap,
    required this.onBrandTap,
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
              'top_local_brands'.tr(),
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
                color: Theme.of(
                  context,
                ).textTheme.bodyLarge?.color, // Dark slate
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
        SizedBox(
          height: 160.h, // Container for cards
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: brands.length,
            separatorBuilder: (context, index) => SizedBox(width: 16.w),
            itemBuilder: (context, index) {
              final brand = brands[index];
              return InkWell(
                onTap: () => onBrandTap(brand),
                // borderRadius: BorderRadius.circular(16.r),
                child: SizedBox(
                  width: 85.w,
                  child: Column(
                    children: [
                      // Image and logo stack
                      Stack(
                        clipBehavior: Clip.none,
                        // alignment: Alignment.bottomCenter,
                        children: [
                          CircleAvatar(
                            radius: 40.r,
                            backgroundImage: NetworkImage(brand.logoUrl),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle, // Make it circular
                                border: Border.all(
                                  color: Theme.of(context).cardColor,
                                  width: 2.w,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        (Theme.of(
                                                  context,
                                                ).textTheme.bodyLarge?.color ??
                                                Colors.black)
                                            .withOpacity(0.1),
                                    blurRadius: 4.r,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Small Circular Logo overlapping bottom edge
                          Positioned(
                            bottom: -12.h,
                            left: 0,
                            right: 0,
                            child: Container(
                              width: 30.w,
                              height: 30.h,
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Theme.of(context).cardColor,
                                  width: 2.w,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        (Theme.of(
                                                  context,
                                                ).textTheme.bodyLarge?.color ??
                                                Colors.black)
                                            .withOpacity(0.1),
                                    blurRadius: 4.r,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),

                              child: Center(
                                child: Text(
                                  brand.name.isNotEmpty
                                      ? brand.name[0].toUpperCase()
                                      : '',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge?.color,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        brand.name,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          color:
                              Theme.of(context).textTheme.bodyLarge?.color ??
                              Colors.black,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        brand.description,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w100,
                          color: Colors.grey[700],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
