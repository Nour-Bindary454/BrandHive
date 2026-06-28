import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widgets/payment_card_item.dart';
import 'widgets/add_card_button.dart';
import 'widgets/fawry_pay_item.dart';

class PaymentMethodsView extends StatelessWidget {
  const PaymentMethodsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9FAFB),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2B2B2B)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Payment Methods',
          style: TextStyle(
            color: const Color(0xFF2B2B2B),
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Column(
          children: [
            PaymentCardItem(
              iconData: Icons.credit_card,
              iconColor: const Color(0xFFF5B041),
              iconBgColor: const Color(0xFF2D3748),
              cardNumber: '.... .... .... 4242',
              expiryDate: 'Visa - Expires 12/26',
              isDefault: true,
            ),
            SizedBox(height: 16.h),
            PaymentCardItem(
              iconData: Icons.credit_card,
              iconColor: const Color(0xFFF5B041),
              iconBgColor: const Color(0xFF8B5CF6),
              cardNumber: '.... .... .... 8888',
              expiryDate: 'Mastercard - Expires 03/25',
              isDefault: false,
            ),
            SizedBox(height: 24.h),
            const AddCardButton(),
            SizedBox(height: 24.h),
            const FawryPayItem(),
          ],
        ),
      ),
    );
  }
}
