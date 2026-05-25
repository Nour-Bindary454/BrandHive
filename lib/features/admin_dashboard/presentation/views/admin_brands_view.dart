import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/sharedWidgets/cus_search_bar.dart';
import 'package:brand/core/utils/toast/toast.dart';
import 'package:brand/features/admin_dashboard/presentation/view_model/admin_cubit.dart';
import 'package:brand/features/admin_dashboard/presentation/view_model/admin_states.dart';
import 'package:brand/features/home/presentation/view_models/cubit/home_cubit.dart';
import 'package:brand/features/home/presentation/view_models/cubit/home_states.dart';
import 'package:brand/features/admin_dashboard/presentation/views/widgets/admin_common_header.dart';
import 'package:brand/features/admin_dashboard/presentation/views/widgets/admin_brand_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminBrandsView extends StatefulWidget {
  const AdminBrandsView({super.key});

  @override
  State<AdminBrandsView> createState() => _AdminBrandsViewState();
}

class _AdminBrandsViewState extends State<AdminBrandsView> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminCubit, AdminState>(
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
        body: Column(
          children: [
            AdminCommonHeader(
              title: 'brands'.tr(),
              subtitle: 'Monitor and manage registered brands',
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CusSearchBar(
                hintText: 'search_brands'.tr(),
                onChanged: (val) {
                  setState(() {
                    _searchQuery = val.toLowerCase();
                  });
                },
              ),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  final filteredBrands = state.brands.where((brand) {
                    return brand.isActive != false &&
                        brand.name.toLowerCase().contains(_searchQuery);
                  }).toList();

                  if (filteredBrands.isEmpty) {
                    return _EmptyBrandsView();
                  }

                  return GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.w,
                      mainAxisSpacing: 16.h,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: filteredBrands.length,
                    itemBuilder: (context, index) => AdminBrandCard(brand: filteredBrands[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyBrandsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: BasicText(
        text: 'no_brands_found'.tr(),
        fontSize: 14.sp,
        color: Colors.grey,
        isBold: false,
      ),
    );
  }
}
