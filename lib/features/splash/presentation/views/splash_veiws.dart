import 'dart:async';

import 'package:brand/core/utils/appImages/png_images.dart';
import 'package:brand/core/services/cache_helper.dart';

import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      final token = CacheHelper.getData(key: 'token');
      if (token != null && token.isNotEmpty) {
        Navigator.pushReplacementNamed(context, '/mainlayout');
      } else {
        Navigator.pushReplacementNamed(context, '/onboarding');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Container(color: Colors.white)),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              PngImages.frametop,
              width: mediaQuery.size.width * 0.7,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              PngImages.framebottom,
              width: mediaQuery.size.width,
              fit: BoxFit.cover,
            ),
          ),
          Center(child: Image.asset(PngImages.logo, width: 260)),
        ],
      ),
    );
  }
}
