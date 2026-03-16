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
                BasicText(
                  text: 'Welcome !',
                  fontSize: 35,
                  isBold: true,
                  color: Colors.white,
                ),
                SizedBox(height: 30),

                OutlinedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    fixedSize: Size(
                      MediaQuery.of(context).size.width * 0.85,
                      44,
                    ),
                  ),
                  child: BasicText(
                    text: 'Sign in',
                    fontSize: 17,
                    isBold: false,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                BasicButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/signup');
                  },
                  text: 'Sign up',

                  radius: 24,
                  colors: [BasicColors.buttonColorDark],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
