import 'package:brand/core/services/service_locator.dart';
import 'package:brand/features/brand_profile/data/models/product_model.dart';
import 'package:brand/features/brand_profile/presentation/view_models/brand_profile_cubit.dart';
import 'package:brand/features/brand_profile/presentation/view_models/brand_profile_states.dart';
import 'package:brand/features/home/data/models/home_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/brand_header_section.dart';
import '../widgets/product_card.dart';

class BrandProfileScreen extends StatelessWidget {
  const BrandProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brand = ModalRoute.of(context)!.settings.arguments as BrandModel;

    return BlocProvider(
      create: (context) => sl<BrandProfileCubit>()..getBrandProducts(brand.id),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FB),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cover Image + Header Overlap
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Cover Image
                      SizedBox(
                        width: double.infinity,
                        height: 250.h,
                        child: Transform.scale(
                          scale: 1.35,
                          child: Image.network(
                            brand.logoUrl.isNotEmpty ? brand.logoUrl : 'https://placehold.co/800x400/png', 
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[200]),
                          ),
                        ),
                      ),

                      // Brand Header
                      Positioned(
                        bottom: -130.h,
                        left: 0,
                        right: 0,
                        child: BrandHeaderSection(brand: brand),
                      ),
                    ],
                  ),

                  SizedBox(height: 150.h),
                  
                  // Products Section (BlocBuilder)
                  BlocBuilder<BrandProfileCubit, BrandProfileState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 50.h),
                          child: const Center(child: CircularProgressIndicator()),
                        );
                      }

                      if (state.error != null) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 50.h),
                          child: Center(child: Text("Error: ${state.error}", style: const TextStyle(color: Colors.red))),
                        );
                      }

                      // Collection Title
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Row(
                              children: [
                                Text(
                                  'Collection',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  '(${state.products.length})',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 12.h),

                          if (state.products.isEmpty)
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 50.h),
                              child: const Center(child: Text("No products found for this brand.")),
                            )
                          else
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.59,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                ),
                                itemCount: state.products.length,
                                itemBuilder: (context, index) {
                                  final homeProduct = state.products[index];
                                  final product = Product(
                                    id: homeProduct.id,
                                    brandId: brand.id,
                                    brandName: brand.name,
                                    name: homeProduct.name,
                                    description: homeProduct.description,
                                    image: homeProduct.imageUrl,
                                    rating: homeProduct.rating,
                                    price: homeProduct.price,
                                    currency: 'EGP',
                                    isFavorite: false,
                                  );

                                  return ProductCard(
                                    product: product,
                                    onFavoritePressed: () {},
                                    onAddToCartPressed: () {},
                                  );
                                },
                              ),
                            ),
                          SizedBox(height: 32.h),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),

            // Pinned Back Button
            Positioned(
              top: MediaQuery.of(context).padding.top + 8.h,
              left: 16.w,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.8),
                  shape: const CircleBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
