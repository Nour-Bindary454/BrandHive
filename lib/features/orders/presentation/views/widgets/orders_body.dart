import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/backarrow.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/features/orders/presentation/viewmodels/orders_cubit.dart';
import 'package:brand/features/orders/presentation/viewmodels/orders_state.dart';
import 'package:brand/features/orders/presentation/views/widgets/order_card.dart';
import 'package:brand/features/orders/presentation/views/order_details_view.dart';

class OrdersBody extends StatelessWidget {
  const OrdersBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 10.h),
          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                const CustomBackarrow(),
                SizedBox(width: 15.w),
                BlocBuilder<OrdersCubit, OrdersState>(
                  builder: (context, state) {
                    int count = 0;
                    if (state is OrdersLoaded) {
                      count = state.orders.length;
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BasicText(
                          text: "my_orders".tr(),
                          fontSize: 20.sp,
                          color: const Color(0xFF1E293B),
                          isBold: true,
                        ),
                        BasicText(
                          text: "$count ${'orders'.tr()}",
                          fontSize: 13.sp,
                          color: const Color(0xFF64748B),
                          isBold: false,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),

          // Divider
          const Divider(color: Color(0xFFF1F5F9), thickness: 1, height: 1),

          // List
          Expanded(
            child: BlocBuilder<OrdersCubit, OrdersState>(
              builder: (context, state) {
                if (state is OrdersLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is OrdersError) {
                  return Center(
                    child: BasicText(
                      text: state.message,
                      fontSize: 14.sp,
                      color: Colors.red,
                      isBold: false,
                    ),
                  );
                } else if (state is OrdersLoaded) {
                  if (state.orders.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.inventory_2_outlined, size: 80.sp, color: Colors.grey),
                          SizedBox(height: 16.h),
                          BasicText(
                            text: 'no_orders_found'.tr(),
                            fontSize: 16.sp,
                            color: Colors.grey.shade700,
                            isBold: true,
                          ),
                        ],
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      await context.read<OrdersCubit>().fetchMyOrders();
                    },
                    child: ListView.builder(
                      padding: EdgeInsets.all(20.w),
                      itemCount: state.orders.length,
                      itemBuilder: (context, index) {
                        final order = state.orders[index];
                        return OrderCard(
                          order: order,
                          onTap: () {
                            if (order.id != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    value: context.read<OrdersCubit>(),
                                    child: OrderDetailsView(orderId: order.id!),
                                  ),
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
