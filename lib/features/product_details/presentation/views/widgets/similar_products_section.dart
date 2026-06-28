import 'package:brand/core/services/service_locator.dart';
import 'package:brand/features/brand_profile/data/models/product_model.dart';
import 'package:brand/features/brand_profile/presentation/widgets/product_card.dart';
import 'package:brand/features/product_details/presentation/view_model/similar_products_cubit.dart';
import 'package:brand/features/product_details/presentation/view_model/similar_products_state.dart';
import 'package:brand/features/product_details/presentation/view_model/similar_products_loading.dart';
import 'package:brand/features/product_details/presentation/view_model/similar_products_success.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SimilarProductsSection extends StatelessWidget {
  final Product product;

  const SimilarProductsSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SimilarProductsCubit>()..getSimilarProducts(product.id),
      child: BlocBuilder<SimilarProductsCubit, SimilarProductsState>(
        builder: (context, state) {
          if (state is SimilarProductsLoading) {
            return SizedBox(
              height: 230.h,
              child: const Center(child: CircularProgressIndicator()),
            );
          }
          if (state is SimilarProductsSuccess) {
            if (state.products.isEmpty) return const SizedBox();
            for (var p in state.products) {
              debugPrint("📸 [SimilarProductsSection] Product: ${p.name}, Image URL: ${p.image}");
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                  child: Text(
                    'similar_products'.tr(),
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 18.sp,
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
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 14.w),
                        child: SizedBox(
                          width: 155.w,
                          child: ProductCard(
                            product: state.products[index],
                            onFavoritePressed: () {},
                            onAddToCartPressed: () {},
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
