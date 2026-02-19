import 'package:brand/core/utils/appImages/png_images.dart';
import 'package:brand/features/login/presentation/views/widgets/login_button.dart';
import 'package:flutter/material.dart';

class ContinueWithGoogle extends StatelessWidget {
  const ContinueWithGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginButton(
      text: "Continue With Google",
      image: PngImages.google,
      onPressed: () {},
    );
  }
}
