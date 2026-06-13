import 'package:flutter/material.dart';

class BasicText extends StatelessWidget {
  const BasicText({
    super.key,
    required this.text,
    required this.fontSize,
    this.color = const Color(0xFF0F172A),
    this.isBold = false,
    this.textAlign,
    this.fontFamily = 'Poppins',
    this.maxLines,
  });
  final String text;
  final double fontSize;
  final Color color;
  final bool isBold;
  final TextAlign? textAlign;
  final String? fontFamily;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: fontFamily,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
