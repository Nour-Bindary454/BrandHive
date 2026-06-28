import 'package:brand/core/services/service_locator.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/utils/toast/toast.dart';
import 'package:brand/features/admin_dashboard/presentation/view_model/admin_cubit.dart';
import 'package:brand/features/admin_dashboard/presentation/view_model/admin_states.dart';
import 'package:brand/features/admin_dashboard/presentation/views/widgets/admin_brand_card.dart';
import 'package:brand/features/home/presentation/view_models/cubit/home_cubit.dart';
import 'package:brand/features/home/presentation/view_models/cubit/home_states.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeactivatedBrandsView extends StatelessWidget {
  const DeactivatedBrandsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AdminCubit>(),
      child: BlocListener<AdminCubit, AdminState>(
        listener: (context, state) {
          if (state is AdminActionSuccess) {
            Toast.showSuccessToast(msg: state.message.tr(), context: context);
            if (state.id != null) {
              if (state.action == 'toggle_brand') {
                final homeCubit = context.read<HomeCubit>();
                final brand = homeCubit.state.brands.firstWhere(
                  (b) => b.id == state.id,
                );
                homeCubit.updateBrandStatus(
                  state.id!,
                  !(brand.isActive),
                );
              } else if (state.action == 'delete_brand') {
                context.read<HomeCubit>().removeBrand(state.id!);
              }
            }
          } else if (state is AdminActionError) {
            Toast.showErrorToast(msg: state.message.tr(), context: context);
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.5,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, size: 18.sp, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'Deactivated Brands'.tr(),
              style: TextStyle(
                color: const Color(0xFF1E293B),
                fontFamily: 'Poppins',
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              final deactivatedBrands =
                  state.brands.where((b) => b.isActive == false).toList();

              if (deactivatedBrands.isEmpty) {
                return _EmptyState();
              }

              return GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                physics: const BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                ),
                itemCount: deactivatedBrands.length,
                itemBuilder: (context, index) {
                  return AdminBrandCard(brand: deactivatedBrands[index]);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(CupertinoIcons.slash_circle, size: 50.sp, color: Colors.grey[300]),
          SizedBox(height: 12.h),
          BasicText(
            text: 'No deactivated brands found',
            fontSize: 13.sp,
            color: Colors.grey,
            isBold: false,
          ),
        ],
      ),
    );
  }
}
