import 'package:brand/features/brand_profile/data/models/product_model.dart';
import 'package:brand/core/utils/appImages/png_images.dart';
import 'package:brand/features/brand_profile/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy wishlist products
    final List<Product> wishlistProducts = List.generate(
      4,
      (index) => Product(
        brandName: 'Brand Name',
        id: 'p$index',
        brandId: '1',
        name: index % 2 == 0 ? 'Single Hanging Chair' : 'Classic Glass Vase',
        image: index % 2 == 0 ? PngImages.fashion : PngImages.homeDecor,
        rating: 4.8,
        price: index % 2 == 0 ? 600.0 : 450.0,
        currency: 'EGP',
        isFavorite: true,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 10.h,
              bottom: 20.h,
              left: 20.w,
              right: 20.w,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF2D4373),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24.r),
                bottomRight: Radius.circular(24.r),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ),
                    ),
                    const SizedBox(width: 40), // Balance the row
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  'My Wishlist',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'saved item',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14.sp,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${wishlistProducts.length} item saved',
                        style: TextStyle(
                          color: const Color(0xFF5B5B5C),
                          fontSize: 14.sp,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Text(
                        'Clear All',
                        style: TextStyle(
                          color: const Color(
                            0xFFC85B33,
                          ), // Orangeish-red from image
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                      ), // Extra padding to make items smaller
                      child: GridView.builder(
                        padding: EdgeInsets.only(bottom: 20.h),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.65, // Fixes the overflow
                          crossAxisSpacing: 16.w,
                          mainAxisSpacing: 16.h,
                        ),
                        itemCount: wishlistProducts.length,
                        itemBuilder: (context, index) {
                          return ProductCard(
                            product: wishlistProducts[index],
                            onFavoritePressed: () {},
                            onAddToCartPressed: () {},
                          );
                        },
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
