import 'package:brand/features/profile/data/models/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'menu_item_tile.dart';
import '../../../../../core/sharedWidgets/basic_colors.dart';

class MenuListSection extends StatelessWidget {
  final List<MenuItemModel> items;

  const MenuListSection({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: BasicColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
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
          color: BasicColors.grey.withOpacity(0.1),
          indent: 56.w, // Match icon offset
          endIndent: 20.w,
        ),
        itemBuilder: (context, index) {
          final item = items[index];
          return MenuItemTile(
            item: item,
            onTap: () {
              if (item.title == 'Payment Methods') {
                Navigator.pushNamed(context, '/paymentMethods');
              } else if (item.title == 'Wishlist') {
                Navigator.pushNamed(context, '/wishlist');
              } else {
                // Handle other taps
              }
            },
          );
        },
      ),
    );
  }
}
