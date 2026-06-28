import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'viewmodel/cart_view_model.dart';
import 'widgets/cart_item_widget.dart';
import 'widgets/order_summary_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF8F9FA,
      ), // Off-white typical for cart bgs
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'shopping cart',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
          ),
        ),
      ),
      body: Consumer<CartViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading && viewModel.items.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          if (viewModel.errorMessage != null && viewModel.items.isEmpty) {
            return Center(
              child: Text(
                viewModel.errorMessage!,
                style: TextStyle(color: Colors.red, fontSize: 16.sp),
              ),
            );
          }

          if (viewModel.items.isEmpty) {
            return Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 16.h,
                  ),
                  itemCount: viewModel.items.length,
                  itemBuilder: (context, index) {
                    final item = viewModel.items[index];
                    return CartItemWidget(item: item);
                  },
                ),
              ),
              OrderSummaryWidget(),
            ],
          );
        },
      ),
    );
  }
}
