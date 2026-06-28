import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/sharedWidgets/basic_button.dart';
import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/features/orders/presentation/viewmodels/orders_cubit.dart';
import 'package:brand/features/orders/presentation/viewmodels/orders_state.dart';
import 'package:brand/features/orders/presentation/views/widgets/status_timeline.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailsView extends StatefulWidget {
  final String orderId;

  const OrderDetailsView({super.key, required this.orderId});

  @override
  State<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
  @override
  void initState() {
    super.initState();
    context.read<OrdersCubit>().fetchOrderDetails(widget.orderId);
  }

  void _openPaymentUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.inAppWebView);
    }
  }

  void _showCancelDialog(BuildContext context, OrdersCubit cubit) {
    final reasonController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Text(
          'cancel_order'.tr(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('are_you_sure_cancel_order'.tr()),
            SizedBox(height: 15.h),
            TextField(
              controller: reasonController,
              decoration: InputDecoration(
                hintText: 'reason_optional'.tr(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'back'.tr(),
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              cubit.cancelOrder(widget.orderId, reasonController.text);
            },
            child: Text(
              'confirm_cancel'.tr(),
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: BasicText(
          color: BasicColors.black,
          text: 'order_details'.tr(),
          fontSize: 18.sp,
          isBold: true,
          fontFamily: 'Outfit',
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocConsumer<OrdersCubit, OrdersState>(
        listener: (context, state) {
          if (state is OrderActionError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is OrderActionSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is PaymentRetrySuccess) {
            _openPaymentUrl(state.paymentUrl);
          }
        },
        builder: (context, state) {
          if (state is OrderDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrderDetailsError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (state is OrderDetailsLoaded) {
            final order = state.order;
            final isPending = order.status?.toLowerCase() == 'pending';
            final isPaymentFailed =
                order.paymentStatus?.toLowerCase() == 'failed' ||
                order.paymentStatus?.toLowerCase() == 'pending';
            final isPaymob = order.paymentMethod.toLowerCase() == 'paymob';

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 30.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order Summary Card
                  Container(
                    padding: EdgeInsets.all(20.r),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Order #${order.orderNumber ?? order.id?.substring(0, 8)}',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w900,
                                fontFamily: 'Outfit',
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: BasicColors.buttonColorLight.withOpacity(
                                  0.1,
                                ),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Text(
                                (order.status ?? 'pending').toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                  color: BasicColors.buttonColorLight,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        if (order.createdAt != null)
                          Text(
                            DateFormat(
                              'dd MMM yyyy, hh:mm a',
                            ).format(order.createdAt!),
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),
                  _sectionTitle('tracking_history'.tr()),
                  SizedBox(height: 12.h),
                  Container(
                    padding: EdgeInsets.all(20.r),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child:
                        order.statusHistory != null &&
                            order.statusHistory!.isNotEmpty
                        ? StatusTimeline(history: order.statusHistory!)
                        : Center(
                            child: Text(
                              'no_history_available'.tr(),
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ),
                  ),

                  SizedBox(height: 24.h),
                  _sectionTitle('shipping_address'.tr()),
                  SizedBox(height: 12.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.r),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.shippingAddress.fullName,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          order.shippingAddress.phone,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          '${order.shippingAddress.street}, ${order.shippingAddress.city}, ${order.shippingAddress.governorate}',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.grey.shade700,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),
                  _sectionTitle('items'.tr()),
                  SizedBox(height: 12.h),
                  ...order.items
                      .map(
                        (item) => Container(
                          margin: EdgeInsets.only(bottom: 12.h),
                          padding: EdgeInsets.all(16.r),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Row(
                            children: [
                              if (item.productImage != null)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: Image.network(
                                    item.productImage!,
                                    width: 60.w,
                                    height: 60.w,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              SizedBox(width: 15.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.productName,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      'Qty: ${item.quantity}',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '${item.itemTotal.toStringAsFixed(0)} EGP',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w900,
                                  color: BasicColors.buttonColorLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),

                  SizedBox(height: 24.h),
                  const Divider(),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _sectionTitle('total_amount'.tr()),
                      Text(
                        '${order.total.toStringAsFixed(0)} EGP',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w900,
                          color: BasicColors.buttonColorLight,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 32.h),
                  // Actions
                  if (isPending) ...[
                    if (isPaymob && isPaymentFailed) ...[
                      BasicButton(
                        text: 'retry_payment'.tr(),
                        onPressed: () => context.read<OrdersCubit>().retryPayment(order.id!),
                        colors: const [BasicColors.linearGradientDark, BasicColors.linearGradientLight],
                        radius: 25.r,
                      ),
                      SizedBox(height: 12.h),
                      // Simulate success for testing
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () => context.read<OrdersCubit>().simulatePaymentSuccess(order.id!, order.total),
                          child: const Text('Simulate Success (Dev Only)', style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
                        ),
                      ),
                      SizedBox(height: 12.h),
                    ],
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => _showCancelDialog(context, context.read<OrdersCubit>()),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          side: const BorderSide(color: Colors.red, width: 1.5),
                        ),
                        child: Text(
                          'cancel_order'.tr(),
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                  SizedBox(height: 40.h),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w900,
        fontFamily: 'Outfit',
      ),
    );
  }
}
