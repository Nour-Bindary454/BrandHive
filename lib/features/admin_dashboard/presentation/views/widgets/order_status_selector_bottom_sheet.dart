import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderStatusSelectorBottomSheet extends StatelessWidget {
  final String currentStatus;
  final ValueChanged<String> onStatusSelected;

  const OrderStatusSelectorBottomSheet({
    super.key,
    required this.currentStatus,
    required this.onStatusSelected,
  });

  static const List<Map<String, dynamic>> _statusOptions = [
    {'label': 'Pending', 'value': 'pending', 'color': Colors.orange, 'icon': Icons.hourglass_empty},
    {'label': 'Confirmed', 'value': 'confirmed', 'color': Colors.blue, 'icon': Icons.check_circle_outline},
    {'label': 'Shipped', 'value': 'shipped', 'color': Colors.purple, 'icon': Icons.local_shipping_outlined},
    {'label': 'Delivered', 'value': 'delivered', 'color': Colors.green, 'icon': Icons.done_all},
    {'label': 'Cancelled', 'value': 'cancelled', 'color': Colors.red, 'icon': Icons.cancel_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BasicText(
                text: 'Change Order Status'.tr(),
                fontSize: 16.sp,
                isBold: true,
                color: const Color(0xFF1E293B),
              ),
              IconButton(
                icon: Icon(Icons.close, size: 20.sp, color: Colors.grey),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _statusOptions.length,
              separatorBuilder: (context, index) => SizedBox(height: 8.h),
              itemBuilder: (context, index) {
                final option = _statusOptions[index];
                final isSelected = currentStatus.toLowerCase() == option['value'];
                final color = option['color'] as Color;

                return InkWell(
                  onTap: () => onStatusSelected(option['value']),
                  borderRadius: BorderRadius.circular(16.r),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                    decoration: BoxDecoration(
                      color: isSelected ? color.withValues(alpha: 0.08) : const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: isSelected ? color : const Color(0xFFE2E8F0),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(option['icon'] as IconData, color: isSelected ? color : const Color(0xFF64748B), size: 20.sp),
                        SizedBox(width: 14.w),
                        Expanded(
                          child: BasicText(
                            text: (option['label'] as String).tr(),
                            fontSize: 13.sp,
                            isBold: isSelected,
                            color: isSelected ? color : const Color(0xFF1E293B),
                          ),
                        ),
                        if (isSelected)
                          Icon(Icons.check, color: color, size: 20.sp),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
