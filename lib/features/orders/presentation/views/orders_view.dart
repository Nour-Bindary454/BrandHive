import 'package:brand/core/services/service_locator.dart';
import 'package:brand/features/orders/presentation/view_model/orders_cubit.dart';
import 'package:brand/features/orders/presentation/views/widgets/orders_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<OrdersCubit>()..getMyOrders(),
      child: const Scaffold(
        backgroundColor: Color(0xFFF8F9FA),
        body: OrdersBody(),
      ),
    );
  }
}
