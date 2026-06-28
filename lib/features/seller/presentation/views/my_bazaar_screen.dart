import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/utils/toast/toast.dart';
import 'package:brand/features/bazaar/presentation/cubit/bazaar_cubit.dart';
import 'package:brand/features/bazaar/presentation/cubit/bazaar_states.dart';
import 'package:brand/features/bazaar/data/models/bazaar_model.dart';
import 'package:brand/features/seller/presentation/views/edit_bazaar_screen.dart';
import 'package:brand/features/seller/presentation/views/send_announcement_screen.dart';
import 'package:brand/features/seller/settings/widgets/settings_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyBazaarScreen extends StatefulWidget {
  const MyBazaarScreen({super.key});

  @override
  State<MyBazaarScreen> createState() => _MyBazaarScreenState();
}

class _MyBazaarScreenState extends State<MyBazaarScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BazaarCubit>().getMyBazaar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: const Color(0xFF0F172A), size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
        title: BasicText(
          text: 'my_bazaar'.tr(),
          fontSize: 18.sp,
          color: const Color(0xFF0F172A),
          isBold: true,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<BazaarCubit, BazaarState>(
          builder: (context, state) {
            final cubit = context.read<BazaarCubit>();

            if (state is MyBazaarLoading) {
              return const Center(child: CircularProgressIndicator(color: Color(0xFF2D4373)));
            }

            final bazaar = cubit.myBazaar;

            if (bazaar == null) {
              return _buildEmptyState(context);
            }

            final isApproved = bazaar.status?.toLowerCase() == 'approved';

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  /// Status Banner
                  _buildStatusBanner(bazaar),

                  /// Bazaar Card
                  SettingsCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Image Picker / Display
                        Center(
                          child: Container(
                            width: 120.r,
                            height: 120.r,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(color: Colors.grey.shade300, width: 1.5),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(14.r),
                              child: bazaar.imageUrl != null && bazaar.imageUrl!.startsWith('http')
                                  ? Image.network(bazaar.imageUrl!, fit: BoxFit.cover)
                                  : Center(child: Icon(Icons.storefront, size: 40.sp, color: Colors.grey.shade400)),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),

                        /// Info fields
                        _buildInfoRow('Bazaar Name', bazaar.name),
                        SizedBox(height: 12.h),
                        _buildInfoRow('Description', bazaar.description),
                        SizedBox(height: 12.h),
                        _buildInfoRow('Address', bazaar.address),
                        SizedBox(height: 12.h),
                        _buildInfoRow('Contact Info', bazaar.contactInfo),
                      ],
                    ),
                  ),

                  /// Quick Actions
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EditBazaarScreen(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.edit, color: Colors.white, size: 16),
                            label: BasicText(
                              text: 'Edit Bazaar'.tr(),
                              fontSize: 13,
                              color: Colors.white,
                              isBold: true,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2D4373),
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                              elevation: 0,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: isApproved
                                ? () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const SendAnnouncementScreen(),
                                      ),
                                    );
                                  }
                                : () {
                                    Toast.showErrorToast(
                                      msg: 'Announcements are only available for approved bazaars.'.tr(),
                                      context: context,
                                    );
                                  },
                            icon: Icon(
                              Icons.campaign,
                              color: isApproved ? const Color(0xFF2D4373) : Colors.grey,
                              size: 16,
                            ),
                            label: BasicText(
                              text: 'Announce'.tr(),
                              fontSize: 13,
                              color: isApproved ? const Color(0xFF2D4373) : Colors.grey,
                              isBold: true,
                            ),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: isApproved ? const Color(0xFF2D4373) : Colors.grey.shade300,
                              ),
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatusBanner(BazaarModel bazaar) {
    final status = bazaar.status?.toLowerCase() ?? 'pending';
    final isActive = bazaar.isActive ?? false;

    Color bg;
    Color border;
    Color text;
    IconData icon;
    String title;
    String desc;

    if (status == 'approved') {
      if (isActive) {
        bg = const Color(0xFFE6F4EA);
        border = const Color(0xFF34A853).withOpacity(0.4);
        text = const Color(0xFF137333);
        icon = Icons.check_circle_outline;
        title = 'Bazaar Profile Active';
        desc = 'Your bazaar is approved and active. Customers can now discover and explore your store.';
      } else {
        bg = const Color(0xFFFEF7E0);
        border = const Color(0xFFFBBC04).withOpacity(0.4);
        text = const Color(0xFFB06000);
        icon = Icons.pause_circle_outline;
        title = 'Bazaar Profile Inactive';
        desc = 'Your bazaar is approved but currently inactive. Contact support to toggle visibility.';
      }
    } else if (status == 'rejected') {
      bg = const Color(0xFFFCE8E6);
      border = const Color(0xFFEA4335).withOpacity(0.4);
      text = const Color(0xFFC5221F);
      icon = Icons.error_outline;
      title = 'Bazaar Request Rejected';
      desc = bazaar.rejectionReason != null && bazaar.rejectionReason!.isNotEmpty
          ? 'Rejection reason: "${bazaar.rejectionReason}"\nPlease edit your bazaar details and submit again for review.'
          : 'Your bazaar profile request was rejected. Please review and update your storefront details.';
    } else {
      bg = const Color(0xFFE8F0FE);
      border = const Color(0xFF1A73E8).withOpacity(0.4);
      text = const Color(0xFF174EA6);
      icon = Icons.info_outline;
      title = 'Under Review';
      desc = 'Your bazaar profile is pending admin approval. You will be able to post announcements and receive customers once approved.';
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: border, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: text, size: 24.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BasicText(
                  text: title,
                  fontSize: 14.sp,
                  color: text,
                  isBold: true,
                ),
                SizedBox(height: 4.h),
                BasicText(
                  text: desc,
                  fontSize: 11.5.sp,
                  color: text.withOpacity(0.85),
                  maxLines: 4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BasicText(
          text: label.tr(),
          fontSize: 11,
          color: Colors.grey.shade500,
          isBold: true,
        ),
        SizedBox(height: 4.h),
        BasicText(
          text: value.isNotEmpty ? value : 'Not provided',
          fontSize: 13,
          color: const Color(0xFF0F172A),
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.storefront_outlined, size: 64.sp, color: Colors.grey.shade400),
            SizedBox(height: 16.h),
            BasicText(
              text: 'No Bazaar Profile'.tr(),
              fontSize: 16,
              color: const Color(0xFF0F172A),
              isBold: true,
            ),
            SizedBox(height: 8.h),
            BasicText(
              text: 'Setup your bazaar shop, address, and upload an image to participate in public events.'.tr(),
              fontSize: 12,
              color: Colors.grey.shade500,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditBazaarScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2D4373),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
                elevation: 0,
              ),
              child: BasicText(
                text: 'Setup Bazaar'.tr(),
                fontSize: 13,
                color: Colors.white,
                isBold: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
