import 'package:easy_localization/easy_localization.dart';
import 'package:brand/features/checkout/presentation/views/widgets/order_review_screen.dart';
import 'package:brand/features/checkout/presentation/views/widgets/order_success_screen.dart';
import 'package:brand/features/checkout/presentation/views/widgets/payment_method_screen.dart';
import 'package:brand/features/checkout/presentation/views/widgets/shipping_address_screen.dart';
import 'package:brand/features/checkout/presentation/views/widgets/checkout_bottom_bar.dart';
import 'package:brand/features/checkout/presentation/views/widgets/checkout_step_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int currentStep = 1;

  void nextStep() {
    if (currentStep < 3) {
      setState(() {
        currentStep++;
      });
    } else {
      // 👇 هنا الانتقال لشاشة النجاح
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => OrderSuccessScreen()),
      );
    }
  }

  void previousStep() {
    if (currentStep > 1) {
      setState(() {
        currentStep--;
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CheckoutBottomBar(
        totalPrice: 100,
        currentStep: currentStep,
        onNext: nextStep,
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: BasicText(
          text: 'checkout'.tr(),
          fontSize: 18.sp,
          color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
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
          onPressed: previousStep,
        ),
      ),

      body: Column(
        children: [
          CheckoutStepIndicator(currentStep: currentStep),
          SizedBox(height: 5.h),

          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _buildCurrentStepUI(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentStepUI() {
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
