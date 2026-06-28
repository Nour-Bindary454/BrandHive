import 'package:flutter/material.dart';

class BasicText extends StatelessWidget {
  const BasicText({
    super.key,
    required this.text,
    required this.fontSize,
    required this.color,
    required this.isBold,
    this.textAlign,
    this.fontFamily = 'Poppins',
  });
  final String text;
  final double fontSize;
  final Color color;
  final bool isBold;
  final TextAlign? textAlign;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: fontFamily,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
