import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SharedOrderItemModel {
  final String productImage;
  final String productName;
  final int quantity;
  final double unitPrice;

  SharedOrderItemModel({
    required this.productImage,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
  });
}

class SharedOrderDetailsView extends StatelessWidget {
  final String orderNumber;
  final String status;
  final String paymentMethod;
  final String createdAt;
  final String userEmail;
  final double total;
  final List<SharedOrderItemModel> items;
  final VoidCallback? onStatusTap;

  const SharedOrderDetailsView({
    super.key,
    required this.orderNumber,
    required this.status,
    required this.paymentMethod,
    required this.createdAt,
    required this.userEmail,
    required this.total,
    required this.items,
    this.onStatusTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 18.sp, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Order Details'.tr(),
          style: TextStyle(
            color: const Color(0xFF1E293B),
            fontFamily: 'Poppins',
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderInfoCard(),
            SizedBox(height: 16.h),
            _buildSectionTitle("Customer Info"),
            _buildCustomerCard(),
            SizedBox(height: 16.h),
            _buildSectionTitle("Order Items"),
            _buildItemsList(),
            SizedBox(height: 16.h),
            _buildSectionTitle("Order Summary"),
            _buildSummaryCard(),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h, left: 4.w),
      child: BasicText(
        text: title,
        fontSize: 14.sp,
        isBold: true,
        color: const Color(0xFF1E293B),
      ),
    );
  }

  Widget _buildOrderInfoCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          _infoRow("Order ID", orderNumber),
          const Divider(height: 20),
          _infoRow("Status", status.toUpperCase(), isStatus: true),
          const Divider(height: 20),
          _infoRow("Payment", paymentMethod.toUpperCase()),
          const Divider(height: 20),
          _infoRow("Created At", createdAt),
        ],
      ),
    );
  }

  Widget _buildCustomerCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          _infoRow("Email", userEmail),
        ],
      ),
    );
  }

  Widget _buildItemsList() {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: _cardDecoration(),
      child: Column(
        children: items.map((item) => _buildItemRow(item)).toList(),
      ),
    );
  }

  Widget _buildItemRow(SharedOrderItemModel item) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.network(
              item.productImage,
              width: 50.w,
              height: 50.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BasicText(
                  text: item.productName,
                  fontSize: 13.sp,
                  isBold: true,
                  color: Colors.black,
                ),
                SizedBox(height: 2.h),
                BasicText(
                  text: "Qty: ${item.quantity} × ${item.unitPrice} EGP",
                  fontSize: 11.sp,
                  color: Colors.grey,
                  isBold: false,
                ),
              ],
            ),
          ),
          BasicText(
            color: Colors.black,
            text: "${(item.quantity * item.unitPrice).toStringAsFixed(0)} EGP",
            fontSize: 13.sp,
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          _infoRow("Subtotal", "${total.toStringAsFixed(0)} EGP"),
          const Divider(height: 20),
          _infoRow("Shipping", "0 EGP"),
          const Divider(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BasicText(
                color: Colors.black,
                text: "Total",
                fontSize: 16.sp,
                isBold: true,
              ),
              BasicText(
                text: "${total.toStringAsFixed(0)} EGP",
                fontSize: 16.sp,
                isBold: true,
                color: const Color(0xFF2D4373),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value, {bool isStatus = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BasicText(
            text: label,
            fontSize: 13.sp,
            color: const Color(0xFF64748B),
            isBold: false),
        SizedBox(width: 15.w),
        Flexible(
          child: isStatus
              ? GestureDetector(
                  onTap: onStatusTap,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D4373).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BasicText(
                          text: value,
                          fontSize: 11.sp,
                          color: const Color(0xFF2D4373),
                          isBold: true,
                        ),
                        if (onStatusTap != null) ...[
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.edit_note,
                            size: 14.sp,
                            color: const Color(0xFF2D4373),
                          ),
                        ],
                      ],
                    ),
                  ),
                )
              : BasicText(
                  text: value,
                  fontSize: 13.sp,
                  isBold: true,
                  color: Colors.black,
                  textAlign: TextAlign.end,
                ),
        ),
      ],
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.r),
      border: Border.all(color: const Color(0xFFE2E8F0)),
    );
  }
}
