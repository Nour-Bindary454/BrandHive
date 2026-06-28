import 'package:brand/core/services/service_locator.dart';
import 'package:brand/features/brand_profile/data/models/product_model.dart';
import 'package:brand/features/brand_profile/presentation/widgets/product_card.dart';
import 'package:brand/features/home/data/repository/home_repo.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:brand/features/cart/presentation/viewmodel/cart_view_model.dart';

class CrossSellSection extends StatefulWidget {
  const CrossSellSection({super.key});

  @override
  State<CrossSellSection> createState() => _CrossSellSectionState();
}

class _CrossSellSectionState extends State<CrossSellSection> {
  List<Product> _products = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadCrossSell());
  }

  Future<void> _loadCrossSell() async {
    final cartIds = context
        .read<CartViewModel>()
        .items
        .map((item) => item.productId)
        .where((id) => id.isNotEmpty)
        .toList();

    if (cartIds.isEmpty) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _products = [];
        });
      }
      return;
    }

    final result = await sl<HomeRepository>().getCrossSellProducts(cartIds);
    if (!mounted) return;

    result.fold(
      (_) => setState(() {
        _isLoading = false;
        _products = [];
      }),
      (products) => setState(() {
        _isLoading = false;
        _products = products;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: const Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }

    if (_products.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 12.h),
          child: Text(
            'cross_sell_title'.tr(),
            style: TextStyle(
              fontFamily: 'Outfit',
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 230.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemCount: _products.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: 14.w),
                child: SizedBox(
                  width: 155.w,
                  child: ProductCard(
                    product: _products[index],
                    onFavoritePressed: () {},
                    onAddToCartPressed: () async {
                      await context
                          .read<CartViewModel>()
                          .addToCart(_products[index].id);
                      if (context.mounted) {
                        _loadCrossSell();
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 12.h),
      ],
    );
  }
}
