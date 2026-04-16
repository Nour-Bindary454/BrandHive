import 'package:brand/features/seller/overView/widgets/overview_header.dart';
import 'package:brand/features/seller/overView/widgets/pro_tip_card.dart';
import 'package:brand/features/seller/overView/widgets/recent_orders.dart';
import 'package:brand/features/seller/overView/widgets/store_analytics.dart';
import 'package:flutter/material.dart';

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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              OverviewHeader(),
              RecentOrders(),
              StoreAnalytics(),
              ProTipCard(),
              SizedBox(height: 100), // padding for bottom navigation bar
            ],
          ),
        ),
      ),
    );
  }
}
