import 'package:brand/core/sharedWidgets/basic_button.dart';
import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/sharedWidgets/mixed_bg.dart';
import 'package:brand/core/utils/appImages/png_images.dart';
import 'package:flutter/material.dart';

class OnboardingSec extends StatelessWidget {
  const OnboardingSec({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MixedBg(lightColor: Color(0xFF4C79BD), darkColor: Color(0xFF37485A)),

          Padding(
            padding: const EdgeInsets.only(bottom: 50, top: 50),

            child: Column(
              children: [
                Image.asset(PngImages.womenOnlineShopping),

                SizedBox(height: 20),

                BasicText(
                  text: 'The Home of Local',

                  fontSize: 24,

                  isBold: true,
                ),

                BasicText(text: 'Egyptian Brands', fontSize: 24, isBold: true),

                SizedBox(height: 20),

                BasicText(
                  text: 'Find, explore, and shop',

                  fontSize: 20,

                  isBold: false,
                ),

                BasicText(
                  text: 'from trusted local sellers',

                  fontSize: 20,

                  isBold: false,
                ),

                SizedBox(height: 20),

                BasicButton(
                  onPressed: () {},
                  isOutlined: false,
                  text: "Get Started",

                  color: BasicColors.buttonColorDark,

                  radius: 24,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
