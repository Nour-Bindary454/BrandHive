import 'package:brand/core/services/api_services.dart';
import 'package:brand/core/services/cache_helper.dart';
import 'package:brand/core/services/end_points.dart';
import 'package:brand/core/services/service_locator.dart';
import 'package:brand/features/brand_profile/data/models/product_model.dart';
import 'package:brand/features/product_details/data/models/review_model.dart';
import 'package:brand/features/product_details/presentation/views/widgets/add_review_dialog.dart';
import 'package:brand/features/product_details/presentation/views/widgets/reviews_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductReviewsSection extends StatefulWidget {
  final Product product;
  const ProductReviewsSection({super.key, required this.product});
  @override
  State<ProductReviewsSection> createState() => _ProductReviewsSectionState();
}

class _ProductReviewsSectionState extends State<ProductReviewsSection> {
  List<ReviewModel> _reviews = [];
  bool _canWriteReview = false, _isCheckingPurchase = true, _isLoadingReviews = true;
  String? _deliveredOrderId;

  @override
  void initState() {
    super.initState();
    _checkPurchaseStatus();
    _fetchReviews();
  }

  Future<void> _fetchReviews() async {
    try {
      final res = await sl<ApiService>().getData(endPoint: EndPoints.productReviews(widget.product.id));
      final List data = res.data['data'] ?? [];
      if (mounted) {
        setState(() {
          _reviews = data.map((e) => ReviewModel.fromJson(e)).toList();
          _isLoadingReviews = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _isLoadingReviews = false);
    }
  }

  Future<void> _checkPurchaseStatus() async {
    final token = CacheHelper.getData(key: 'token'), role = CacheHelper.getData(key: 'role')?.toLowerCase();
    if (token == null || token.isEmpty || role == 'admin') {
      if (mounted) setState(() => _isCheckingPurchase = false);
      return;
    }
    try {
      final response = await sl<ApiService>().getData(endPoint: 'orders/my-orders');
      final List data = response.data['data'] ?? [];
      for (var order in data) {
        if (order['status']?.toString().toLowerCase() == 'delivered') {
          final items = order['items'] as List?;
          final hasProd = items?.any((item) => (item['product'] is Map ? (item['product']['_id'] ?? item['product']['id']) : item['product'])?.toString() == widget.product.id) ?? false;
          if (hasProd) {
            if (mounted) {
              setState(() {
                _deliveredOrderId = (order['_id'] ?? order['id'])?.toString();
                _canWriteReview = true;
                _isCheckingPurchase = false;
              });
            }
            return;
          }
        }
      }
      if (mounted) setState(() => _isCheckingPurchase = false);
    } catch (_) {
      if (mounted) setState(() => _isCheckingPurchase = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('reviews'.tr(), style: TextStyle(fontFamily: 'Outfit', fontSize: 18.sp, fontWeight: FontWeight.bold)),
              if (_isCheckingPurchase)
                SizedBox(width: 16.w, height: 16.h, child: const CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF2D4373)))
              else if (_canWriteReview)
                TextButton.icon(
                  onPressed: () => showDialog(context: context, builder: (ctx) => AddReviewDialog(productId: widget.product.id, orderId: _deliveredOrderId!, onReviewAdded: (r) => setState(() => _reviews.insert(0, r)))),
                  icon: Icon(Icons.rate_review_outlined, size: 16.sp),
                  label: Text('write_review'.tr(), style: TextStyle(fontSize: 12.sp)),
                ),
            ],
          ),
          SizedBox(height: 8.h),
          ReviewsList(reviews: _reviews, isLoading: _isLoadingReviews),
        ],
      ),
    );
  }
}
