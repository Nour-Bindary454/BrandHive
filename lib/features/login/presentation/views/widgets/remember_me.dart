import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class RememberMe extends StatefulWidget {
  const RememberMe({super.key});

  @override
  State<RememberMe> createState() => _RememberMeState();
}

class _RememberMeState extends State<RememberMe> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 155.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.check_box_outline_blank_rounded,
              color: Color(0xff2C3F52),
              size: 20.sp,
            ),
          ),
          BasicText(
            text: 'remember_me'.tr().tr(),
            fontSize: 13.sp,
            isBold: true,
            color: Color(0xff2C3F52),
          ),
        ],
      ),
    );
  }
}
