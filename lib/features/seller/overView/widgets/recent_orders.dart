import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/features/main_layout/presentation/view_model/nav_cubit.dart';
import 'package:brand/features/seller/overView/widgets/order_card.dart';
import 'package:brand/features/seller/presentation/view_model/seller_cubit.dart';
import 'package:brand/features/seller/presentation/view_model/seller_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecentOrders extends StatelessWidget {
  const RecentOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellerCubit, SellerState>(
      builder: (context, state) {
        final cubit = context.read<SellerCubit>();
        final recentOrders = cubit.dashboardData?.recentOrders ?? [];

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BasicText(
                    text: 'recent_orders'.tr(),
                    fontSize: 16,
                    color: const Color(0xFF0F172A),
                    isBold: true,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Switch to the Orders tab (index 3)
                      context.read<LayoutCubit>().changeIndex(3);
                    },
                    child: BasicText(
                      text: 'view_all'.tr(),
                      fontSize: 12,
                      color: const Color(0xFF5384DB),
                      isBold: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              if (recentOrders.isEmpty)
                Container(
                  padding: EdgeInsets.symmetric(vertical: 30.h),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Center(
                    child: BasicText(
                      text: 'No recent orders yet',
                      fontSize: 13,
                      color: Colors.grey.shade500,
                    ),
                  ),
                )
              else
                ...recentOrders.take(3).map((order) {
                  final customerName = order.shippingAddress.fullName;
                  final avatarInitials = customerName.isNotEmpty
                      ? customerName.split(' ').map((e) => e[0]).take(2).join().toUpperCase()
                      : 'C';
                  
                  return OrderCard(
                    name: customerName,
                    avatar: avatarInitials,
                    orderNo: order.orderNumber ?? order.id?.substring(0, 5) ?? '0000',
                    items: order.items.length.toString(),
                    price: order.total.toStringAsFixed(0),
                    status: order.status ?? 'pending',
                  );
                }),
            ],
          ),
        );
      },
    );
  }
}
