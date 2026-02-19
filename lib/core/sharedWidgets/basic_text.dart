import 'package:flutter/material.dart';

class BasicText extends StatelessWidget {
  BasicText({
    super.key,
    required this.text,
    required this.fontSize,
    required this.color,
    required this.isBold,
  });
  final String text;
  final double fontSize;
  final Color color;
  final bool isBold;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: 'Poppins',
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
