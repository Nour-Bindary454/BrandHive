import 'package:brand/core/services/service_locator.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/utils/appImages/png_images.dart';
import 'package:brand/features/brand_profile/data/models/product_model.dart';
import 'package:brand/features/explore/data/repository/explore_repo.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MarketTrendsSection extends StatefulWidget {
  const MarketTrendsSection({super.key});

  @override
  State<MarketTrendsSection> createState() => _MarketTrendsSectionState();
}

class _MarketTrendsSectionState extends State<MarketTrendsSection> {
  List<Product> _trending = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTrending();
  }

  Future<void> _loadTrending() async {
    final result = await sl<ExploreRepository>().getTrendingProducts();
    if (!mounted) return;

    result.fold(
      (_) => setState(() {
        _isLoading = false;
        _trending = [];
      }),
      (products) => setState(() {
        _isLoading = false;
        _trending = products.take(5).toList();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        child: const Center(
          child: CircularProgressIndicator(color: Color(0xFF2D4373)),
        ),
      );
    }

    if (_trending.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ImageIcon(
                const AssetImage(PngImages.trending_now),
                color: const Color(0xFF5384DB),
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              BasicText(
                text: 'market_trends'.tr(),
                fontSize: 16,
                color: const Color(0xFF0F172A),
                isBold: true,
              ),
            ],
          ),
          SizedBox(height: 4.h),
          BasicText(
            text: 'market_trends_subtitle'.tr(),
            fontSize: 11,
            color: Colors.grey.shade500,
          ),
          SizedBox(height: 12.h),
          ..._trending.map(_buildTrendRow),
        ],
      ),
    );
  }

  Widget _buildTrendRow(Product product) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.network(
              product.image,
              width: 44.w,
              height: 44.w,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 44.w,
                height: 44.w,
                color: Colors.grey.shade200,
                child: Icon(Icons.image_outlined, size: 20.sp),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BasicText(
                  text: product.name,
                  fontSize: 12,
                  color: const Color(0xFF1E293B),
                  isBold: true,
                ),
                SizedBox(height: 2.h),
                BasicText(
                  text: product.brandName,
                  fontSize: 10,
                  color: Colors.grey.shade500,
                ),
              ],
            ),
          ),
          BasicText(
            text: '${product.price.toInt()} ${'egp'.tr()}',
            fontSize: 11,
            color: const Color(0xFF2D4373),
            isBold: true,
          ),
        ],
      ),
    );
  }
}
