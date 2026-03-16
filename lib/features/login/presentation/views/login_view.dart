import 'package:brand/core/sharedWidgets/basic_button.dart';
import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/sharedWidgets/basic_text_field.dart';
import 'package:brand/core/sharedWidgets/shared_stack.dart';
import 'package:brand/features/login/presentation/views/widgets/continue_with_face.dart';
import 'package:brand/features/login/presentation/views/widgets/continue_with_google.dart';
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

            Padding(
              padding: const EdgeInsets.only(right: 25, left: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RememberMe(),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/forgetPassword');
                    },
                    child: BasicText(
                      text: "Forget Password?",
                      fontSize: 13,
                      color: Color(0xff2C3F52),
                      isBold: true,
                    ),
                  ),
                ],
              ),
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
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 100, child: Divider(color: Color(0xff4E5052))),
                SizedBox(width: 10),
                BasicText(
                  text: 'Or',
                  fontSize: 13,
                  color: Color(0xff4E5052),
                  isBold: false,
                ),
                SizedBox(width: 15),

                SizedBox(width: 100, child: Divider(color: Color(0xff4E5052))),
              ],
            ),
            SizedBox(height: 20),
            ContinueWithGoogle(),
            SizedBox(height: 10),
            ContinueWithFace(),
          ],
        ),
      ),
    );
  }
}
