import 'package:brand/core/sharedWidgets/cus_search_bar.dart';
import 'package:brand/features/category/presentation/views/category_view.dart';
import 'package:brand/features/home/presentation/views/search_results_screen.dart';
import 'package:brand/features/home/data/models/home_models.dart';
import 'package:brand/features/home/presentation/views/widgets/top_local_brands_section.dart';
import 'package:brand/features/home/presentation/views/all_brands_screen.dart';
import 'package:brand/features/home/presentation/views/all_products_screen.dart';
import 'package:brand/features/brand_profile/data/models/product_model.dart';
import 'package:brand/features/product_details/presentation/views/product_details_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../view_models/cubit/home_cubit.dart';
import '../view_models/cubit/home_states.dart';
import 'package:brand/features/cart/presentation/viewmodel/cart_view_model.dart';
import 'package:brand/core/utils/toast/toast.dart';
import 'package:brand/core/utils/dialogs/cart_dialogs.dart';
import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/core/sharedWidgets/basic_button.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';

import 'widgets/home_header.dart';
import 'widgets/home_hero_banner.dart';
import 'widgets/categories_section.dart';
import 'widgets/bazaars_events_section.dart';

import 'widgets/home_shimmer_loading.dart';
import 'widgets/recommended_for_you_section.dart';
import 'widgets/featured_products_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            /// 🔄 Loading
            if (state.isLoading) {
              return const HomeShimmerLoading();
            }

            /// ❌ Error
            if (state.error != null) {
              return Center(
                child: Text(
                  state.error!,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            /// ✅ Success UI
            return RefreshIndicator(
              onRefresh: () async {
                context.read<HomeCubit>().loadHomeData(isRefresh: true);
              },
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
                        /// 1. Header
                        if (state.user != null) ...[
                          HomeHeader(
                            user: state.user!,
                            onNotificationTap: () {
                              Navigator.pushNamed(context, '/notifications');
                            },
                          ),
                          SizedBox(height: 20.h),
                        ],

                        /// 2. Search
                        CusSearchBar(
                          hintText: 'search_local_brands'.tr(),
                          onSubmitted: (query) {
                            if (query.trim().isNotEmpty) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SearchResultsScreen(
                                    initialQuery: query.trim(),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(height: 20.h),

                        /// 3. Banner
                        if (state.banner != null) ...[
                          HomeHeroBanner(
                            banner: state.banner!,
                            onShopNowTap: () {},
                          ),
                          SizedBox(height: 20.h),
                        ],

                        SizedBox(height: 32.h),

                        /// 4. Categories
                        if (state.categories.isNotEmpty) ...[
                          CategoriesSection(
                            categories: state.categories,
                            onCategoryTap: (category) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CategoryView(category: category),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 32.h),
                        ],

                        /// 5. Events
                        if (state.events.isNotEmpty) ...[
                          BazaarsEventsSection(
                            events: state.events,
                            onViewAllTap: () {},
                          ),
                          SizedBox(height: 32.h),
                        ],

                        /// 7. Top Local Brands
                        if (state.brands.isNotEmpty) ...[
                          TopLocalBrandsSection(
                            brands: state.brands.take(10).toList(),
                            onViewAllTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AllBrandsScreen(brands: state.brands),
                                ),
                              );
                            },
                            onBrandTap: (brand) {
                              Navigator.pushNamed(
                                context,
                                '/brandProfile',
                                arguments: brand,
                              );
                            },
                          ),
                          SizedBox(height: 32.h),
                        ],

                        /// 7. Recommended
                        if (state.recommended.isNotEmpty) ...[
                          RecommendedForYouSection(
                            products: state.recommended.take(10).toList(),
                            onViewMoreTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AllProductsScreen(
                                    products: state.recommended,
                                  ),
                                ),
                              );
                            },
                            onProductTap: (id) {
                              final homeProduct = state.recommended.firstWhere(
                                (p) => p.id == id,
                              );
                              final product = Product(
                                id: homeProduct.id,
                                brandId: '',
                                brandName: homeProduct.brandName,
                                name: homeProduct.name,
                                description: homeProduct.description,
                                image: homeProduct.imageUrl,
                                rating: homeProduct.rating,
                                price: homeProduct.price,
                                currency: 'EGP',
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetailsScreen(product: product),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 32.h),
                        ],

                        /// 8. Featured
                        if (state.featured.isNotEmpty) ...[
                          FeaturedProductsSection(
                            products: state.featured.take(10).toList(),
                            onViewAllTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AllProductsScreen(
                                    products: state.featured,
                                  ),
                                ),
                              );
                            },
                            onProductTap: (id) {
                              final homeProduct = state.featured.firstWhere(
                                (p) => p.id == id,
                              );
                              final product = Product(
                                id: homeProduct.id,
                                brandId: '',
                                brandName: homeProduct.brandName,
                                name: homeProduct.name,
                                description: homeProduct.description,
                                image: homeProduct.imageUrl,
                                rating: homeProduct.rating,
                                price: homeProduct.price,
                                currency: 'EGP',
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetailsScreen(product: product),
                                ),
                              );
                            },
                            onAddToCartTap: (id) {
                              final product = state.featured.firstWhere(
                                (p) => p.id == id,
                              );
                              CartDialogs.showAddToCartDialog(
                                context: context,
                                productId: product.id,
                                productName: product.name,
                              );
                            },
                            onFavoriteTap: (id) {},
                          ),

                          SizedBox(height: 32.h),
                        ],
                      ]),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
