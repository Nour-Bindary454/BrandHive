import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/features/bazaar/presentation/cubit/bazaar_cubit.dart';
import 'package:brand/features/bazaar/presentation/cubit/bazaar_states.dart';
import 'package:brand/features/bazaar/data/models/bazaar_model.dart';
import 'package:brand/features/bazaar_details/presentation/views/bazaar_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllBazaarsScreen extends StatefulWidget {
  const AllBazaarsScreen({super.key});

  @override
  State<AllBazaarsScreen> createState() => _AllBazaarsScreenState();
}

class _AllBazaarsScreenState extends State<AllBazaarsScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    final cubit = context.read<BazaarCubit>();
    cubit.getBazaars(isRefresh: true);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200.h) {
        if (!cubit.isFetchingMore && !cubit.hasReachedMax && _searchQuery.isEmpty) {
          cubit.getBazaars();
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String val) {
    setState(() {
      _searchQuery = val.trim();
    });
    if (_searchQuery.isNotEmpty) {
      context.read<BazaarCubit>().searchBazaars(_searchQuery);
    } else {
      context.read<BazaarCubit>().getBazaars(isRefresh: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Theme.of(context).colorScheme.onSurface, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
        title: BasicText(
          text: 'bazaars'.tr(),
          fontSize: 18.sp,
          color: Theme.of(context).colorScheme.onSurface,
          isBold: true,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            /// Search Input Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  decoration: InputDecoration(
                    hintText: 'Search bazaars...'.tr(),
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, color: Colors.grey),
                            onPressed: () {
                              _searchController.clear();
                              _onSearchChanged('');
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                ),
              ),
            ),

            /// List Section
            Expanded(
              child: BlocBuilder<BazaarCubit, BazaarState>(
                builder: (context, state) {
                  final cubit = context.read<BazaarCubit>();

                  if (state is BazaarsLoading && cubit.allBazaars.isEmpty) {
                    return const Center(child: CircularProgressIndicator(color: Color(0xFF2D4373)));
                  }

                  if (state is BazaarsFailure && cubit.allBazaars.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error_outline, size: 48.sp, color: Colors.red),
                          SizedBox(height: 12.h),
                          BasicText(text: state.message, fontSize: 14.sp, color: Colors.red, isBold: true),
                          SizedBox(height: 12.h),
                          ElevatedButton(
                            onPressed: () => cubit.getBazaars(isRefresh: true),
                            child: Text('try_again'.tr()),
                          ),
                        ],
                      ),
                    );
                  }

                  final bazaars = cubit.allBazaars
                      .where((b) => b.status?.toLowerCase() == 'approved' || (b.isActive ?? false))
                      .toList();

                  if (bazaars.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.store_mall_directory_outlined, size: 60.sp, color: Colors.grey.shade400),
                          SizedBox(height: 12.h),
                          BasicText(
                            text: 'No bazaars found'.tr(),
                            fontSize: 16.sp,
                            color: Colors.grey.shade600,
                            isBold: true,
                          ),
                        ],
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async => cubit.getBazaars(isRefresh: true),
                    child: ListView.builder(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                      itemCount: bazaars.length + (cubit.isFetchingMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == bazaars.length) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            child: const Center(child: CircularProgressIndicator(color: Color(0xFF2D4373))),
                          );
                        }

                        final bazaar = bazaars[index];
                        return _buildBazaarCard(context, bazaar);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBazaarCard(BuildContext context, BazaarModel bazaar) {
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
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Image
              SizedBox(
                height: 150.h,
                width: double.infinity,
                child: bazaar.imageUrl != null && bazaar.imageUrl!.startsWith('http')
                    ? Image.network(
                        bazaar.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _buildPlaceholderImage(),
                      )
                    : _buildPlaceholderImage(),
              ),

              /// Info
              Padding(
                padding: EdgeInsets.all(14.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: BasicText(
                            text: bazaar.name,
                            fontSize: 16.sp,
                            color: Theme.of(context).colorScheme.onSurface,
                            isBold: true,
                          ),
                        ),
                        _buildStatusBadge(bazaar),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    BasicText(
                      text: bazaar.description,
                      fontSize: 12.sp,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                      maxLines: 2,
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, size: 14.sp, color: Colors.grey),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: BasicText(
                            text: bazaar.address,
                            fontSize: 11.sp,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(BazaarModel bazaar) {
    final bool active = bazaar.isActive ?? true;
    final color = active ? const Color(0xFFE6F4EA) : const Color(0xFFFCE8E6);
    final textColor = active ? const Color(0xFF137333) : const Color(0xFFC5221F);
    final label = active ? 'active'.tr() : 'inactive'.tr();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: BasicText(
        text: label,
        fontSize: 10.sp,
        color: textColor,
        isBold: true,
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      color: Colors.grey.shade200,
      child: Center(
        child: Icon(Icons.store_mall_directory_outlined, size: 40.sp, color: Colors.grey.shade400),
      ),
    );
  }
}
