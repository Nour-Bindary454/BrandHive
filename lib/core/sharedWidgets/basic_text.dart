import 'package:flutter/material.dart';

class BasicText extends StatelessWidget {
  BasicText({
    super.key,
    required this.text,
    required this.fontSize,
   // required this.fontWeight,
    required this.isBold,
  });
  String text;
  double fontSize;
  //FontWeight fontWeight;
  bool isBold;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: fontSize,
        fontFamily: 'Poppins',
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
