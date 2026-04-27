import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key, this.color, this.size});
  final Color? color;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.threeArchedCircle(
        size: size ?? 50,
        color: color ?? BasicColors.buttonColorDark,
      ),
    );
  }
}
