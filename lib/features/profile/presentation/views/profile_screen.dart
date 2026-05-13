import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../viewmodels/profile_viewmodel.dart';
import 'widgets/profile_header.dart';
import 'widgets/seller_mode_card.dart';
import 'widgets/stats_row.dart';
import 'widgets/menu_list_section.dart';
import 'widgets/sign_out_button.dart';
import '../../../../core/sharedWidgets/basic_text.dart';
import '../../../../core/services/cache_helper.dart';
import '../../../../core/utils/toast/toast.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ProfileViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ProfileViewModel();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _viewModel,
          builder: (context, _) {
            if (_viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (_viewModel.errorMessage != null) {
              return Center(
                child: BasicText(
                  text: _viewModel.errorMessage!,
                  fontSize: 16.sp,
                  color: Colors.red,
                  isBold: true,
                ),
              );
            }

            final profile = _viewModel.profileData;
            if (profile == null) {
              return const SizedBox.shrink();
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 24.h),
                  // Header Section
                  ProfileHeader(
                    name: profile.name,
                    email: profile.email,
                    imageUrl: profile.imageUrl,
                    membership: profile.membership,
                  ),
                  SizedBox(height: 24.h),

                  // Seller Mode Banner
                  SellerModeCard(
                    onTap: () {
                      final Object isPending =
                          CacheHelper.getData(key: 'brand_request_pending') ??
                          false;

                      if (isPending == 'true') {
                        Toast.showInfoToast(
                          msg: 'Your request is currently pending approval',
                          context: context,
                        );
                        return;
                      }

                      // Navigate to seller registration
                      Navigator.pushNamed(context, '/sellerRegistration');
                    },
                  ),
                  SizedBox(height: 24.h),

                  // Stats Row
                  StatsRow(stats: profile.stats),
                  SizedBox(height: 24.h),

                  // Menu List
                  MenuListSection(items: profile.menuItems),
                  SizedBox(height: 32.h),

                  // Sign Out Button
                  SignOutButton(onTap: () => _viewModel.signOut(context)),
                  SizedBox(height: 24.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
