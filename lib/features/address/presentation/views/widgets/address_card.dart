import 'package:brand/features/address/data/models/address_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/sharedWidgets/basic_colors.dart';

class AddressCard extends StatelessWidget {
  final AddressModel address;
  final bool isDefault;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const AddressCard({
    super.key,
    required this.address,
    this.isDefault = false,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isDefault
                ? BasicColors.buttonColorDark
                : Colors.grey.shade300,
            width: isDefault ? 2 : 1,
          ),
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
            CircleAvatar(
              backgroundColor: const Color(0xFF2463EB).withOpacity(0.1),
              child: const Icon(
                Icons.location_on,
                color: BasicColors.buttonColorDark,
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      BasicText(
                        text: address.label.isNotEmpty
                            ? address.label
                            : 'Address',
                        fontSize: 16.sp,
                        color:
                            Theme.of(context).textTheme.bodyLarge?.color ??
                            Colors.black,
                        isBold: true,
                      ),
                      if (isDefault) ...[
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: BasicColors.buttonColorDark.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: BasicText(
                            text: 'Default',
                            fontSize: 10.sp,
                            color: BasicColors.buttonColorDark,
                            isBold: true,
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 6.h),
                  BasicText(
                    text: address.fullName,
                    fontSize: 14.sp,
                    color: Colors.grey.shade800,
                    isBold: false,
                  ),
                  SizedBox(height: 4.h),
                  BasicText(
                    text: address.phone,
                    fontSize: 14.sp,
                    color: Colors.grey.shade600,
                    isBold: false,
                  ),
                  SizedBox(height: 6.h),
                  BasicText(
                    text:
                        '${address.street}, ${address.city}, ${address.governorate}',
                    fontSize: 13.sp,
                    color: Colors.grey.shade600,
                    isBold: false,
                  ),
                  SizedBox(height: 2.h),
                  BasicText(
                    text: address.country,
                    fontSize: 13.sp,
                    color: Colors.grey.shade600,
                    isBold: false,
                  ),
                ],
              ),
            ),
            if (onEdit != null || onDelete != null)
              Column(
                children: [
                  if (onEdit != null)
                    IconButton(
                      icon: const Icon(Icons.edit_outlined, color: Colors.blue),
                      onPressed: onEdit,
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                    ),
                  if (onDelete != null) ...[
                    SizedBox(height: 12.h),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: onDelete,
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ],
              ),
          ],
        ),
      ),
    );
  }
}
