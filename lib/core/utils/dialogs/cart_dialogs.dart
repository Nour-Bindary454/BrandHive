import 'package:brand/core/sharedWidgets/basic_button.dart';
import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/utils/toast/toast.dart';
import 'package:brand/features/cart/presentation/viewmodel/cart_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartDialogs {
  static void showAddToCartDialog({
    required BuildContext context,
    required String productId,
    required String productName,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: BasicText(
          color: Colors.black,
          text: 'add_to_cart'.tr(),
          fontSize: 18.sp,
          isBold: true,
        ),
        content: BasicText(
          color: BasicColors.black,
          isBold: false,
          text: 'Are you sure you want to add "$productName" to your cart?',
          fontSize: 14.sp,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'cancel'.tr(),
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          SizedBox(
            width: 100.w,
            child: BasicButton(
              text: 'add'.tr(),
              onPressed: () {
                context.read<CartViewModel>().addToCart(productId);
                Navigator.pop(context);
                Toast.showSuccessToast(
                  msg: 'added_to_cart_success'.tr(),
                  context: context,
                );
              },
              colors: const [BasicColors.buttonColorDark],
              radius: 12.r,
            ),
          ),
        ],
      ),
    );
  }
}
