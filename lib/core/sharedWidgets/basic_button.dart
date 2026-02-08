import 'package:flutter/material.dart';

class BasicButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final List<Color> colors; // بنبعت لستة ألوان علطول
  final double radius;

  const BasicButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.colors,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        // التدريجة شغالة دايماً
        gradient: LinearGradient(
          colors: colors.length == 1 ? [colors[0], colors[0]] : colors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
    );
  }
}
