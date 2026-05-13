import 'package:brand/core/services/service_locator.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/sharedWidgets/cus_search_bar.dart';
import 'package:brand/features/brand_profile/data/models/product_model.dart';
import 'package:brand/features/brand_profile/presentation/widgets/product_card.dart';
import 'package:brand/features/explore/data/repository/explore_repo.dart';
import 'package:brand/features/home/data/models/home_models.dart';
import 'package:brand/core/errors/failure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchResultsScreen extends StatefulWidget {
  final String initialQuery;

  const SearchResultsScreen({super.key, required this.initialQuery});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  List<HomeProduct> _results = [];
  bool _isLoading = true;
  String? _error;
  late String _currentQuery;

  @override
  void initState() {
    super.initState();
    _currentQuery = widget.initialQuery;
    _search(_currentQuery);
  }

  Future<void> _search(String query) async {
    if (query.trim().isEmpty) return;

    setState(() {
      _isLoading = true;
      _error = null;
      _currentQuery = query;
    });

    final result = await sl<ExploreRepository>().searchProducts(query.trim());

    result.fold(
      (failure) {
        setState(() {
          _isLoading = false;
          _error = failure.errMessage;
        });
      },
      (products) {
        setState(() {
          _isLoading = false;
          _results = products;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10.h),
            // Header with back + search bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20.sp,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: CusSearchBar(
                      hintText: 'Search products...',
                      onSubmitted: (query) => _search(query),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // Results info
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  BasicText(
                    text: _isLoading
                        ? 'Searching...'
                        : '${_results.length} results for "$_currentQuery"',
                    fontSize: 13.sp,
                    color: const Color(0xFF64748B),
                    isBold: false,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            const Divider(
                color: Color(0xFFF1F5F9), thickness: 1, height: 1),

            // Results grid
            Expanded(
              child: _buildBody(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BasicText(
              text: _error!,
              fontSize: 14.sp,
              color: const Color(0xFF64748B),
              isBold: false,
            ),
            SizedBox(height: 12.h),
            InkWell(
              onTap: () => _search(_currentQuery),
              child: BasicText(
                text: 'Retry',
                fontSize: 14.sp,
                color: const Color(0xFF3B82F6),
                isBold: true,
              ),
            ),
          ],
        ),
      );
    }

    if (_results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off_rounded,
                size: 48.sp, color: const Color(0xFF94A3B8)),
            SizedBox(height: 12.h),
            BasicText(
              text: 'No products found',
              fontSize: 14.sp,
              color: const Color(0xFF64748B),
              isBold: false,
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: 16.h, bottom: 32.h),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
        ),
        itemCount: _results.length,
        itemBuilder: (context, index) {
          final product = _results[index];
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
      ),
    );
  }
}
