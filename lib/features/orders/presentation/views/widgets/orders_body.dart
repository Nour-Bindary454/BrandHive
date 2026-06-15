import 'package:brand/core/sharedWidgets/backarrow.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/features/orders/presentation/view_model/orders_cubit.dart';
import 'package:brand/features/orders/presentation/view_model/orders_state.dart';
import 'package:brand/features/orders/presentation/views/widgets/orders_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BasicText(
                      text: "My Orders",
                      fontSize: 20.sp,
                      color: const Color(0xFF1E293B),
                      isBold: true,
                    ),
                    BlocBuilder<OrdersCubit, OrdersState>(
                      builder: (context, state) {
                        String countStr = "";
                        if (state is OrdersSuccess) {
                          final count = state.orders.length;
                          countStr = "$count ${count == 1 ? 'order' : 'orders'}";
                        } else if (state is OrdersLoading) {
                          countStr = "Loading...";
                        }
                        return BasicText(
                          text: countStr,
                          fontSize: 13.sp,
                          color: const Color(0xFF64748B),
                          isBold: false,
                        );
                      },
                    ),
                  ],
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
                  return const Center(
                    child: CircularProgressIndicator(color: Color(0xFF2D4373)),
                  );
                }
                if (state is OrdersError) {
                  return Center(
                    child: BasicText(
                      text: state.errMessage,
                      fontSize: 14.sp,
                      color: Colors.red,
                      isBold: false,
                    ),
                  );
                }
                if (state is OrdersSuccess) {
                  final orders = state.orders;
                  if (orders.isEmpty) {
                    return Center(
                      child: BasicText(
                        text: "You don't have any orders yet.",
                        fontSize: 15.sp,
                        color: const Color(0xFF64748B),
                        isBold: false,
                      ),
                    );
                  }
                  return OrdersListView(orders: orders);
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
