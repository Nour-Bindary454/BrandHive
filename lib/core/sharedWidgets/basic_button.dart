import 'package:flutter/material.dart';

class BasicButton extends StatefulWidget {
  BasicButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.color,
    required this.radius,
    required this.isOutlined,
  });
  void Function() onPressed;
  String text;
  Color color;
  double radius;
  bool isOutlined;
  @override
  State<BasicButton> createState() => _BasicButtonState();
}

class _BasicButtonState extends State<BasicButton> {
  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 17,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
    );

    // لو هو Outlined نستخدم OutlinedButton.styleFrom ولو لأ نستخدم ElevatedButton.styleFrom
    final buttonStyle = widget.isOutlined
        ? OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.white, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.radius),
            ),
            fixedSize: Size(MediaQuery.of(context).size.width * 0.85, 44),
          )
        : ElevatedButton.styleFrom(
            backgroundColor: widget.color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.radius),
            ),
            fixedSize: Size(MediaQuery.of(context).size.width * 0.85, 44),
          );

    
    return widget.isOutlined
        ? OutlinedButton(
            onPressed: widget.onPressed,
            style: buttonStyle,
            child: Text(widget.text, style: textStyle),
          )
        : ElevatedButton(
            onPressed: widget.onPressed,
            style: buttonStyle,
            child: Text(widget.text, style: textStyle),
          );
  }
}
