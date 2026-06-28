import 'package:brand/features/product_details/data/models/review_model.dart';
import 'package:brand/features/product_details/presentation/views/widgets/review_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewsList extends StatelessWidget {
  final List<ReviewModel> reviews;
  final bool isLoading;

  const ReviewsList({
    super.key,
    required this.reviews,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: const Center(
          child: CircularProgressIndicator(color: Color(0xFF2D4373)),
        ),
      );
    }

    if (reviews.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Center(
          child: Text(
            'empty_reviews'.tr(),
            style: TextStyle(color: Colors.grey, fontSize: 13.sp),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: reviews.length,
      itemBuilder: (context, index) => ReviewCard(review: reviews[index]),
    );
  }
}
