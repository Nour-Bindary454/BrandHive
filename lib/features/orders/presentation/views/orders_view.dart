import 'package:brand/core/services/service_locator.dart';
import 'package:brand/features/orders/presentation/view_model/orders_cubit.dart';
import 'package:brand/features/orders/presentation/views/widgets/orders_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
<<<<<<< HEAD
import 'package:brand/core/services/service_locator.dart';
import 'package:brand/features/orders/presentation/viewmodels/orders_cubit.dart';
=======
>>>>>>> b638b3040374aa6e62f93d89ede990324fbda31e

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
<<<<<<< HEAD
      create: (context) => sl<OrdersCubit>()..fetchMyOrders(),
=======
      create: (context) => sl<OrdersCubit>()..getMyOrders(),
>>>>>>> b638b3040374aa6e62f93d89ede990324fbda31e
      child: const Scaffold(
        backgroundColor: Color(0xFFF8F9FA),
        body: OrdersBody(),
      ),
    );
  }
}
