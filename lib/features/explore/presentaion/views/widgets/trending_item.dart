import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:flutter/material.dart';

class TrendingItemName extends StatelessWidget {
  const TrendingItemName({super.key, required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 243, 241, 241),
        borderRadius: BorderRadius.circular(20),
      ),
      child: BasicText(
        text: label,
        color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
        fontSize: 13,
        isBold: true,
      ),
    );
  }
}
