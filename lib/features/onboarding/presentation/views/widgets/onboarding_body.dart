import 'package:flutter/material.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart'; // تأكدي من المسارات بتاعتك

class OnboardingBody extends StatelessWidget {
  final String image, t1, t2, s1, s2;

  const OnboardingBody({
    super.key,
    required this.image,
    required this.t1,
    required this.t2,
    required this.s1,
    required this.s2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 280, fit: BoxFit.contain),
          const SizedBox(height: 30),
          BasicText(text: t1, fontSize: 24, isBold: true),
          BasicText(text: t2, fontSize: 24, isBold: true),
          const SizedBox(height: 20),
          BasicText(text: s1, fontSize: 20, isBold: false),
          BasicText(text: s2, fontSize: 20, isBold: false),
        ],
      ),
    );
  }
}
