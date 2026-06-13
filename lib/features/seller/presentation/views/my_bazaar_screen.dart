import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/features/bazaar/presentation/cubit/bazaar_cubit.dart';
import 'package:brand/features/bazaar/presentation/cubit/bazaar_states.dart';
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

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
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
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SendAnnouncementScreen(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.campaign, color: Color(0xFF2D4373), size: 16),
                            label: BasicText(
                              text: 'Announce'.tr(),
                              fontSize: 13,
                              color: const Color(0xFF2D4373),
                              isBold: true,
                            ),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFF2D4373)),
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
