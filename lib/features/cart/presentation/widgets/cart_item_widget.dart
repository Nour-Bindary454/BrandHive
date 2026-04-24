import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/sharedWidgets/basic_colors.dart';
import '../../data/model/cart_item_model.dart';
import '../viewmodel/cart_view_model.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemModel item;

  const CartItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: BasicColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.network(
              item.image,
              width: 80.w,
              height: 100.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 14.w),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.name,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: BasicColors.black,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    GestureDetector(
                      onTap: () =>
                          context.read<CartViewModel>().removeItem(item.id),
                      child: Icon(
                        Icons.delete_outline,
                        color: Colors.grey,
                        size: 20.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  item.brand,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${item.price.toStringAsFixed(0)} EGP',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                        color: BasicColors.buttonColorDark,
                      ),
                    ),
                    _buildQuantityControls(context),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityControls(BuildContext context) {
    return Row(
      children: [
        _buildControlButton(
          icon: Icons.remove,
          onTap: item.quantity > 1
              ? () => context.read<CartViewModel>().updateQuantity(
                  item.id,
                  item.quantity - 1,
                )
              : null,
        ),
        SizedBox(width: 12.w),
        Text(
          '${item.quantity}',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: BasicColors.black,
          ),
        ),
        SizedBox(width: 12.w),
        _buildControlButton(
          icon: Icons.add,
          onTap: () => context.read<CartViewModel>().updateQuantity(
            item.id,
            item.quantity + 1,
          ),
        ),
      ],
    );
  }

  Widget _buildControlButton({required IconData icon, VoidCallback? onTap}) {
    final bool isEnabled = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(4.r),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isEnabled
                ? Colors.grey.withOpacity(0.3)
                : Colors.transparent,
          ),
        ),
        child: Icon(
          icon,
          size: 16.sp,
          color: isEnabled ? BasicColors.black : Colors.grey.withOpacity(0.3),
        ),
      ),
    );
  }
}
