import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: BasicText(
        text: "Forget Password?",
        fontSize: 13,
        color: Color(0xff2C3F52),
        isBold: true,
      ),
    );
  }
}
