import 'package:brand/core/services/cache_helper.dart';
import 'package:brand/core/sharedWidgets/favorite_button.dart';
import 'package:brand/features/admin_dashboard/presentation/view_model/admin_cubit.dart';
import 'package:brand/features/brand_profile/data/models/product_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductImageSection extends StatelessWidget {
  final Product product;
  const ProductImageSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final isAdmin = CacheHelper.getData(key: 'role')?.toLowerCase() == 'admin';

    return Stack(
      children: [
        SizedBox(
          height: 400.h,
          width: double.infinity,
          child: Hero(
            tag: product.id,
            child: product.image.startsWith('http')
                ? Image.network(
                    product.image.isEmpty ? 'https://placehold.co/400x500/png' : product.image,
                    fit: BoxFit.cover,
                  )
                : Image.asset(product.image, fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: 50.h,
          left: 20.w,
          child: _FloatingButton(icon: Icons.arrow_back_ios_new, onTap: () => Navigator.pop(context)),
        ),
        Positioned(
          top: 50.h,
          right: 20.w,
          child: isAdmin ? _AdminActions(product: product) : _FavoriteAction(product: product),
        ),
      ],
    );
  }
}

class _FloatingButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _FloatingButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20.sp),
      ),
    );
  }
}

class _AdminActions extends StatelessWidget {
  final Product product;
  const _AdminActions({required this.product});

  @override
  Widget build(BuildContext context) {
    final isActive = product.isActive ?? true;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
        shape: BoxShape.circle,
      ),
      child: PopupMenuButton<String>(
        icon: Icon(CupertinoIcons.ellipsis_vertical, size: 22.sp),
        onSelected: (value) {
          if (value == 'delete') {
            showCupertinoDialog(
              context: context,
              builder: (ctx) => CupertinoAlertDialog(
                title: Text('delete_product'.tr()),
                content: Text('delete_confirm_msg'.tr()),
                actions: [
                  CupertinoDialogAction(child: Text('cancel'.tr()), onPressed: () => Navigator.pop(ctx)),
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
            context.read<AdminCubit>().toggleProductStatus(product.id, isActive);
          }
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 'toggle',
            child: Row(
              children: [
                Icon(
                  isActive ? CupertinoIcons.nosign : CupertinoIcons.checkmark_circle,
                  color: isActive ? Colors.orange : Colors.green,
                  size: 20.sp,
                ),
                SizedBox(width: 8.w),
                Text(isActive ? 'deactivate'.tr() : 'activate'.tr()),
              ],
            ),
          ),
          PopupMenuItem(
            value: 'delete',
            child: Row(
              children: [
                Icon(CupertinoIcons.trash, color: Colors.red, size: 20.sp),
                SizedBox(width: 8.w),
                Text('delete'.tr(), style: const TextStyle(color: Colors.red)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FavoriteAction extends StatelessWidget {
  final Product product;
  const _FavoriteAction({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
        shape: BoxShape.circle,
      ),
      child: FavoriteButton(
        productId: product.id,
        initialIsFavorite: product.isFavorite,
        size: 22.sp,
        padding: EdgeInsets.all(8.r),
      ),
    );
  }
}
