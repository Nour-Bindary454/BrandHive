import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/features/bazaar/presentation/cubit/bazaar_cubit.dart';
import 'package:brand/features/bazaar/presentation/cubit/bazaar_states.dart';
import 'package:brand/features/bazaar/presentation/views/all_bazaars_screen.dart';
import 'package:brand/features/bazaar_details/presentation/views/bazaar_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeBazaarSection extends StatefulWidget {
  const HomeBazaarSection({super.key});

  @override
  State<HomeBazaarSection> createState() => _HomeBazaarSectionState();
}

class _HomeBazaarSectionState extends State<HomeBazaarSection> {
  @override
  void initState() {
    super.initState();
    // Fetch bazaars on load
    context.read<BazaarCubit>().getBazaars(isRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BazaarCubit, BazaarState>(
      builder: (context, state) {
        final cubit = context.read<BazaarCubit>();
        final bazaars = cubit.allBazaars.take(5).toList();

        if (bazaars.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'bazaars'.tr(),
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AllBazaarsScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'view_all'.tr(),
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            SizedBox(
              height: 180.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: bazaars.length,
                separatorBuilder: (context, index) => SizedBox(width: 12.w),
                itemBuilder: (context, index) {
                  final bazaar = bazaars[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BazaarDetailsScreen(bazaarId: bazaar.id),
                        ),
                      );
                    },
                    child: Container(
                      width: 250.w,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 105.h,
                              width: double.infinity,
                              child: bazaar.imageUrl != null && bazaar.imageUrl!.startsWith('http')
                                  ? Image.network(
                                      bazaar.imageUrl!,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => _buildPlaceholder(),
                                    )
                                  : _buildPlaceholder(),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BasicText(
                                    text: bazaar.name,
                                    fontSize: 14.sp,
                                    color: Theme.of(context).colorScheme.onSurface,
                                    isBold: true,
                                  ),
                                  SizedBox(height: 4.h),
                                  BasicText(
                                    text: bazaar.description,
                                    fontSize: 11.sp,
                                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey.shade200,
      child: Center(
        child: Icon(Icons.store_mall_directory_outlined, size: 30.sp, color: Colors.grey.shade400),
      ),
    );
  }
}
