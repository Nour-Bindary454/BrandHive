import 'package:brand/core/services/service_locator.dart';
import 'package:brand/features/admin_dashboard/presentation/view_model/admin_cubit.dart';
import 'package:brand/features/admin_dashboard/presentation/view_model/admin_states.dart';
import 'package:brand/features/admin_dashboard/presentation/views/widgets/admin_dashboard_header.dart';
import 'package:brand/features/admin_dashboard/presentation/views/widgets/admin_stat_card.dart';
import 'package:brand/features/admin_dashboard/presentation/views/widgets/brand_request_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminDashboardView extends StatelessWidget {
  const AdminDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AdminCubit>()..getDashboardData(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: BlocBuilder<AdminCubit, AdminState>(
          builder: (context, state) {
            if (state is AdminLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AdminError) {
              return Center(child: Text(state.message));
            } else if (state is AdminSuccess) {
              return _buildBody(context, state);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, AdminSuccess state) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const AdminDashboardHeader(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                SizedBox(height: 24.h),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 16.h,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: state.stats.length,
                  itemBuilder: (context, index) =>
                      AdminStatCard(stat: state.stats[index]),
                ),
                SizedBox(height: 32.h),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.requests.length,
                  itemBuilder: (context, index) {
                    final request = state.requests[index];
                    return BrandRequestItem(
                      request: request,
                      onStatusChange: (status) {
                        context.read<AdminCubit>().updateRequestStatus(
                          request.id,
                          status,
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
