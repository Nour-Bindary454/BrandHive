import 'package:brand/core/sharedWidgets/shared_order_details_view.dart';
import 'package:brand/features/admin_dashboard/data/models/admin_models.dart';
import 'package:brand/features/admin_dashboard/presentation/view_model/admin_cubit.dart';
import 'package:brand/features/admin_dashboard/presentation/view_model/admin_states.dart';
import 'package:brand/features/admin_dashboard/presentation/views/widgets/order_status_selector_bottom_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminOrderDetailsView extends StatefulWidget {
  final AdminOrderModel order;
  const AdminOrderDetailsView({super.key, required this.order});
  @override
  State<AdminOrderDetailsView> createState() => _AdminOrderDetailsViewState();
}

class _AdminOrderDetailsViewState extends State<AdminOrderDetailsView> {
  late String _currentStatus;

  @override
  void initState() {
    super.initState();
    _currentStatus = widget.order.status;
  }

  @override
  Widget build(BuildContext context) {
    final createdAt = DateTime.tryParse(widget.order.createdAt);
    final dateStr = createdAt != null ? DateFormat('MMM dd, yyyy - hh:mm a').format(createdAt) : widget.order.createdAt;
    final items = widget.order.items.map((e) => SharedOrderItemModel(
      productImage: e.productImage, productName: e.productName, quantity: e.quantity, unitPrice: e.unitPrice,
    )).toList();

    return BlocConsumer<AdminCubit, AdminState>(
      listener: (context, state) {
        if (state is AdminOrderStatusUpdateSuccess && state.orderId == widget.order.id) {
          setState(() => _currentStatus = state.newStatus);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Order status updated successfully'.tr()), backgroundColor: Colors.green),
          );
          context.read<AdminCubit>().getAllOrders();
        } else if (state is AdminOrderStatusUpdateError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message), backgroundColor: Colors.red));
        }
      },
      builder: (context, state) {
        final isLoading = state is AdminOrderStatusUpdateLoading;
        return Stack(
          children: [
            SharedOrderDetailsView(
              orderNumber: widget.order.orderNumber,
              status: _currentStatus,
              paymentMethod: widget.order.paymentMethod,
              createdAt: dateStr,
              userEmail: widget.order.userEmail,
              total: widget.order.total,
              items: items,
              onStatusTap: () => _showStatusSelector(context),
            ),
            if (isLoading) ...[
              const ModalBarrier(dismissible: false, color: Colors.black12),
              const Center(child: CircularProgressIndicator(color: Color(0xFF2D4373))),
            ],
          ],
        );
      },
    );
  }

  void _showStatusSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24.r))),
      builder: (bottomSheetContext) => OrderStatusSelectorBottomSheet(
        currentStatus: _currentStatus,
        onStatusSelected: (newStatus) {
          Navigator.pop(bottomSheetContext);
          context.read<AdminCubit>().updateOrderStatus(widget.order.id, newStatus);
        },
      ),
    );
  }
}
