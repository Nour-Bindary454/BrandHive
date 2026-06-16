import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/utils/toast/toast.dart';
import 'package:brand/features/bazaar/presentation/cubit/bazaar_cubit.dart';
import 'package:brand/features/bazaar/presentation/cubit/bazaar_states.dart';
import 'package:brand/features/bazaar/data/models/bazaar_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminBazaarsView extends StatefulWidget {
  const AdminBazaarsView({super.key});

  @override
  State<AdminBazaarsView> createState() => _AdminBazaarsViewState();
}

class _AdminBazaarsViewState extends State<AdminBazaarsView> {
  String _selectedFilter = 'All';
  final List<String> _filters = [
    'All',
    'Pending',
    'Approved',
    'Rejected',
  ];

  @override
  void initState() {
    super.initState();
    context.read<BazaarCubit>().getBazaars(isRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 18.sp,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Bazaar Requests'.tr(),
          style: TextStyle(
            color: const Color(0xFF1E293B),
            fontFamily: 'Poppins',
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocConsumer<BazaarCubit, BazaarState>(
        listener: (context, state) {
          if (state is BazaarReviewSuccess) {
            final statusStr = state.status == 'approved' ? 'approved' : 'rejected';
            Toast.showSuccessToast(
              msg: 'Bazaar request $statusStr successfully!'.tr(),
              context: context,
            );
          } else if (state is BazaarReviewFailure) {
            Toast.showErrorToast(
              msg: state.message,
              context: context,
            );
          } else if (state is BazaarToggleSuccess) {
            Toast.showSuccessToast(
              msg: 'Bazaar status toggled successfully!'.tr(),
              context: context,
            );
            context.read<BazaarCubit>().getBazaars(isRefresh: true);
          } else if (state is BazaarToggleFailure) {
            Toast.showErrorToast(
              msg: state.message,
              context: context,
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<BazaarCubit>();

          if (state is BazaarsLoading && cubit.allBazaars.isEmpty) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF2D4373)));
          }

          final allBazaars = cubit.allBazaars;
          final filteredBazaars = _selectedFilter == 'All'
              ? allBazaars
              : allBazaars
                  .where((b) => (b.status?.toLowerCase() ?? 'pending') == _selectedFilter.toLowerCase())
                  .toList();

          return Column(
            children: [
              _buildFilterList(),
              Expanded(
                child: (state is BazaarReviewLoading || state is BazaarToggleLoading)
                    ? const Center(child: CircularProgressIndicator(color: Color(0xFF2D4373)))
                    : filteredBazaars.isEmpty
                        ? _buildEmptyState()
                        : RefreshIndicator(
                            onRefresh: () async => cubit.getBazaars(isRefresh: true),
                            child: ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                              itemCount: filteredBazaars.length,
                              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                              itemBuilder: (context, index) {
                                return _buildBazaarCard(filteredBazaars[index]);
                              },
                            ),
                          ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFilterList() {
    return Container(
      height: 48.h,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        itemCount: _filters.length,
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final isSelected = _selectedFilter == filter;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedFilter = filter;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF1E293B) : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  filter.tr(),
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey.shade600,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.storefront_outlined,
            size: 64.sp,
            color: Colors.grey.shade300,
          ),
          SizedBox(height: 16.h),
          BasicText(
            text: 'No bazaar requests found'.tr(),
            fontSize: 14.sp,
            color: Colors.grey.shade500,
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _buildBazaarCard(BazaarModel bazaar) {
    final status = bazaar.status?.toLowerCase() ?? 'pending';

    Color statusBg;
    Color statusText;
    if (status == 'approved') {
      statusBg = const Color(0xFFE6F4EA);
      statusText = const Color(0xFF137333);
    } else if (status == 'rejected') {
      statusBg = const Color(0xFFFCE8E6);
      statusText = const Color(0xFFC5221F);
    } else {
      statusBg = const Color(0xFFE8F0FE);
      statusText = const Color(0xFF174EA6);
    }

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Top row: Logo + Details + Status Badge
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60.r,
                  height: 60.r,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: bazaar.imageUrl != null && bazaar.imageUrl!.startsWith('http')
                        ? Image.network(bazaar.imageUrl!, fit: BoxFit.cover)
                        : Icon(Icons.storefront, size: 24.sp, color: Colors.grey.shade400),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BasicText(
                        text: bazaar.name,
                        fontSize: 14.sp,
                        color: const Color(0xFF1E293B),
                        isBold: true,
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(Icons.phone_outlined, size: 12.sp, color: Colors.grey.shade500),
                          SizedBox(width: 4.w),
                          BasicText(
                            text: bazaar.contactInfo.isNotEmpty ? bazaar.contactInfo : 'No phone',
                            fontSize: 11.sp,
                            color: Colors.grey.shade600,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: statusBg,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    status.toUpperCase().tr(),
                    style: TextStyle(
                      color: statusText,
                      fontSize: 9.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            /// Description
            BasicText(
              text: bazaar.description,
              fontSize: 12.sp,
              color: Colors.grey.shade600,
              maxLines: 3,
            ),
            SizedBox(height: 8.h),

            /// Address
            Row(
              children: [
                Icon(Icons.location_on_outlined, size: 12.sp, color: Colors.grey.shade500),
                SizedBox(width: 4.w),
                Expanded(
                  child: BasicText(
                    text: bazaar.address.isNotEmpty ? bazaar.address : 'No address provided',
                    fontSize: 11.sp,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),

            /// Rejection Reason if applicable
            if (status == 'rejected' && bazaar.rejectionReason != null) ...[
              SizedBox(height: 10.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: const Color(0xFFFCE8E6).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: const Color(0xFFFCE8E6)),
                ),
                child: BasicText(
                  text: 'Rejection Reason: ${bazaar.rejectionReason}',
                  fontSize: 11.sp,
                  color: const Color(0xFFC5221F),
                ),
              ),
            ],

            /// Admin Actions (Approve / Reject) if pending
            if (status == 'pending') ...[
              SizedBox(height: 16.h),
              const Divider(height: 1),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton.icon(
                    onPressed: () => _showRejectDialog(context, bazaar),
                    icon: Icon(Icons.close, color: const Color(0xFFEA4335), size: 14.sp),
                    label: Text(
                      'Reject'.tr(),
                      style: TextStyle(color: const Color(0xFFEA4335), fontSize: 12.sp, fontWeight: FontWeight.bold),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFEA4335)),
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  ElevatedButton.icon(
                    onPressed: () {
                      final sId = bazaar.sellerId ?? '';
                      if (sId.isEmpty) {
                        Toast.showErrorToast(msg: 'Seller ID is missing! Cannot approve.', context: context);
                        return;
                      }
                      context.read<BazaarCubit>().reviewBazaar(sId, 'approved');
                    },
                    icon: Icon(Icons.check, color: Colors.white, size: 14.sp),
                    label: Text(
                      'Approve'.tr(),
                      style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF34A853),
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                      elevation: 0,
                    ),
                  ),
                ],
              ),
            ],

            /// Toggle Active Status for approved bazaars
            if (status == 'approved') ...[
              SizedBox(height: 16.h),
              const Divider(height: 1),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        (bazaar.isActive ?? false) ? Icons.toggle_on : Icons.toggle_off_outlined,
                        size: 18.sp,
                        color: (bazaar.isActive ?? false) ? const Color(0xFF34A853) : Colors.grey.shade400,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'Store Status'.tr(),
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1E293B),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        (bazaar.isActive ?? false) ? 'Active'.tr() : 'Inactive'.tr(),
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                          color: (bazaar.isActive ?? false) ? const Color(0xFF34A853) : const Color(0xFFEA4335),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Switch(
                        value: bazaar.isActive ?? false,
                        activeColor: const Color(0xFF34A853),
                        onChanged: (val) {
                          context.read<BazaarCubit>().toggleBazaarStatus(bazaar.sellerId ?? bazaar.id);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showRejectDialog(BuildContext context, BazaarModel bazaar) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          title: Text(
            'Reject Bazaar Request'.tr(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Please specify the reason for rejecting this bazaar profile:'.tr(),
                style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
              ),
              SizedBox(height: 12.h),
              TextField(
                controller: controller,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'e.g., Logo is low-quality, incomplete info...'.tr(),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                  contentPadding: EdgeInsets.all(10.r),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text('Cancel'.tr(), style: TextStyle(color: Colors.grey.shade600)),
            ),
            ElevatedButton(
              onPressed: () {
                final reason = controller.text.trim();
                if (reason.isEmpty) {
                  Toast.showErrorToast(msg: 'Rejection reason is required!'.tr(), context: context);
                  return;
                }
                final sId = bazaar.sellerId ?? '';
                if (sId.isEmpty) {
                  Toast.showErrorToast(msg: 'Seller ID is missing! Cannot reject.', context: context);
                  return;
                }
                Navigator.pop(ctx);
                context.read<BazaarCubit>().reviewBazaar(sId, 'rejected', rejectionReason: reason);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEA4335),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
              ),
              child: Text('Confirm Reject'.tr(), style: const TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
