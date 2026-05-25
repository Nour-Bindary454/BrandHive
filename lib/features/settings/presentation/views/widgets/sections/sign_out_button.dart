import 'package:brand/core/services/cache_helper.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton.icon(
        onPressed: () async {
          await CacheHelper.removeData(key: 'token');
          await CacheHelper.removeData(key: 'role');
          if (context.mounted) {
            Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
          }
        },
        icon: const Icon(CupertinoIcons.arrow_right_square, color: Color(0xFFDC2626)),
        label: BasicText(
          text: "sign_out".tr(),
          fontSize: 16.sp,
          color: const Color(0xFFDC2626),
          isBold: true,
        ),
      ),
    );
  }
}
