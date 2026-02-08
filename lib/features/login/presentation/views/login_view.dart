import 'package:brand/core/sharedWidgets/basic_button.dart';
import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/sharedWidgets/basic_text_field.dart';
import 'package:brand/core/sharedWidgets/shared_stack.dart';
import 'package:brand/features/login/presentation/views/widgets/forget_password.dart';
import 'package:brand/features/login/presentation/views/widgets/remember_me.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return SharedStack(
      t1: 'Sign in to your',
      t2: 'Account',
      widget: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.width * 0.085,
        ),
        child: Column(
          children: [
            BasicTextField(
              label: 'Email',
              hint: 'Example@gmail.com',
              controller: TextEditingController(),
              isPassword: false,
            ),
            BasicTextField(
              label: 'Password',
              hint: 'At least 8 character',
              controller: TextEditingController(),
              isPassword: true,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [RememberMe(), ForgetPassword()],
            ),
            SizedBox(height: 20),
            BasicButton(
              onPressed: () {},
              text: "Log In",
              colors: [
                BasicColors.linearGradientSLight,
                BasicColors.linearGradientSDark,
              ],
              radius: 7.65,
            ),
          ],
        ),
      ),
    );
  }
}
