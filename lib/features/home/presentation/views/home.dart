import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/core/sharedWidgets/cus_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../view_models/home_view_model.dart';
import 'widgets/home_header.dart';
import 'widgets/home_hero_banner.dart';
import 'widgets/action_buttons_section.dart';
import 'widgets/categories_section.dart';
import 'widgets/bazaars_events_section.dart';
import 'widgets/promotional_banner.dart';
import 'widgets/home_shimmer_loading.dart';
import 'widgets/top_local_brands_section.dart';
import 'widgets/recommended_for_you_section.dart';
import 'widgets/featured_products_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel _viewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.loadHomeData();
    _viewModel.addListener(_onViewModelChange);
  }

  void _onViewModelChange() {
    setState(() {});
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelChange);
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BasicColors.white,
      body: SafeArea(
        child: _viewModel.isLoading
            ? const HomeShimmerLoading()
            : _viewModel.error != null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _viewModel.error!,
                      style: TextStyle(color: Colors.red),
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: _viewModel.loadHomeData,
                      child: Text('Retry'),
                    ),
                  ],
                ),
              )
            : RefreshIndicator(
                onRefresh: _viewModel.loadHomeData,
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
                          // 1. Header Section
                          if (_viewModel.userProfile != null) ...[
                            HomeHeader(
                              user: _viewModel.userProfile!,
                              onNotificationTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Notifications tapped'),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 20.h),
                          ],

                          // 2. Search Bar
                          CusSearchBar(hintText: 'Search local brands...'),

                          SizedBox(height: 20.h),

                          // 3. Hero Banner
                          if (_viewModel.heroBanner != null) ...[
                            HomeHeroBanner(
                              banner: _viewModel.heroBanner!,
                              onShopNowTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Shop Now tapped'),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 20.h),
                          ],

                          // 4. Action Buttons
                          ActionButtonsSection(
                            onShopNowTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Shop Now (Primary) tapped'),
                                ),
                              );
                            },
                            onSellNowTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Sell Now tapped'),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 32.h),

                          // 5. Categories Section
                          if (_viewModel.categories.isNotEmpty) ...[
                            CategoriesSection(
                              categories: _viewModel.categories,
                              onCategoryTap: (id) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Category $id tapped'),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 32.h),
                          ],

                          // 6. Bazaars & Events
                          if (_viewModel.events.isNotEmpty) ...[
                            BazaarsEventsSection(
                              events: _viewModel.events,
                              onViewAllTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('View All Events tapped'),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 32.h),
                          ],

                          // 7. Promotional Banner
                          PromotionalBanner(
                            onGoTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Go tapped')),
                              );
                            },
                          ),
                          SizedBox(height: 32.h),

                          // 8. Top Local Brands
                          if (_viewModel.topBrands.isNotEmpty) ...[
                            TopLocalBrandsSection(
                              brands: _viewModel.topBrands,
                              onViewAllTap: () {},
                              onBrandTap: (id) {},
                            ),
                            SizedBox(height: 32.h),
                          ],

                          // 9. Recommended For You
                          if (_viewModel.recommendedProducts.isNotEmpty) ...[
                            RecommendedForYouSection(
                              products: _viewModel.recommendedProducts,
                              onViewMoreTap: () {},
                              onProductTap: (id) {},
                            ),
                            SizedBox(height: 32.h),
                          ],

                          // 10. Featured Products
                          if (_viewModel.featuredProducts.isNotEmpty) ...[
                            FeaturedProductsSection(
                              products: _viewModel.featuredProducts,
                              onViewAllTap: () {},
                              onProductTap: (id) {},
                              onAddToCartTap: (id) {},
                              onFavoriteTap: (id) {},
                            ),
                            SizedBox(height: 32.h),
                          ],
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
