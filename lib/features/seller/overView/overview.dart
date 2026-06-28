import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/features/seller/data/model/seller_models.dart';
import 'package:brand/features/seller/overView/widgets/market_trends_section.dart';
import 'package:brand/features/seller/overView/widgets/product_insights_section.dart';
import 'package:brand/features/seller/overView/widgets/overview_header.dart';
import 'package:brand/features/seller/overView/widgets/pro_tip_card.dart';
import 'package:brand/features/seller/overView/widgets/recent_orders.dart';
import 'package:brand/features/seller/overView/widgets/store_analytics.dart';
import 'package:brand/features/seller/presentation/view_model/seller_cubit.dart';
import 'package:brand/features/seller/presentation/view_model/seller_states.dart';
import 'package:brand/features/seller/presentation/views/my_bazaar_screen.dart';
import 'package:brand/core/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Overview extends StatefulWidget {
  const Overview({super.key});

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: () async {
            final cubit = context.read<SellerCubit>();
            await cubit.getDashboard();
            await cubit.getProducts();
            await cubit.getOrders();
            await cubit.getStockAlerts();
            await cubit.getAnalytics();
            await cubit.getProductInsights();
          },
          child: BlocConsumer<SellerCubit, SellerState>(
            listener: (context, state) {
              if (state is SellerStockAdjustmentSuccess) {
                Toast.showSuccessToast(msg: state.message, context: context);
              } else if (state is SellerProductActionFailure) {
                Toast.showErrorToast(msg: state.error, context: context);
              }
            },
            builder: (context, state) {
              final cubit = context.read<SellerCubit>();
              final isLoading = state is SellerDashboardLoading && cubit.dashboardData == null;

              if (isLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: Color(0xFF2D4373)),
                );
              }

              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const OverviewHeader(),
                    _buildBazaarCard(context),
                    if (cubit.stockAlerts.isNotEmpty) ...[
                      _buildStockAlertsBanner(context, cubit.stockAlerts),
                    ],
                    const RecentOrders(),
                    const StoreAnalytics(),
                    const ProductInsightsSection(),
                    const MarketTrendsSection(),
                    const ProTipCard(),
                    SizedBox(height: 100.h), // padding for bottom navigation bar
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBazaarCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 15.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0FDF4),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.storefront_rounded,
                  color: const Color(0xFF16A34A),
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BasicText(
                      text: 'My Bazaar Storefront',
                      fontSize: 14,
                      color: const Color(0xFF0F172A),
                      isBold: true,
                    ),
                    SizedBox(height: 2.h),
                    BasicText(
                      text: 'Manage details, status, and announcements.',
                      fontSize: 11,
                      color: Colors.grey.shade500,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            height: 40.h,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyBazaarScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2D4373),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                elevation: 0,
              ),
              child: BasicText(
                text: 'Manage My Bazaar',
                fontSize: 12,
                color: Colors.white,
                isBold: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStockAlertsBanner(BuildContext context, List<SellerInventoryAlert> alerts) {
    return Container(
      margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 15.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF2F2), // Light red background
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFFEE2E2)),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: const Color(0xFFEF4444), size: 24.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BasicText(
                  text: 'Low Stock Alert!',
                  fontSize: 13,
                  color: const Color(0xFF991B1B),
                  isBold: true,
                ),
                SizedBox(height: 2.h),
                BasicText(
                  text: '${alerts.length} products are running low on stock.',
                  fontSize: 11,
                  color: const Color(0xFFB91C1C),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              _showStockAlertsDialog(context, alerts);
            },
            child: BasicText(
              text: 'View',
              fontSize: 12,
              color: const Color(0xFFEF4444),
              isBold: true,
            ),
          ),
        ],
      ),
    );
  }

  void _showStockAlertsDialog(BuildContext context, List<SellerInventoryAlert> alerts) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          title: BasicText(
            text: 'Low Stock Items',
            fontSize: 16,
            color: const Color(0xFF0F172A),
            isBold: true,
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: alerts.length,
              itemBuilder: (context, index) {
                final alert = alerts[index];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BasicText(
                              text: alert.productName,
                              fontSize: 13,
                              color: const Color(0xFF1E293B),
                              isBold: true,
                            ),
                            SizedBox(height: 2.h),
                            BasicText(
                              text: 'Current Stock: ${alert.stock}',
                              fontSize: 11,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(dialogContext);
                          _showAdjustStockDialog(context, alert);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2D4373),
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                        ),
                        child: BasicText(
                          text: 'Restock',
                          fontSize: 11,
                          color: Colors.white,
                          isBold: true,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showAdjustStockDialog(BuildContext context, SellerInventoryAlert alert) {
    final controller = TextEditingController(text: alert.stock.toString());
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          title: BasicText(
            text: 'Adjust Stock: ${alert.productName}',
            fontSize: 14,
            isBold: true,
          ),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'New Stock Level',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final newStock = int.tryParse(controller.text.trim());
                if (newStock != null) {
                  context.read<SellerCubit>().adjustStock(alert.productId, newStock);
                }
                Navigator.pop(dialogContext);
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2D4373)),
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
