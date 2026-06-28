import 'package:brand/features/admin_dashboard/presentation/view_model/admin_cubit.dart';
import 'package:brand/features/home/data/models/home_models.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminBrandMenu extends StatelessWidget {
  final BrandModel brand;
  const AdminBrandMenu({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      padding: EdgeInsets.zero,
      icon: Icon(
        CupertinoIcons.ellipsis_vertical,
        size: 18.sp,
        color: Colors.grey,
      ),
      onSelected: (value) {
        if (value == 'delete') {
          _showDeleteDialog(context);
        } else if (value == 'toggle') {
          context.read<AdminCubit>().toggleBrandStatus(
                brand.id,
                brand.isActive,
              );
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'toggle',
          child: Row(
            children: [
              Icon(
                brand.isActive
                    ? CupertinoIcons.nosign
                    : CupertinoIcons.checkmark_circle,
                color: brand.isActive ? Colors.orange : Colors.green,
                size: 18.sp,
              ),
              SizedBox(width: 8.w),
              Text(brand.isActive ? 'deactivate'.tr() : 'activate'.tr()),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              Icon(CupertinoIcons.trash, color: Colors.red, size: 18.sp),
              SizedBox(width: 8.w),
              Text('delete'.tr(), style: const TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ],
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text('delete_brand'.tr()),
        content: Text('delete_brand_confirm_msg'.tr()),
        actions: [
          CupertinoDialogAction(
            child: Text('cancel'.tr()),
            onPressed: () => Navigator.pop(ctx),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(ctx);
              context.read<AdminCubit>().deleteBrand(brand.id);
            },
            child: Text('delete'.tr()),
          ),
        ],
      ),
    );
  }
}
