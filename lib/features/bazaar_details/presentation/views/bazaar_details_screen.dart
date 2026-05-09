import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../viewmodels/bazaar_details_viewmodel.dart';
import '../../data/models/bazaar_details_model.dart';
import 'widgets/bazaar_hero_header.dart';
import 'widgets/bazaar_info_row.dart';
import 'widgets/bazaar_section_title.dart';
import '../../../../core/sharedWidgets/basic_colors.dart';
import '../../../../core/sharedWidgets/basic_text.dart';

class BazaarDetailsScreen extends StatefulWidget {
  final String bazaarId;
  const BazaarDetailsScreen({super.key, required this.bazaarId});

  @override
  State<BazaarDetailsScreen> createState() => _BazaarDetailsScreenState();
}

class _BazaarDetailsScreenState extends State<BazaarDetailsScreen> {
  late final BazaarDetailsViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = BazaarDetailsViewModel();
    _viewModel.fetchBazaarDetails(widget.bazaarId);
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
      body: AnimatedBuilder(
        animation: _viewModel,
        builder: (context, _) {
          if (_viewModel.isLoading && _viewModel.bazaarDetails == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_viewModel.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BasicText(
                    text: _viewModel.errorMessage!,
                    fontSize: 16.sp,
                    color: Colors.red,
                    isBold: true,
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () =>
                        _viewModel.fetchBazaarDetails(widget.bazaarId),
                    child: Text('try_again'.tr()),
                  ),
                ],
              ),
            );
          }

          final details = _viewModel.bazaarDetails;
          if (details == null) return const SizedBox.shrink();

          return SingleChildScrollView(
            child: Column(
              children: [
                /// 🔥 Header + Overlay Card
                SizedBox(
                  height: 300.h,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      /// 🔹 image
                      SizedBox(
                        height: 200.h,
                        width: double.infinity,
                        child: BazaarHeroHeader(
                          imageUrl: details.imageUrl,
                          onBackTap: () => Navigator.pop(context),
                        ),
                      ),

                      /// 🔹card
                      Positioned(
                        bottom: -110,
                        left: 16.w,
                        right: 16.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 14.h,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(20.r),
                            boxShadow: [
                              BoxShadow(
                                color: (Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black).withOpacity(0.08),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BasicText(
                                text: details.title,
                                fontSize: 20.sp,
                                fontFamily: 'Outfit',
                                color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
                                isBold: true,
                              ),
                              SizedBox(height: 5.h),

                              BasicText(
                                text: details.description,
                                fontSize: 13.sp,
                                color: Theme.of(context).textTheme.bodyMedium?.color ?? Colors.grey,
                                isBold: false,
                              ),

                              SizedBox(height: 10.h),

                              BazaarInfoRow(
                                icon: Icons.location_on_outlined,
                                title: 'location'.tr().tr(),
                                subtitle: details.location.split('\n')[0],
                                thirdLine: details.location.contains('\n')
                                    ? details.location.split('\n')[1]
                                    : null,
                              ),

                              SizedBox(height: 8.h),

                              BazaarInfoRow(
                                icon: Icons.phone_outlined,
                                title: 'contact'.tr().tr(),
                                subtitle: details.phone,
                              ),

                              SizedBox(height: 10.h),

                              BazaarInfoRow(
                                icon: Icons.access_time_outlined,
                                title: 'hours'.tr().tr(),
                                subtitle: details.time,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 105.h),

                /// 🔹 باقي الصفحة
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (details.upcomingDates.isNotEmpty) ...[
                        BazaarSectionTitle(title: 'upcoming_dates'.tr().tr()),
                        ...details.upcomingDates.map(
                          (date) => _buildDateCard(date),
                        ),
                      ],

                      if (details.participatingBrands.isNotEmpty) ...[
                        BazaarSectionTitle(title: 'participating_brands'.tr().tr()),
                        ...details.participatingBrands.map(
                          (brand) => _buildBrandCard(brand),
                        ),
                      ],

                      if (details.eventHighlights.isNotEmpty) ...[
                        BazaarSectionTitle(title: 'event_highlights'.tr().tr()),
                        Wrap(
                          spacing: 8.w,
                          runSpacing: 8.h,
                          children: details.eventHighlights
                              .map(
                                (highlight) => _buildHighlightChip(highlight),
                              )
                              .toList(),
                        ),
                      ],

                      SizedBox(height: 48.h),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDateCard(UpcomingDateModel date) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFFFD166), width: 1.5.w),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BasicText(
                text: date.dateRange,
                fontSize: 14.sp,
                color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
                isBold: true,
              ),
              SizedBox(height: 4.h),
              BasicText(
                text: date.fullDateString,
                fontSize: 12.sp,
                color: Theme.of(context).textTheme.bodyMedium?.color ?? Colors.grey,
                isBold: false,
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: const Color(0xFFFFECCC),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_month, size: 14.sp),
                SizedBox(width: 4.w),
                BasicText(
                  text: date.status,
                  fontSize: 12.sp,
                  color: const Color(0xFFD98A00),
                  isBold: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandCard(ParticipatingBrandModel brand) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F5FA),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFD6E4F0), width: 1.w),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BasicText(
            text: brand.name,
            fontSize: 14.sp,
            color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
            isBold: true,
          ),
          if (brand.isFeatured)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: BasicColors.buttonColorDark,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: BasicText(
                text: 'featured'.tr().tr(),
                fontSize: 10.sp,
                color: Theme.of(context).cardColor,
                isBold: true,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHighlightChip(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: (Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black).withOpacity(0.2)),
      ),
      child: BasicText(
        text: text,
        fontSize: 12.sp,
        color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
        isBold: true,
      ),
    );
  }
}
