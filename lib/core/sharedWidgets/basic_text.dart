import 'package:flutter/material.dart';

class BasicText extends StatelessWidget {
  BasicText({
    super.key,
    required this.text,
    required this.fontSize,
    required this.color,
    required this.isBold,
  });
  String text;
  double fontSize;

  Color color;
  bool isBold;
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
