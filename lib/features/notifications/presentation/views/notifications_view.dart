import 'package:brand/core/services/service_locator.dart';
import 'package:brand/features/notifications/presentation/viewmodel/notifications_cubit.dart';
import 'package:brand/features/notifications/presentation/views/widgets/notifications_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<NotificationsCubit>()..fetchNotifications(),
      child: const Scaffold(
        backgroundColor: Color(0xFFF8F9FA),
        body: NotificationsBody(),
      ),
    );
  }
}
