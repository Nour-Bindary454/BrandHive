import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/utils/toast/toast.dart';
import 'package:brand/features/checkout/data/models/order_model.dart';
import 'package:brand/features/seller/orders/widgets/management_order_card.dart';
import 'package:brand/features/seller/orders/widgets/order_status.dart';
import 'package:brand/features/seller/presentation/view_model/seller_cubit.dart';
import 'package:brand/features/seller/presentation/view_model/seller_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final List<String> _filterLabels = ['All', 'Pending', 'Processing', 'Completed', 'Canceled'];
  final List<String?> _filterValues = [null, 'pending', 'processing', 'completed', 'cancelled'];
  int _selectedFilterIndex = 0;

  OrderStatus _mapStatus(String? status) {
    switch ((status ?? '').toLowerCase()) {
      case 'processing':
        return OrderStatus.processing;
      case 'completed':
      case 'delivered':
        return OrderStatus.completed;
      case 'cancelled':
      case 'canceled':
        return OrderStatus.canceled;
      default:
        return OrderStatus.pending;
    }
  }

  String _timeAgo(DateTime? dt) {
    if (dt == null) return '';
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return '${diff.inMinutes} mins ago';
    if (diff.inHours < 24) return '${diff.inHours} hours ago';
    if (diff.inDays == 1) return 'Yesterday';
    return '${diff.inDays} days ago';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        bottom: false,
        child: BlocConsumer<SellerCubit, SellerState>(
          listener: (context, state) {
            if (state is SellerOrdersFailure) {
              Toast.showErrorToast(msg: state.error, context: context);
            }
          },
          builder: (context, state) {
            final cubit = context.read<SellerCubit>();
            final isLoading = state is SellerOrdersLoading && cubit.orders.isEmpty;

            // Local filter
            final filterStatus = _filterValues[_selectedFilterIndex];
            final List<OrderModel> displayOrders = filterStatus == null
                ? cubit.orders
                : cubit.orders
                    .where((o) => (o.status ?? '').toLowerCase() == filterStatus)
                    .toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: BasicText(
                    text: 'orders_management'.tr(),
                    fontSize: 18,
                    color: const Color(0xFF0F172A),
                    isBold: true,
                  ),
                ),
                SizedBox(height: 15.h),

                // ── Filter Chips ──
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: List.generate(_filterLabels.length, (i) {
                      final isSelected = i == _selectedFilterIndex;
                      return GestureDetector(
                        onTap: () {
                          setState(() => _selectedFilterIndex = i);
                          // Optionally re-fetch from server with status param:
                          // cubit.getOrders(status: _filterValues[i]);
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 10.w),
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFF2D4373) : Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: isSelected ? const Color(0xFF2D4373) : Colors.grey.shade300,
                            ),
                          ),
                          child: BasicText(
                            text: _filterLabels[i],
                            fontSize: 12,
                            color: isSelected ? Colors.white : const Color(0xFF475467),
                            isBold: true,
                          ),
                        ),
                      );
                    }),
                  ),
                ),

                SizedBox(height: 5.h),

                // ── Orders List ──
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => cubit.getOrders(status: _filterValues[_selectedFilterIndex]),
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator(color: Color(0xFF2D4373)))
                        : displayOrders.isEmpty
                            ? _buildEmptyState()
                            : ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                padding: EdgeInsets.only(top: 15.h, bottom: 100.h),
                                itemCount: displayOrders.length,
                                itemBuilder: (context, index) {
                                  final order = displayOrders[index];
                                  return ManagementOrderCard(
                                    orderId: order.orderNumber ?? '#${order.id?.substring(0, 8) ?? '0000'}',
                                    timeAgo: _timeAgo(order.createdAt),
                                    customerName: order.shippingAddress.fullName,
                                    itemsCount: order.items.length.toString(),
                                    price: order.total.toStringAsFixed(0),
                                    status: _mapStatus(order.status),
                                  );
                                },
                              ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 120.h),
        Center(
          child: Column(
            children: [
              Icon(Icons.receipt_long_outlined, size: 64.sp, color: Colors.grey.shade400),
              SizedBox(height: 16.h),
              BasicText(
                text: 'No orders found',
                fontSize: 16,
                color: Colors.grey.shade600,
                isBold: true,
              ),
              SizedBox(height: 8.h),
              BasicText(
                text: 'Orders will appear here once customers start buying.',
                fontSize: 12,
                color: Colors.grey.shade500,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
