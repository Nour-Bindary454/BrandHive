import 'package:brand/core/sharedWidgets/basic_button.dart';
import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/sharedWidgets/mixed_bg.dart';
import 'package:brand/core/utils/appImages/png_images.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MixedBg(
            lightColor: BasicColors.linearGradientSLight,
            darkColor: BasicColors.linearGradientSDark,
          ),
          Positioned(
            top: 100,
            right: 50,
            child: Image.asset(PngImages.polygon1),
          ),
          Positioned(
            top: 230,
            right: 170,
            child: Image.asset(PngImages.polygon2),
          ),
          Positioned(
            top: 150,
            left: -40,
            child: Image.asset(PngImages.polygon3),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 200),
                Image.asset(PngImages.logo2),
                SizedBox(height: 30),
                BasicText(text: 'Welcome !', fontSize: 35, isBold: true),
                SizedBox(height: 30),

                BasicButton(
                  onPressed: () {},
                  text: 'Sign in',
                  color: BasicColors.linearGradientSLight,
                  radius: 24,
                  isOutlined: true,
                ),
                SizedBox(height: 20),

                BasicButton(
                  onPressed: () {},
                  text: 'Sign up',
                  color: BasicColors.buttonColorDark,
                  radius: 24,
                  isOutlined: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
