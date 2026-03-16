import 'package:flutter/material.dart';

class MixedBg extends StatelessWidget {
  MixedBg({super.key, required this.lightColor, required this.darkColor});
  final Color lightColor;
  final Color darkColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [lightColor, darkColor],
        ),
      ),
    );
  }
}
