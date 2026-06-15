import 'package:brand/core/errors/failure.dart';
import 'package:brand/core/services/api_services.dart';
import 'package:brand/core/services/service_locator.dart';
import 'package:brand/features/product_details/data/models/review_model.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddReviewDialog extends StatefulWidget {
  final String productId, orderId;
  final Function(ReviewModel) onReviewAdded;
  const AddReviewDialog({super.key, required this.productId, required this.orderId, required this.onReviewAdded});
  @override
  State<AddReviewDialog> createState() => _AddReviewDialogState();
}

class _AddReviewDialogState extends State<AddReviewDialog> {
  double _rating = 5.0;
  bool _isLoading = false;
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      title: Text('write_review'.tr(), style: const TextStyle(fontFamily: 'Outfit', fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('your_rating'.tr(), style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (i) => IconButton(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                constraints: const BoxConstraints(),
                icon: Icon(Icons.star, size: 32.sp, color: i < _rating ? Colors.amber : Colors.grey[300]),
                onPressed: _isLoading ? null : () => setState(() => _rating = i + 1.0),
              )),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: _commentController,
              maxLines: 3,
              enabled: !_isLoading,
              style: TextStyle(fontSize: 14.sp),
              decoration: InputDecoration(hintText: 'enter_comment'.tr(), contentPadding: EdgeInsets.all(12.r)),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: _isLoading ? null : () => Navigator.pop(context), child: Text('cancel'.tr())),
        ElevatedButton(
          onPressed: _isLoading ? null : _submitReview,
          child: _isLoading
              ? SizedBox(width: 20.w, height: 20.h, child: const CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
              : Text('submit'.tr()),
        ),
      ],
    );
  }

  Future<void> _submitReview() async {
    final comment = _commentController.text.trim();
    if (comment.isEmpty) return;
    setState(() => _isLoading = true);
    try {
      final res = await sl<ApiService>().postData(endPoint: 'reviews', data: {
        'productId': widget.productId, 'orderId': widget.orderId, 'rating': _rating.toInt(), 'comment': comment,
      });
      if (!mounted) return;
      setState(() => _isLoading = false);
      widget.onReviewAdded(ReviewModel(
        id: res.data['data']?['_id']?.toString() ?? DateTime.now().millisecondsSinceEpoch.toString(),
        userName: 'You', rating: _rating, comment: comment, date: DateTime.now(),
      ));
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Review submitted successfully!'.tr()), backgroundColor: Colors.green));
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      String errMsg = 'Failed to submit review';
      if (e is DioException) {
        if (e.error is Failure) {
          errMsg = (e.error as Failure).errMessage;
        } else if (e.response?.data is Map) {
          errMsg = e.response?.data['message']?.toString() ?? e.message ?? 'Unknown server error';
        } else {
          errMsg = e.message ?? e.toString();
        }
      } else {
        errMsg = e.toString();
      }
      debugPrint("❌ [AddReviewDialog] Error submitting review: $errMsg, full error: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errMsg), backgroundColor: Colors.red));
    }
  }
}
