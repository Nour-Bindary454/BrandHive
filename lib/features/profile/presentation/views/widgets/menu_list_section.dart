import 'package:brand/features/profile/data/models/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'menu_item_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:brand/features/wishlist/presentation/viewsModel/wishlist_cubit.dart';

class MenuListSection extends StatelessWidget {
  final List<MenuItemModel> items;

  const MenuListSection({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color:
                (Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black)
                    .withOpacity(0.02),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: items.length,
        separatorBuilder: (context, index) => Divider(
          height: 1,
          thickness: 1,
          color: (Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black)
              .withOpacity(0.1),
          indent: 56.w, // Match icon offset
          endIndent: 20.w,
        ),
        itemBuilder: (context, index) {
          final item = items[index];
          String? badgeText = item.badgeText;

          if (item.title == 'wishlist'.tr()) {
            final wishlistCount = context
                .watch<WishlistCubit>()
                .wishlistedProductIds
                .length;
            badgeText = '$wishlistCount items';
          }

          final displayItem = MenuItemModel(
            title: item.title,
            icon: item.icon,
            badgeText: badgeText,
            isBadgeRed: item.isBadgeRed,
          );

          return MenuItemTile(
            item: displayItem,
            onTap: () {
              if (item.title == 'payment_methods'.tr()) {
                Navigator.pushNamed(context, '/paymentMethods');
              } else if (item.title == 'wishlist'.tr()) {
                Navigator.pushNamed(context, '/wishlist');
              } else if (item.title == 'my_orders'.tr()) {
                Navigator.pushNamed(context, '/orders');
              } else if (item.title == 'notifications'.tr()) {
                Navigator.pushNamed(context, '/notifications');
              } else if (item.title == 'settings'.tr()) {
                Navigator.pushNamed(context, '/settings');
              } else if (item.title == 'help_support'.tr()) {
                Navigator.pushNamed(context, '/helpSupport');
              }
            },
          );
        },
      ),
    );
  }
}
