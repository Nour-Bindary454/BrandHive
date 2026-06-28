import 'package:brand/features/brand_profile/data/models/product_model.dart';
import 'package:brand/features/home/data/models/home_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:brand/features/brand_profile/presentation/widgets/product_card.dart';
import 'package:easy_localization/easy_localization.dart';

class CategoryProductsList extends StatelessWidget {
  final List<HomeProduct> products;
  final bool isLoading;

  const CategoryProductsList({
    super.key,
    required this.products,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      );
    }

    if (products.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Text(
            'no_products_found'.tr(),
            style: TextStyle(
              fontSize: 14.sp,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              fontFamily: 'Poppins',
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: 250.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: products.length,
        separatorBuilder: (context, index) => SizedBox(width: 16.w),
        itemBuilder: (context, index) {
          final product = products[index];
          // Map HomeProduct to Product to use in ProductCard
          final mappedProduct = Product(
            id: product.id,
            brandId: '', // Ensure you handle this correctly in your app logic
            brandName: product.brandName,
            name: product.name,
            description: product.description,
            image: product.imageUrl,
            rating: product.rating,
            price: product.price,
            currency: 'EGP',
            isFavorite: false,
          );

          return SizedBox(
            width: 160.w,
            child: ProductCard(
              product: mappedProduct,
              onFavoritePressed: () {},
              onAddToCartPressed: () {},
            ),
          );
        },
      ),
    );
  }
}
