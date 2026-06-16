import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/features/seller/data/model/seller_models.dart';
import 'package:brand/features/seller/presentation/view_model/seller_cubit.dart';
import 'package:brand/features/seller/presentation/view_model/seller_states.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductInsightsSection extends StatelessWidget {
  const ProductInsightsSection({super.key});

  String _formatCount(int value) {
    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}k';
    }
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellerCubit, SellerState>(
      builder: (context, state) {
        final cubit = context.read<SellerCubit>();
        final insights = cubit.productInsights;
        final isLoading =
            state is SellerProductInsightsLoading && insights == null;

        if (isLoading) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            child: const Center(
              child: CircularProgressIndicator(color: Color(0xFF2D4373)),
            ),
          );
        }

        final products = insights?.products ?? [];
        if (products.isEmpty) {
          return const SizedBox.shrink();
        }

        final topProducts = products.take(5).toList();

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BasicText(
                text: 'product_insights'.tr(),
                fontSize: 16,
                color: const Color(0xFF0F172A),
                isBold: true,
              ),
              SizedBox(height: 4.h),
              BasicText(
                text: 'product_insights_subtitle'.tr(),
                fontSize: 11,
                color: Colors.grey.shade500,
              ),
              SizedBox(height: 12.h),
              ...topProducts.map((product) => _buildInsightRow(product)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInsightRow(ProductInsightItem product) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BasicText(
            text: product.name,
            fontSize: 13,
            color: const Color(0xFF1E293B),
            isBold: true,
          ),
          if (product.categoryName.isNotEmpty) ...[
            SizedBox(height: 2.h),
            BasicText(
              text: product.categoryName,
              fontSize: 10,
              color: Colors.grey.shade500,
            ),
          ],
          SizedBox(height: 10.h),
          Row(
            children: [
              _buildMetricChip(Icons.visibility_outlined, 'views'.tr(), _formatCount(product.viewCount)),
              SizedBox(width: 8.w),
              _buildMetricChip(Icons.shopping_cart_outlined, 'cart_adds'.tr(), _formatCount(product.cartCount)),
              SizedBox(width: 8.w),
              _buildMetricChip(Icons.favorite_border, 'wishlists'.tr(), _formatCount(product.wishlistCount)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricChip(IconData icon, String label, String value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 6.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          children: [
            Icon(icon, size: 14.sp, color: const Color(0xFF5384DB)),
            SizedBox(height: 4.h),
            BasicText(
              text: value,
              fontSize: 12,
              color: const Color(0xFF0F172A),
              isBold: true,
            ),
            BasicText(
              text: label,
              fontSize: 9,
              color: Colors.grey.shade500,
            ),
          ],
        ),
      ),
    );
  }
}
