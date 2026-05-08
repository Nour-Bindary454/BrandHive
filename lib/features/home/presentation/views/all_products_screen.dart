import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/features/home/data/models/home_models.dart';
import 'package:brand/features/brand_profile/data/models/product_model.dart';
import 'package:brand/features/brand_profile/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllProductsScreen extends StatelessWidget {
  final List<HomeProduct> products;

  const AllProductsScreen({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BasicColors.white,
      appBar: AppBar(
        backgroundColor: BasicColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: BasicColors.black,
            size: 20.sp,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'All Products',
          style: TextStyle(
            fontFamily: 'Outfit',
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: BasicColors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
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
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
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
        ),
      ),
    );
  }
}
