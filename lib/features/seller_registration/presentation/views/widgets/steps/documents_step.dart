import 'package:brand/features/seller_registration/presentation/views/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DocumentsStep extends StatelessWidget {
  const DocumentsStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          stepNumber: '04',
          title: 'Documents',
          icon: Icons.description_outlined,
        ),
        _buildUploadField('National ID / Passport'),
        SizedBox(height: 16.h),
        _buildUploadField('Commercial Register (Optional)'),
        SizedBox(height: 16.h),
        _buildUploadField('Tax Card (Optional)'),
      ],
    );
  }

  Widget _buildUploadField(String title) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFFE5E5E5),
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.cloud_upload_outlined,
            color: const Color(0xFF8E8E8E),
            size: 32.sp,
          ),
          SizedBox(height: 8.h),
          Text(
            'Upload $title',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF2B2B2B),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'PDF, JPG, PNG up to 10MB',
            style: TextStyle(
              color: const Color(0xFF8E8E8E),
              fontSize: 10.sp,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
