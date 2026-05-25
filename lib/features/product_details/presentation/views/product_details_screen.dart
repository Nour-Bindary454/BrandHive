import 'package:brand/core/services/cache_helper.dart';
import 'package:brand/core/services/service_locator.dart';
import 'package:brand/core/utils/toast/toast.dart';
import 'package:brand/features/admin_dashboard/presentation/view_model/admin_cubit.dart';
import 'package:brand/features/admin_dashboard/presentation/view_model/admin_states.dart';
import 'package:brand/features/brand_profile/data/models/product_model.dart';
import 'package:brand/features/product_details/presentation/views/widgets/product_bottom_bar.dart';
import 'package:brand/features/product_details/presentation/views/widgets/product_image_section.dart';
import 'package:brand/features/product_details/presentation/views/widgets/product_info_section.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AdminCubit>(),
      child: BlocListener<AdminCubit, AdminState>(
        listener: (context, state) {
          if (state is AdminActionSuccess) {
            Toast.showSuccessToast(msg: state.message.tr(), context: context);
            Navigator.pop(context);
          } else if (state is AdminActionError) {
            Toast.showErrorToast(msg: state.message.tr(), context: context);
          }
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductImageSection(product: product),
                    ProductInfoSection(product: product),
                    SizedBox(height: 100.h),
                  ],
                ),
              ),
              if (CacheHelper.getData(key: 'role')?.toLowerCase() != 'admin')
                ProductBottomBar(product: product),
            ],
          ),
        ),
      ),
    );
  }
}
