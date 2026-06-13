import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/features/event/presentation/cubit/event_cubit.dart';
import 'package:brand/features/event/presentation/cubit/event_states.dart';
import 'package:brand/features/bazaar_details/presentation/views/bazaar_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventDetailsScreen extends StatefulWidget {
  final String eventId;
  const EventDetailsScreen({super.key, required this.eventId});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EventCubit>().getEventDetails(widget.eventId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocBuilder<EventCubit, EventState>(
        builder: (context, state) {
          if (state is EventDetailsLoading) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF2D4373)));
          }

          if (state is EventDetailsFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 48.sp, color: Colors.red),
                  SizedBox(height: 12.h),
                  BasicText(text: state.message, fontSize: 14.sp, color: Colors.red, isBold: true),
                  SizedBox(height: 12.h),
                  ElevatedButton(
                    onPressed: () => context.read<EventCubit>().getEventDetails(widget.eventId),
                    child: Text('try_again'.tr()),
                  ),
                ],
              ),
            );
          }

          if (state is EventDetailsSuccess) {
            final event = state.event;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Hero Header image
                  Stack(
                    children: [
                      SizedBox(
                        height: 250.h,
                        width: double.infinity,
                        child: event.imageUrl != null
                            ? Image.network(event.imageUrl!, fit: BoxFit.cover)
                            : Container(color: Colors.grey.shade300),
                      ),
                      Positioned(
                        top: 40.h,
                        left: 16.w,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18.sp),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                    ],
                  ),

                  /// Content details
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BasicText(
                          text: event.title,
                          fontSize: 22.sp,
                          color: Theme.of(context).colorScheme.onSurface,
                          isBold: true,
                        ),
                        SizedBox(height: 15.h),

                        /// Info Cards
                        _buildInfoTile(context, Icons.calendar_today_outlined, 'Date', event.date),
                        SizedBox(height: 12.h),
                        _buildInfoTile(context, Icons.access_time_outlined, 'Time', event.time),
                        SizedBox(height: 12.h),
                        _buildInfoTile(context, Icons.location_on_outlined, 'Location', event.location),
                        SizedBox(height: 12.h),
                        _buildInfoTile(context, Icons.corporate_fare_outlined, 'Organizer', event.organizer),

                        SizedBox(height: 20.h),
                        const Divider(),
                        SizedBox(height: 15.h),

                        BasicText(
                          text: 'About Event'.tr(),
                          fontSize: 15.sp,
                          color: Theme.of(context).colorScheme.onSurface,
                          isBold: true,
                        ),
                        SizedBox(height: 8.h),
                        BasicText(
                          text: event.description,
                          fontSize: 13.sp,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                        ),

                        SizedBox(height: 30.h),

                        /// View Bazaar storefront button
                        if (event.bazaarId != null || event.id == 'e1')
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BazaarDetailsScreen(
                                      bazaarId: event.bazaarId ?? '69e663a29cf01b2332978585', // fallback to valid bazaar ID
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.storefront, color: Colors.white),
                              label: BasicText(
                                text: 'Visit Bazaar Storefront'.tr(),
                                fontSize: 13.sp,
                                color: Colors.white,
                                isBold: true,
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2D4373),
                                padding: EdgeInsets.symmetric(vertical: 14.h),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
                                elevation: 0,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildInfoTile(BuildContext context, IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Theme.of(context).colorScheme.primary, size: 16.sp),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BasicText(text: label.tr(), fontSize: 10.sp, color: Colors.grey.shade500, isBold: true),
            SizedBox(height: 2.h),
            BasicText(text: value, fontSize: 12.sp, color: Theme.of(context).colorScheme.onSurface, isBold: true),
          ],
        ),
      ],
    );
  }
}
