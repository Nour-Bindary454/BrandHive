import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:brand/core/utils/toast/toast.dart';

class BrandLogoPicker extends StatefulWidget {
  final File? initialImage;
  final Function(File image) onImageSelected;

  const BrandLogoPicker({
    super.key,
    this.initialImage,
    required this.onImageSelected,
  });

  @override
  State<BrandLogoPicker> createState() => _BrandLogoPickerState();
}

class _BrandLogoPickerState extends State<BrandLogoPicker> {
  File? logoImage;

  @override
  void initState() {
    super.initState();
    logoImage = widget.initialImage;
  }

  Future<void> pickLogo() async {
    try {
      debugPrint("Picking logo...");
      final picked = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (picked != null) {
        debugPrint("Logo picked: ${picked.path}");
        final image = File(picked.path);

        setState(() {
          logoImage = image;
        });

        widget.onImageSelected(image);
      } else {
        debugPrint("Logo picking cancelled.");
      }
    } catch (e) {
      debugPrint("Error picking logo: $e");
      if (mounted) {
        Toast.showErrorToast(
          msg: "Error opening gallery. Make sure permissions are granted.",
          context: context,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: pickLogo,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 20.h),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFFE5E5E5)),
        ),
        child: Column(
          children: [
            if (logoImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.file(
                  logoImage!,
                  height: 100.h,
                  width: 100.w,
                  fit: BoxFit.cover,
                ),
              )
            else
              Icon(
                Icons.image_outlined,
                size: 32.sp,
                color: const Color(0xFF8E8E8E),
              ),

            SizedBox(height: 8.h),

            Text(
              logoImage == null ? 'Upload Brand Logo' : 'Change Brand Logo',
              style: TextStyle(
                color: const Color(0xFF2B2B2B),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
