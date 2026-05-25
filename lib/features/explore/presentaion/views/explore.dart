import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/services/service_locator.dart';
import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/sharedWidgets/cus_search_bar.dart';
import 'package:brand/core/utils/appImages/png_images.dart';
import 'package:brand/features/brand_profile/data/models/product_model.dart';
import 'package:brand/features/brand_profile/presentation/widgets/product_card.dart';
import 'package:brand/features/explore/presentaion/viewsModel/explore_cubit.dart';
import 'package:brand/features/explore/presentaion/viewsModel/explore_states.dart';
import 'package:brand/features/explore/presentaion/views/widgets/collections_container.dart';
import 'package:brand/features/explore/presentaion/views/widgets/filter_bottom_sheet.dart';
import 'package:brand/features/explore/presentaion/views/widgets/featured_brands.dart';
import 'package:brand/features/home/presentation/views/search_results_screen.dart';
import 'package:brand/features/explore/presentaion/views/widgets/trending_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Explore extends StatelessWidget {
  const Explore({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ExploreCubit>()..getProducts(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: SafeArea(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 13.w,
                      vertical: 16.h,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BasicText(
                              text: 'explore'.tr(),
                              fontSize: 24,
                              color:
                                  Theme.of(
                                    context,
                                  ).textTheme.bodyLarge?.color ??
                                  BasicColors.black,
                              isBold: true,
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 0.8.sw,
                                  child: CusSearchBar(
                                    hintText: 'search_products'.tr(),
                                    onSubmitted: (query) {
                                      if (query.trim().isNotEmpty) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SearchResultsScreen(
                                                  initialQuery: query.trim(),
                                                ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final cubit = context.read<ExploreCubit>();
                                    final state = cubit.state;
                                    final result =
                                        await showModalBottomSheet<
                                          Map<String, dynamic>
                                        >(
                                          context: context,
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          builder: (context) =>
                                              FilterBottomSheet(
                                                initialSort: state.sortBy,
                                                initialCategory: state.category,
                                                initialMinPrice: state.minPrice,
                                                initialMaxPrice: state.maxPrice,
                                                categories: state.categories
                                                    .map((c) => c.name)
                                                    .toList(),
                                              ),
                                        );
                                    if (result != null) {
                                      await cubit.filterProducts(
                                        sortBy: result['sortBy'],
                                        category: result['category'],
                                        minPrice: result['minPrice'],
                                        maxPrice: result['maxPrice'],
                                      );
                                    }
                                  },
                                  child: Container(
                                    height: 45.h,
                                    width: 0.13.sw,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(20.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.08),
                                          spreadRadius: 2.r,
                                          blurRadius: 10.r,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                      border: Border.all(
                                        color: Colors.grey.shade200,
                                      ),
                                    ),
                                    child: ImageIcon(
                                      const AssetImage(PngImages.filter),
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),

                            //Collections
                            BasicText(
                              text: "collections".tr(),
                              fontSize: 18,
                              color:
                                  Theme.of(
                                    context,
                                  ).textTheme.bodyLarge?.color ??
                                  BasicColors.black,
                              isBold: true,
                            ),
                            SizedBox(height: 10.h),
                            CollectionsContainer(onTap: () {}),
                            SizedBox(height: 20.h),

                            //trending now
                            Row(
                              children: [
                                ImageIcon(
                                  const AssetImage(PngImages.trending_now),
                                  color: BasicColors.buttonColorLight,
                                  size: 25.w,
                                ),
                                BasicText(
                                  text: ' ${'trending_now'.tr()}',
                                  fontSize: 18,
                                  color:
                                      Theme.of(
                                        context,
                                      ).textTheme.bodyLarge?.color ??
                                      BasicColors.black,
                                  isBold: true,
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                TrendingItemName(label: '#Linen Shirt'),
                                TrendingItemName(label: '#Leather Bag'),
                                TrendingItemName(label: '#Ceramic Bowl'),
                                TrendingItemName(label: '#Wall Art'),
                                TrendingItemName(label: '#Bracelet'),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            BlocBuilder<ExploreCubit, ExploreState>(
                              builder: (context, state) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    BasicText(
                                      text: 'all_products'.tr(),
                                      fontSize: 18,
                                      color:
                                          Theme.of(
                                            context,
                                          ).textTheme.bodyLarge?.color ??
                                          BasicColors.black,
                                      isBold: true,
                                    ),
                                    Row(
                                      children: [
                                        BasicText(
                                          text:
                                              '${state.products.length} items',
                                          fontSize: 12,
                                          color: const Color(0xff64748B),
                                          isBold: true,
                                        ),
                                        SizedBox(width: 8.w),
                                        InkWell(
                                          onTap: () {
                                            // Navigator.push(
                                            //   context,
                                            //   // MaterialPageRoute(
                                            //   //   builder: (context) =>
                                            //   //       AllProductsScreen(products:  state.products),
                                            //   // ),
                                            // );
                                          },
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
                                  ],
                                );
                              },
                            ),
                            SizedBox(height: 15.h),

                            BlocBuilder<ExploreCubit, ExploreState>(
                              builder: (context, state) {
                                if (state.isLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state.error != null) {
                                  return Center(
                                    child: Text("Error: ${state.error}"),
                                  );
                                } else if (state.filteredProducts.isEmpty) {
                                  return Center(
                                    child: Text('no_products_found'.tr()),
                                  );
                                }

                                return GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 0.65,
                                        crossAxisSpacing: 10.w,
                                        mainAxisSpacing: 10.h,
                                      ),
                                  itemCount: state.filteredProducts.length,
                                  itemBuilder: (context, index) {
                                    final product =
                                        state.filteredProducts[index];
                                    return ProductCard(
                                      product: Product(
                                        id: product.id,
                                        brandId: '',
                                        brandName: product.brandName,
                                        name: product.name,
                                        description: product.description,
                                        image: product.imageUrl,
                                        rating: product.rating,
                                        price: product.price,
                                        currency: 'EGP',
                                        isFavorite: false,
                                      ),
                                      onFavoritePressed: () {},
                                      onAddToCartPressed: () {},
                                    );
                                  },
                                );
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
        },
      ),
    );
  }
}
