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
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open payment URL')),
        );
      }
    }
  }

  void _showCancelDialog(BuildContext context, OrdersCubit cubit) {
    final reasonController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('cancel_order'.tr()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('are_you_sure_cancel_order'.tr()),
            SizedBox(height: 10.h),
            TextField(
              controller: reasonController,
              decoration: InputDecoration(
                hintText: 'reason_optional'.tr(),
                border: const OutlineInputBorder(),
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
          color: Colors.black,
          text: 'order_details'.tr(),
          fontSize: 18.sp,
          isBold: true,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor:
            Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
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
              child: BasicText(
                isBold: false,
                text: state.message,
                color: Colors.red,
                fontSize: 14.sp,
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
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order Summary Card
                  Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BasicText(
                              color: BasicColors.black,
                              text:
                                  'Order #${order.orderNumber ?? order.id?.substring(0, 8)}',
                              fontSize: 16.sp,
                              isBold: true,
                            ),
                            BasicText(
                              text: (order.status ?? 'pending').toUpperCase(),
                              fontSize: 14.sp,
                              color: BasicColors.buttonColorDark,
                              isBold: true,
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        if (order.createdAt != null)
                          BasicText(
                            isBold: false,
                            text: DateFormat(
                              'dd MMM yyyy, hh:mm a',
                            ).format(order.createdAt!),
                            fontSize: 12.sp,
                            color: Colors.grey.shade600,
                          ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),
                  BasicText(
                    color: BasicColors.black,
                    text: 'tracking_history'.tr(),
                    fontSize: 16.sp,
                    isBold: true,
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child:
                        order.statusHistory != null &&
                            order.statusHistory!.isNotEmpty
                        ? StatusTimeline(history: order.statusHistory!)
                        : BasicText(
                            fontSize: 16.sp,
                            isBold: false,

                            text: 'no_history_available'.tr(),
                            color: Colors.grey,
                          ),
                  ),

                  SizedBox(height: 20.h),
                  BasicText(
                    color: BasicColors.black,
                    text: 'shipping_address'.tr(),
                    fontSize: 16.sp,
                    isBold: true,
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BasicText(
                          color: BasicColors.black,
                          fontSize: 16.sp,
                          text: order.shippingAddress.fullName,
                          isBold: true,
                        ),
                        SizedBox(height: 4.h),
                        BasicText(
                          isBold: false,
                          fontSize: 16.sp,
                          text: order.shippingAddress.phone,
                          color: Colors.grey.shade700,
                        ),
                        SizedBox(height: 4.h),
                        BasicText(
                          fontSize: 16.sp,
                          isBold: false,
                          text:
                              '${order.shippingAddress.street}, ${order.shippingAddress.city}, ${order.shippingAddress.governorate}',
                          color: Colors.grey.shade700,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),
                  BasicText(
                    color: BasicColors.black,
                    text: 'items'.tr(),
                    fontSize: 16.sp,
                    isBold: true,
                  ),
                  SizedBox(height: 10.h),
                  ...order.items
                      .map(
                        (item) => Container(
                          margin: EdgeInsets.only(bottom: 10.h),
                          padding: EdgeInsets.all(12.r),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            children: [
                              if (item.productImage != null)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.r),
                                  child: Image.network(
                                    item.productImage!,
                                    width: 60.w,
                                    height: 60.w,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        const Icon(Icons.image_not_supported),
                                  ),
                                ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BasicText(
                                      text: item.productName,
                                      fontSize: 14.sp,
                                      isBold: true,
                                      color: BasicColors.black,
                                    ),
                                    SizedBox(height: 4.h),
                                    BasicText(
                                      text: 'Qty: ${item.quantity}',
                                      fontSize: 12.sp,
                                      color: Colors.grey,
                                      isBold: false,
                                    ),
                                  ],
                                ),
                              ),
                              BasicText(
                                text:
                                    'EGP ${item.itemTotal.toStringAsFixed(2)}',
                                fontSize: 14.sp,
                                isBold: true,
                                color: BasicColors.buttonColorDark,
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),

                  SizedBox(height: 20.h),
                  // Actions
                  if (isPending) ...[
                    if (isPaymob && isPaymentFailed) ...[
                      SizedBox(
                        width: double.infinity,
                        child: BasicButton(
                          text: 'retry_payment'.tr(),
                          onPressed: () => context
                              .read<OrdersCubit>()
                              .retryPayment(order.id!),
                          colors: const [BasicColors.buttonColorDark],
                          radius: 12.r,
                        ),
                      ),
                      SizedBox(height: 12.h),
                    ],
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => _showCancelDialog(
                          context,
                          context.read<OrdersCubit>(),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          side: const BorderSide(color: Colors.red),
                        ),
                        child: BasicText(
                          fontSize: 16.sp,
                          text: 'cancel_order'.tr(),
                          color: Colors.red,
                          isBold: true,
                        ),
                      ),
                    ),
                  ],
                  SizedBox(height: 30.h),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
