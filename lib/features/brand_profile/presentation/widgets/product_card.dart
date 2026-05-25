import 'package:brand/core/services/cache_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:brand/features/brand_profile/presentation/views/widgets/common_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:brand/features/admin_dashboard/presentation/view_model/admin_cubit.dart';

import '../../data/models/product_model.dart';

import 'package:brand/features/product_details/presentation/views/product_details_screen.dart';
import 'package:brand/core/sharedWidgets/favorite_button.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onFavoritePressed;
  final VoidCallback onAddToCartPressed;

  const ProductCard({
    super.key,
    required this.product,
    required this.onFavoritePressed,
    required this.onAddToCartPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isAdmin = CacheHelper.getData(key: 'role')?.toLowerCase() == 'admin';
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(product: product),
          ),
        );
      },
      child: Container(
        height: 200.h,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
              blurRadius: 16.r,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16.r),
                    ),
                    child: product.image.startsWith('http')
                        ? Image.network(
                            product.image.isEmpty
                                ? 'https://placehold.co/300x300/png'
                                : product.image,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                                  child: const Center(
                                    child: Icon(Icons.image_not_supported),
                                  ),
                                ),
                          )
                        : Image.asset(
                            product.image,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                                  child: const Center(
                                    child: Icon(Icons.image_not_supported),
                                  ),
                                ),
                          ),
                  ),
                  if (!isAdmin)
                    Positioned(
                      top: 8.h,
                      right: 8.w,
                      child: Material(
                        color: Theme.of(context).cardColor.withValues(alpha: 0.9),
                        shape: const CircleBorder(),
                        child: FavoriteButton(
                          productId: product.id,
                          initialIsFavorite: product.isFavorite,
                          size: 18.sp,
                          padding: EdgeInsets.all(6.0.r),
                        ),
                      ),
                    ),
                  if (isAdmin)
                    Positioned(
                      top: 4.h,
                      right: 4.w,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: PopupMenuButton<String>(
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            CupertinoIcons.ellipsis_vertical,
                            size: 16.sp,
                            color: Colors.grey[700],
                          ),
                          onSelected: (value) {
                            if (value == 'delete') {
                              showCupertinoDialog(
                                context: context,
                                builder: (ctx) => CupertinoAlertDialog(
                                  title: Text('delete_product'.tr()),
                                  content: Text('delete_confirm_msg'.tr()),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: Text('cancel'.tr()),
                                      onPressed: () => Navigator.pop(ctx),
                                    ),
                                    CupertinoDialogAction(
                                      isDestructiveAction: true,
                                      onPressed: () {
                                        Navigator.pop(ctx);
                                        context.read<AdminCubit>().deleteProduct(product.id);
                                      },
                                      child: Text('delete'.tr()),
                                    ),
                                  ],
                                ),
                              );
                            } else if (value == 'toggle') {
                              context.read<AdminCubit>().toggleProductStatus(
                                    product.id,
                                    product.isActive ?? true,
                                  );
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 'toggle',
                              child: Row(
                                children: [
                                  Icon(
                                    (product.isActive ?? true)
                                        ? CupertinoIcons.nosign
                                        : CupertinoIcons.checkmark_circle,
                                    color:
                                        (product.isActive ?? true)
                                            ? Colors.orange
                                            : Colors.green,
                                    size: 16.sp,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    (product.isActive ?? true)
                                        ? 'deactivate'.tr()
                                        : 'activate'.tr(),
                                    style: TextStyle(fontSize: 12.sp),
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 'delete',
                              child: Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.trash,
                                    color: Colors.red,
                                    size: 16.sp,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    'delete'.tr(),
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),

              // Info Section
              Padding(
                padding: EdgeInsets.all(12.r),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.brandName.isNotEmpty
                              ? product.brandName.toUpperCase()
                              : 'unknown_brand'.tr(),
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                            letterSpacing: 0.5,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          product.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSurface,
                            height: 1.2.h,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        RatingWidget(
                          rating: product.rating,
                          textStyle: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          starColor: Colors.amber,
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '${product.price.toInt()} ',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                              ),
                              TextSpan(
                                text: product.currency,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (CacheHelper.getData(key: 'role')?.toLowerCase() != 'admin')
                          AddToCartButton(onPressed: onAddToCartPressed),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
