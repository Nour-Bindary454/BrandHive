import 'dart:async';

import 'package:brand/features/login/presentation/views/login_view.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Login()));
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
        position(
          top:0,
          right:0,
          child:Image.asset(
            
            PngImages.splashTop,
            width: mediaQuery.size.width * 0.35,
          )            
        )
        ],
      ),
    );
  }
}