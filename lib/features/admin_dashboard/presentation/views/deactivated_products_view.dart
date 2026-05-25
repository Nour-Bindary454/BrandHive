import 'package:brand/core/services/service_locator.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/utils/toast/toast.dart';
import 'package:brand/features/admin_dashboard/presentation/view_model/admin_cubit.dart';
import 'package:brand/features/admin_dashboard/presentation/view_model/admin_states.dart';
import 'package:brand/features/home/presentation/view_models/cubit/home_cubit.dart';
import 'package:brand/features/home/presentation/view_models/cubit/home_states.dart';
import 'package:brand/features/brand_profile/data/models/product_model.dart';
import 'package:brand/features/brand_profile/presentation/widgets/product_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeactivatedProductsView extends StatelessWidget {
  const DeactivatedProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AdminCubit>(),
      child: BlocListener<AdminCubit, AdminState>(
        listener: (context, state) {
          if (state is AdminActionSuccess) {
            Toast.showSuccessToast(msg: state.message.tr(), context: context);
            // Update HomeCubit state locally
            if (state.id != null) {
              if (state.action == 'toggle_product') {
                final homeCubit = context.read<HomeCubit>();
                final product = homeCubit.state.featured.firstWhere(
                  (p) => p.id == state.id,
                );
                homeCubit.updateProductStatus(
                  state.id!,
                  !(product.isActive ?? false),
                );
              } else if (state.action == 'delete_product') {
                context.read<HomeCubit>().removeProduct(state.id!);
              }
            }
          } else if (state is AdminActionError) {
            Toast.showErrorToast(msg: state.message.tr(), context: context);
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(CupertinoIcons.back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'deactivated_products'.tr(),
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Outfit',
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              final deactivatedProducts =
                  state.featured.where((p) => p.isActive == false).toList();

              if (deactivatedProducts.isEmpty) {
                return _EmptyState();
              }

              return GridView.builder(
                padding: EdgeInsets.all(16.w),
                physics: const BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                ),
                itemCount: deactivatedProducts.length,
                itemBuilder: (context, index) {
                  final product = deactivatedProducts[index];
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
                      isActive: false,
                    ),
                    onFavoritePressed: () {},
                    onAddToCartPressed: () {},
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(CupertinoIcons.cube_box, size: 60.sp, color: Colors.grey[300]),
          SizedBox(height: 16.h),
          BasicText(
            text: 'no_deactivated_products'.tr(),
            fontSize: 14.sp,
            color: Colors.grey,
            isBold: false,
          ),
        ],
      ),
    );
  }
}
