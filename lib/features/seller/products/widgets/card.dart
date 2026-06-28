import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/utils/appImages/png_images.dart';
import 'package:brand/features/seller/data/model/seller_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SellerProductCard extends StatelessWidget {
  final SellerProductModel product;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const SellerProductCard({
    super.key,
    required this.product,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 110.h,
        padding: EdgeInsets.only(left: 9.w),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        child: Row(
          children: [
            // Image Section
            Container(
              width: 90.w,
              height: 90.h,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.all(Radius.circular(16.r)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16.r)),
                child: product.image.startsWith('http')
                    ? Image.network(
                        product.image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.image_not_supported, color: Colors.grey),
                      )
                    : Image.asset(
                        PngImages.fashion, // Fallback asset
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.image_not_supported, color: Colors.grey),
                      ),
              ),
            ),
            SizedBox(width: 15.w),

            // Details Section
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BasicText(
                      text: product.name,
                      fontSize: 14,
                      color: BasicColors.buttonColorDark,
                      isBold: true,
                      maxLines: 1,
                    ),
                    SizedBox(height: 4.h),
                    BasicText(
                      text: product.categoryName.isNotEmpty ? product.categoryName : 'Product',
                      fontSize: 11,
                      color: Colors.blueGrey.shade400,
                      isBold: true,
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BasicText(
                          text: '${product.price.toStringAsFixed(0)} EGP',
                          fontSize: 16,
                          color: BasicColors.buttonColorLight,
                          isBold: true,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 15.w),
                          child: BasicText(
                            text: 'Stock: ${product.stock}',
                            fontSize: 12,
                            color: product.stock < 5 ? Colors.red : Colors.grey.shade600,
                            isBold: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Delete Icon Section
            Padding(
              padding: EdgeInsets.only(right: 15.w),
              child: GestureDetector(
                onTap: (onDelete),
                child: Image.asset(
                  PngImages.trash,
                  width: 20.r,
                  height: 20.r,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
