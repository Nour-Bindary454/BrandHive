import 'package:brand/core/services/service_locator.dart';
import 'package:brand/features/checkout/data/models/order_item_model.dart';
import 'package:brand/features/checkout/presentation/viewmodels/checkout_cubit.dart';
import 'package:brand/features/checkout/presentation/viewmodels/checkout_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:brand/features/checkout/presentation/views/widgets/order_review_screen.dart';
import 'package:brand/features/checkout/presentation/views/widgets/order_success_screen.dart';
import 'package:brand/features/checkout/presentation/views/widgets/payment_method_screen.dart';
import 'package:brand/features/checkout/presentation/views/widgets/shipping_address_screen.dart';
import 'package:brand/features/checkout/presentation/views/widgets/checkout_bottom_bar.dart';
import 'package:brand/features/checkout/presentation/views/widgets/checkout_step_indicator.dart';
import 'package:brand/features/checkout/presentation/views/widgets/payment_webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';

class CheckoutScreen extends StatefulWidget {
  final List<OrderItemModel> items;
  final double subtotal;

  const CheckoutScreen({
    super.key,
    required this.items,
    required this.subtotal,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  /// Prevents the listener from firing navigation twice
  bool _navigated = false;

  void _navigateToSuccess(BuildContext context, CheckoutState state) {
    if (!mounted || _navigated) return;
    _navigated = true;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => OrderSuccessScreen(response: state.orderSuccessResult!),
      ),
      (route) => route.isFirst,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<CheckoutCubit>()
            ..initCheckout(items: widget.items, subtotal: widget.subtotal),
      child: BlocConsumer<CheckoutCubit, CheckoutState>(
        listenWhen: (prev, curr) {
          // Only re-evaluate when loading stops or result appears
          if (curr.isLoading) return false;
          if (curr.orderSuccessResult != prev.orderSuccessResult) return true;
          if (curr.paymentUrl != prev.paymentUrl) return true;
          if (curr.error != prev.error && curr.error != null) return true;
          return false;
        },
        listener: (context, state) {
          if (_navigated) return;

          // ── Paymob: has paymentUrl → show WebView then success
          if (state.orderSuccessResult != null && state.paymentUrl != null) {
            _navigated = true;
            final url = state.paymentUrl!;
            // Clear URL in cubit to avoid future re-fires
            context.read<CheckoutCubit>().clearPaymentUrl();

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PaymentWebViewScreen(
                  paymentUrl: url,
                  onPaymentFinished: (_) => Navigator.pop(context),
                ),
              ),
            ).then((_) {
              // After WebView is closed, go to success screen
              if (mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        OrderSuccessScreen(response: state.orderSuccessResult!),
                  ),
                  (route) => route.isFirst,
                );
              }
            });
            return;
          }

          // ── COD: no paymentUrl → navigate directly to success
          if (state.orderSuccessResult != null && state.paymentUrl == null) {
            _navigateToSuccess(context, state);
            return;
          }

          // ── Error
          if (state.error != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error!)));
          }
        },
        builder: (context, state) {
          final cubit = context.read<CheckoutCubit>();

          return Scaffold(
            bottomNavigationBar: CheckoutBottomBar(
              totalPrice: state.totalAmount,
              currentStep: state.currentStep,
              isLoading: state.isLoading,
              onNext: () {
                if (state.currentStep == 3) {
                  cubit.placeOrder();
                } else {
                  cubit.nextStep();
                }
              },
            ),
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            appBar: AppBar(
              title: BasicText(
                text: 'checkout'.tr(),
                fontSize: 18.sp,
                color:
                    Theme.of(context).textTheme.bodyLarge?.color ??
                    Colors.black,
                isBold: true,
                fontFamily: 'Outfit',
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              scrolledUnderElevation: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
                onPressed: () {
                  if (state.currentStep > 1) {
                    cubit.previousStep();
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
            ),
            body: Column(
              children: [
                CheckoutStepIndicator(currentStep: state.currentStep),
                SizedBox(height: 5.h),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _buildCurrentStepUI(state.currentStep),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCurrentStepUI(int currentStep) {
    switch (currentStep) {
      case 1:
        return const ShippingAddressScreen(key: ValueKey(1));
      case 2:
        return const PaymentMethodScreen(key: ValueKey(2));
      case 3:
        return const OrderReviewScreen(key: ValueKey(3));
      default:
        return const SizedBox.shrink();
    }
  }
}
