import 'package:brand/core/sharedWidgets/basic_colors.dart';
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
              'Top Local Brands',
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1E293B), // Dark slate
              ),
            ),
            TextButton(
              onPressed: onViewAllTap,
              child: Text(
                'View All',
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
          height: 130.h, // Container for cards
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: brands.length,
            separatorBuilder: (context, index) => SizedBox(width: 16.w),
            itemBuilder: (context, index) {
              final brand = brands[index];
              return InkWell(
                onTap: () => onBrandTap(brand),
                // borderRadius: BorderRadius.circular(16.r),
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
                                color: Colors.white,
                                width: 2.w,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
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
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 2.w,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4.r,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),

                            child: Center(
                              child: Text(
                                brand.name.isNotEmpty ? brand.name[0].toUpperCase() : '',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold,
                                  color: BasicColors.black,
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
                        color: Colors.black87,
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
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
