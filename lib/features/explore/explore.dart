import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/sharedWidgets/cus_search_bar.dart';
import 'package:brand/core/utils/appImages/png_images.dart';
import 'package:brand/features/brand_profile/data/models/product_model.dart';
import 'package:brand/features/brand_profile/presentation/views/widgets/product_card.dart';
import 'package:brand/features/explore/widgets/browse_all_cat.dart';
import 'package:brand/features/explore/widgets/category_selector.dart';
import 'package:brand/features/explore/widgets/collections_container.dart';
import 'package:brand/features/explore/widgets/filter_bottom_sheet.dart';
import 'package:brand/features/explore/widgets/subcategory_tabs.dart';
import 'package:brand/features/explore/widgets/featured_brands.dart';
import 'package:brand/features/explore/widgets/trending_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Explore extends StatelessWidget {
  Explore({super.key});

  final List<Product> _products = List.generate(
    10,
    (index) => Product(
      brandName: String.fromCharCode(65 + index % 3),
      id: 'p$index',
      brandId: '1',
      name: index % 2 == 0 ? 'Classic Tote Bag' : 'Leather Wallet',
      image: index % 3 == 0
          ? PngImages.homeDecor
          : (index % 2 == 0 ? PngImages.accessories : PngImages.fashion),
      rating: 4.8,
      price: 900.0 + (index * 50),
      currency: 'EGP',
      isFavorite: false,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BasicColors.white,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 16.h),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BasicText(
                        text: 'Explore',
                        fontSize: 24,
                        color: BasicColors.black,
                        isBold: true,
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 0.8.sw,
                            child: CusSearchBar(
                              hintText: 'Search products, brands...',
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) => const FilterBottomSheet(),
                              );
                            },
                            child: Container(
                              height: 45.h,
                              width: 0.13.sw,
                              decoration: BoxDecoration(
                                color: BasicColors.white,
                                borderRadius: BorderRadius.circular(20.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.08),
                                    spreadRadius: 2.r,
                                    blurRadius: 10.r,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: ImageIcon(AssetImage(PngImages.filter)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),

                      //CategorySelector
                      CategorySelector(),
                      SizedBox(height: 20.h),

                      //Collections
                      BasicText(
                        text: "Collections",
                        fontSize: 18,
                        color: BasicColors.black,
                        isBold: true,
                      ),
                      SizedBox(height: 10.h),
                      CollectionsContainer(onTap: () {}),
                      SizedBox(height: 20.h),

                      //trending now
                      Row(
                        children: [
                          ImageIcon(
                            AssetImage(PngImages.trending_now),
                            color: BasicColors.buttonColorLight,
                            size: 25.w,
                          ),
                          BasicText(
                            text: ' Trending Now',
                            fontSize: 18,
                            color: BasicColors.black,
                            isBold: true,
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Wrap(
                        spacing: 10, // المسافة الأفقية بين كل هاشتاج والثاني
                        runSpacing: 10, // المسافة الرأسية بين السطور
                        children: [
                          TrendingItemName(label: '#Linen Shirt'),
                          TrendingItemName(label: '#Leather Bag'),
                          TrendingItemName(label: '#Ceramic Bowl'),
                          TrendingItemName(label: '#Wall Art'),
                          TrendingItemName(label: '#Bracelet'),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      //Browse All Categories
                      BasicText(
                        text: 'Browse All Categories',
                        fontSize: 18,
                        color: BasicColors.black,
                        isBold: true,
                      ),
                      SizedBox(height: 20.h),
                      //containers
                      BrowseAllCat(),
                      SizedBox(height: 20.h),

                      SubcategoryTabs(),
                      SizedBox(height: 20.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BasicText(
                            text: 'All Products',
                            fontSize: 18,
                            color: BasicColors.black,
                            isBold: true,
                          ),
                          BasicText(
                            text: '862 items',
                            fontSize: 12,
                            color: Color(0xff64748B),
                            isBold: true,
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),

                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.65,
                          crossAxisSpacing: 10.w,
                          mainAxisSpacing: 10.h,
                        ),
                        itemCount: _products.length,
                        itemBuilder: (context, index) {
                          return ProductCard();
                        },
                      ),
                      SizedBox(height: 20.h),

                      // Featured Brands Section
                      FeaturedBrands(),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
