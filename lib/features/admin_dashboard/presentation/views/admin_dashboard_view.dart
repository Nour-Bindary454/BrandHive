import 'package:brand/core/services/service_locator.dart';
import 'package:brand/features/admin_dashboard/data/models/admin_models.dart';
import 'package:brand/features/admin_dashboard/presentation/view_model/admin_cubit.dart';
import 'package:brand/features/admin_dashboard/presentation/view_model/admin_states.dart';
import 'package:brand/features/admin_dashboard/presentation/views/widgets/admin_dashboard_header.dart';
import 'package:brand/features/admin_dashboard/presentation/views/widgets/admin_stat_card.dart';
import 'package:brand/features/admin_dashboard/presentation/views/widgets/brand_request_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminDashboardView extends StatefulWidget {
  const AdminDashboardView({super.key});

  @override
  State<AdminDashboardView> createState() => _AdminDashboardViewState();
}

class _AdminDashboardViewState extends State<AdminDashboardView> {
  BrandStatus? _selectedStatus;

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
    final filteredRequests = _selectedStatus == null
        ? state.requests
        : state.requests.where((r) => r.status == _selectedStatus).toList();

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const AdminDashboardHeader(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                SizedBox(height: 28.h),
                _buildFilterBar(),
                SizedBox(height: 16.h),
                if (filteredRequests.isEmpty)
                  _buildEmptyState()
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredRequests.length,
                    itemBuilder: (context, index) {
                      final request = filteredRequests[index];
                      return BrandRequestItem(
                        request: request,
                        onStatusChange: (BrandStatus status, String? reason) {
                          context.read<AdminCubit>().updateRequestStatus(
                            request.id,
                            status,
                            reason: reason,
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

  Widget _buildFilterBar() {
    final filterOptions = [
      _FilterOption(label: 'filter_all'.tr(), status: null),
      _FilterOption(label: 'filter_pending'.tr(), status: BrandStatus.pending),
      _FilterOption(label: 'filter_approved'.tr(), status: BrandStatus.approved),
      _FilterOption(label: 'filter_rejected'.tr(), status: BrandStatus.rejected),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: filterOptions.map((opt) {
          final isSelected = _selectedStatus == opt.status;
          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedStatus = opt.status;
                });
              },
              borderRadius: BorderRadius.circular(30.r),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF1E293B) : Colors.white,
                  borderRadius: BorderRadius.circular(30.r),
                  border: Border.all(
                    color: isSelected ? Colors.transparent : const Color(0xFFE2E8F0),
                    width: 1,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: const Color(0xFF1E293B).withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          )
                        ]
                      : [],
                ),
                child: Text(
                  opt.label,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? Colors.white : const Color(0xFF64748B),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 44.sp,
            color: const Color(0xFF94A3B8),
          ),
          SizedBox(height: 12.h),
          Text(
            'no_requests_found_for_filter'.tr(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterOption {
  final String label;
  final BrandStatus? status;

  _FilterOption({required this.label, required this.status});
}
