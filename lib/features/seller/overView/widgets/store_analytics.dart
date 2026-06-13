import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/utils/appImages/png_images.dart';
import 'package:brand/features/seller/presentation/view_model/seller_cubit.dart';
import 'package:brand/features/seller/presentation/view_model/seller_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StoreAnalytics extends StatelessWidget {
  const StoreAnalytics({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellerCubit, SellerState>(
      builder: (context, state) {
        final cubit = context.read<SellerCubit>();
        final views = cubit.dashboardData?.profileViews ?? 0;
        final products = cubit.dashboardData?.productsCount ?? 0;
        final rating = cubit.dashboardData?.rating ?? 0.0;

        // Formats views like 1200 -> 1.2k
        String formattedViews = views.toString();
        if (views >= 1000) {
          formattedViews = '${(views / 1000).toStringAsFixed(1)}k';
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BasicText(
                text: 'store_analytics'.tr(),
                fontSize: 16,
                color: const Color(0xFF0F172A),
                isBold: true,
              ),
              SizedBox(height: 15.h),
              Row(
                children: [
                  Expanded(
                    child: _buildAnalyticBox(
                      context,
                      ImageIcon(
                        AssetImage(PngImages.people),
                        color: const Color(0xFF5384DB),
                        size: 24.sp,
                      ),
                      formattedViews,
                      'Profile Views',
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: _buildAnalyticBox(
                      context,
                      ImageIcon(
                        AssetImage(PngImages.products),
                        color: const Color(0xFF5384DB),
                        size: 24.sp,
                      ),
                      products.toString(),
                      'Products',
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: _buildAnalyticBox(
                      context,
                      ImageIcon(
                        AssetImage(PngImages.dollar),
                        color: const Color(0xFFF5A623),
                        size: 24.sp,
                      ),
                      rating.toStringAsFixed(1),
                      'Rating',
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAnalyticBox(BuildContext context, Widget iconWidget, String value, String label) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          iconWidget,
          SizedBox(height: 12.h),
          BasicText(
            text: value,
            fontSize: 16,
            color: const Color(0xFF0F172A),
            isBold: true,
          ),
          SizedBox(height: 4.h),
          BasicText(
            text: label,
            fontSize: 10,
            color: Colors.grey.shade500,
            isBold: false,
          ),
        ],
      ),
    );
  }
}
