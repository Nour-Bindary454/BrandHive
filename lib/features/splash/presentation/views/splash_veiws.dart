import 'dart:async';

import 'package:brand/core/utils/appImages/png_images.dart';

import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/onboarding');
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: mediaQuery.size.width,
            height: mediaQuery.size.height,
            color: Colors.white,
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              PngImages.frametop,
              width: mediaQuery.size.width * 0.69,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              PngImages.framebottom,
              width: mediaQuery.size.width * 0.95,
            ),
          ),
          Center(
            child: Image.asset(
              PngImages.logo,
            ),
          ),
        ],
      ),
    );
  }
}
