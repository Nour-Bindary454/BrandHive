import 'package:brand/core/services/service_locator.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/sharedWidgets/cus_search_bar.dart';
import 'package:brand/core/utils/toast/toast.dart';
import 'package:brand/features/admin_dashboard/presentation/view_model/admin_cubit.dart';
import 'package:brand/features/admin_dashboard/presentation/view_model/admin_states.dart';
import 'package:brand/features/brand_profile/data/models/product_model.dart';
import 'package:brand/features/brand_profile/presentation/widgets/product_card.dart';
import 'package:brand/features/explore/data/repository/explore_repo.dart';
import 'package:brand/features/home/data/models/home_models.dart';
import 'package:brand/features/home/presentation/view_models/cubit/home_cubit.dart';
import 'package:brand/features/home/presentation/view_models/cubit/home_states.dart';
import 'package:brand/features/admin_dashboard/presentation/views/widgets/admin_common_header.dart';
import 'package:brand/core/utils/dialogs/cart_dialogs.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminProductsView extends StatefulWidget {
  const AdminProductsView({super.key});

  @override
  State<AdminProductsView> createState() => _AdminProductsViewState();
}

class _AdminProductsViewState extends State<AdminProductsView> {
  List<HomeProduct> _searchResults = [];
  bool _isSearching = false;
  String _currentQuery = '';

  Future<void> _handleSearch(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        _isSearching = false;
        _searchResults = [];
        _currentQuery = '';
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _currentQuery = query;
    });

    final result = await sl<ExploreRepository>().searchProducts(query);
    result.fold(
      (failure) => setState(() => _isSearching = false),
      (products) => setState(() {
        _searchResults = products;
        _isSearching = false;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminCubit, AdminState>(
      listener: (context, state) {
        if (state is AdminActionSuccess) {
          Toast.showSuccessToast(msg: state.message.tr(), context: context);
          // Update HomeCubit state locally
          if (state.id != null) {
            if (state.action == 'toggle_product') {
              final homeCubit = context.read<HomeCubit>();
              final product = homeCubit.state.featured.firstWhere(
                (p) => p.id == state.id,
              );
              homeCubit.updateProductStatus(
                state.id!,
                !(product.isActive ?? false),
              );
            } else if (state.action == 'delete_product') {
              context.read<HomeCubit>().removeProduct(state.id!);
            }
          }
        } else if (state is AdminActionError) {
          Toast.showErrorToast(msg: state.message.tr(), context: context);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: Column(
          children: [
            AdminCommonHeader(
              title: 'products'.tr(),
              subtitle: 'Manage and search product inventory',
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CusSearchBar(
                hintText: 'search_products'.tr(),
                onSubmitted: _handleSearch,
                onChanged: (val) {
                  setState(() {
                    _currentQuery = val.toLowerCase();
                    if (val.isEmpty) {
                      _searchResults = [];
                    }
                  });
                },
              ),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  // Only show active products in this view
                  final List<HomeProduct> activeProducts =
                      state.featured.where((p) => p.isActive != false).toList();

                  final List<HomeProduct> baseList =
                      _searchResults.isNotEmpty
                          ? _searchResults.where((p) => p.isActive != false).toList()
                          : activeProducts;

                  final List<HomeProduct> productsToDisplay =
                      _currentQuery.isEmpty
                          ? activeProducts
                          : baseList.where((p) {
                            final nameMatch = p.name.toLowerCase().contains(
                              _currentQuery,
                            );
                            final brandMatch = p.brandName.toLowerCase().contains(
                              _currentQuery,
                            );
                            return nameMatch || brandMatch;
                          }).toList();

                  if (_isSearching) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (productsToDisplay.isEmpty && _currentQuery.isNotEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.search,
                            size: 50.sp,
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: 16.h),
                          BasicText(
                            text: 'no_products_found'.tr(),
                            fontSize: 14.sp,
                            color: Colors.grey,
                            isBold: false,
                          ),
                        ],
                      ),
                    );
                  }

                  return GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 10.h,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                      crossAxisSpacing: 16.w,
                      mainAxisSpacing: 16.h,
                    ),
                    itemCount: productsToDisplay.length,
                    itemBuilder: (context, index) {
                      final product = productsToDisplay[index];
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
                          isActive: product.isActive ?? true,
                        ),
                        onFavoritePressed: () {},
                        onAddToCartPressed: () {
                          CartDialogs.showAddToCartDialog(
                            context: context,
                            productId: product.id,
                            productName: product.name,
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
