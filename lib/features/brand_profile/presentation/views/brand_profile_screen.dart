import 'package:brand/core/services/cache_helper.dart';
import 'package:brand/core/utils/toast/toast.dart';
import 'package:brand/features/admin_dashboard/presentation/view_model/admin_cubit.dart';
import 'package:brand/features/admin_dashboard/presentation/view_model/admin_states.dart';
import 'package:brand/features/home/presentation/view_models/cubit/home_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/services/service_locator.dart';
import 'package:brand/features/brand_profile/data/models/product_model.dart';
import 'package:brand/features/brand_profile/presentation/view_models/brand_profile_cubit.dart';
import 'package:brand/features/brand_profile/presentation/view_models/brand_profile_states.dart';
import 'package:brand/features/home/data/models/home_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/brand_header_section.dart';
import '../widgets/product_card.dart';

class BrandProfileScreen extends StatelessWidget {
  const BrandProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    final BrandModel? initialBrand = args is BrandModel ? args : null;
    final String brandId = initialBrand?.id ?? args as String;
    final isAdmin = CacheHelper.getData(key: 'role') == 'admin';

    return BlocProvider(
      create: (context) => sl<BrandProfileCubit>()..loadBrandData(brandId, initialBrand: initialBrand),
      child: BlocBuilder<BrandProfileCubit, BrandProfileState>(
        builder: (context, state) {
          final brand = state.brand;

          if (state.isLoading && brand == null) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          if (state.error != null && brand == null) {
            return Scaffold(
              body: Center(
                child: Text("Error: ${state.error}", style: const TextStyle(color: Colors.red)),
              ),
            );
          }

          if (brand == null) {
            return const Scaffold(body: Center(child: Text("Brand not found")));
          }

          return MultiBlocProvider(
            providers: [
              if (isAdmin) BlocProvider(create: (context) => sl<AdminCubit>()),
            ],
            child: BlocListener<AdminCubit, AdminState>(
              listener: (context, adminState) {
                if (adminState is AdminActionSuccess) {
                  Toast.showSuccessToast(msg: adminState.message.tr(), context: context);
                  if (adminState.id != null) {
                    if (adminState.action == 'toggle_brand') {
                      context.read<HomeCubit>().updateBrandStatus(adminState.id!, !brand.isActive);
                      Navigator.pop(context);
                    } else if (adminState.action == 'delete_brand') {
                      context.read<HomeCubit>().removeBrand(adminState.id!);
                      Navigator.pop(context);
                    }
                  }
                } else if (adminState is AdminActionError) {
                  Toast.showErrorToast(msg: adminState.message.tr(), context: context);
                }
              },
              child: Scaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                body: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
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
                              Positioned(
                                bottom: -130.h,
                                left: 0,
                                right: 0,
                                child: BrandHeaderSection(brand: brand),
                              ),
                            ],
                          ),
                          SizedBox(height: 150.h),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Row(
                                  children: [
                                    Text(
                                      'collection'.tr(),
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
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
                              if (state.products.isEmpty && !state.isLoading)
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 50.h),
                                  child: Center(child: Text('no_products_brand'.tr())),
                                )
                              else if (state.isLoading && state.products.isEmpty)
                                const Center(child: CircularProgressIndicator())
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
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 8.h,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
                              onPressed: () => Navigator.of(context).pop(),
                              style: IconButton.styleFrom(
                                backgroundColor: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.8),
                                shape: const CircleBorder(),
                              ),
                            ),
                            if (isAdmin) _AdminPopupMenu(brand: brand),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _AdminPopupMenu extends StatelessWidget {
  final BrandModel brand;
  const _AdminPopupMenu({required this.brand});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(CupertinoIcons.ellipsis_vertical, color: Theme.of(context).iconTheme.color),
      style: IconButton.styleFrom(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.8),
        shape: const CircleBorder(),
      ),
      onSelected: (value) {
        if (value == 'delete') {
          _showDeleteDialog(context);
        } else if (value == 'toggle') {
          context.read<AdminCubit>().toggleBrandStatus(brand.id, brand.isActive);
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'toggle',
          child: Row(
            children: [
              Icon(
                brand.isActive ? CupertinoIcons.nosign : CupertinoIcons.checkmark_circle,
                color: brand.isActive ? Colors.orange : Colors.green,
                size: 18.sp,
              ),
              SizedBox(width: 8.w),
              Text(brand.isActive ? 'deactivate'.tr() : 'activate'.tr()),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              Icon(CupertinoIcons.trash, color: Colors.red, size: 18.sp),
              SizedBox(width: 8.w),
              Text('delete'.tr(), style: const TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ],
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text('delete_brand'.tr()),
        content: Text('delete_brand_confirm_msg'.tr()),
        actions: [
          CupertinoDialogAction(
            child: Text('cancel'.tr()),
            onPressed: () => Navigator.pop(ctx),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(ctx);
              context.read<AdminCubit>().deleteBrand(brand.id);
            },
            child: Text('delete'.tr()),
          ),
        ],
      ),
    );
  }
}
