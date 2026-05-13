import 'package:brand/core/sharedWidgets/basic_colors.dart';
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
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Row(
              children: [
                const CustomBackarrow(),
                SizedBox(width: 15.w),
                Expanded(
                  child: BlocBuilder<OrdersCubit, OrdersState>(
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
                            fontSize: 22.sp,
                            color: BasicColors.black,
                            isBold: true,
                            fontFamily: 'Outfit',
                          ),
                          BasicText(
                            text: "$count ${'orders'.tr()}",
                            fontSize: 13.sp,
                            color: Colors.grey,
                            isBold: false,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),

          // List
          Expanded(
            child: BlocBuilder<OrdersCubit, OrdersState>(
              builder: (context, state) {
                if (state is OrdersLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is OrdersError) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.r),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 50,
                          ),
                          SizedBox(height: 10.h),
                          Text(state.message, textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  );
                } else if (state is OrdersLoaded) {
                  if (state.orders.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_bag_outlined,
                            size: 80.sp,
                            color: Colors.grey.shade300,
                          ),
                          SizedBox(height: 16.h),
                          BasicText(
                            text: 'no_orders_found'.tr(),
                            fontSize: 16.sp,
                            color: Colors.grey,
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
                      padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 20.h),
                      physics: const BouncingScrollPhysics(),
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
