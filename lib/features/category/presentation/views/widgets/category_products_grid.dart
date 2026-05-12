import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:brand/features/brand_profile/data/models/product_model.dart';
import 'package:brand/features/brand_profile/presentation/widgets/product_card.dart';
import 'package:brand/features/home/data/models/home_models.dart';

import 'package:brand/core/utils/dialogs/cart_dialogs.dart';

class CategoryProductsGrid extends StatelessWidget {
  final List<HomeProduct> products;

  const CategoryProductsGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return Center(
        child: Text(
          'No products found',
          style: TextStyle(
            fontSize: 14.sp,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: GridView.builder(
        padding: EdgeInsets.only(bottom: 20.h),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final homeProduct = products[index];
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
            isFavorite: false,
          );

          return ProductCard(
            onFavoritePressed: () {},
            product: product,
            onAddToCartPressed: () {
              CartDialogs.showAddToCartDialog(
                context: context,
                productId: homeProduct.id,
                productName: homeProduct.name,
              );
            },
          );
        },
      ),
    );
  }
}
