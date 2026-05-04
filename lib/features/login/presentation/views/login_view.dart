import 'package:brand/core/services/service_locator.dart';
import 'package:brand/core/sharedWidgets/basic_button.dart';
import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/sharedWidgets/basic_text_field.dart';
import 'package:brand/core/sharedWidgets/shared_stack.dart';
import 'package:brand/core/utils/toast/toast.dart';

import 'package:brand/features/login/presentation/viewsModel/login_cubit.dart';
import 'package:brand/features/login/presentation/viewsModel/login_states.dart';
import 'package:brand/features/main_layout/presentation/views/mainlayout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LoginCubit>(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Toast.showSuccessToast(
              msg: state.model.message.toString(),
              context: context,
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Mainlayout()),
            );
          }

          if (state is LoginError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },

        builder: (context, state) {
          return AbsorbPointer(
            absorbing: state is LoginLoading,
            child: SharedStack(
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
                      controller: emailController,
                      isPassword: false,
                    ),

                    BasicTextField(
                      label: 'Password',
                      hint: 'At least 8 character',
                      controller: passwordController,
                      isPassword: true,
                    ),

                    Padding(
                      padding: EdgeInsets.only(right: 25.w, left: 25.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/forgetPassword');
                            },
                            child: BasicText(
                              text: "Forget Password?",
                              fontSize: 13.sp,
                              color: Color(0xff2C3F52),
                              isBold: true,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 40.h), // مساحة أكبر للزر

                    BasicButton(
                      onPressed: () {
                        if (state is LoginLoading) return;

                        context.read<LoginCubit>().login(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                      },
                      text: state is LoginLoading ? "Loading..." : "Log In",
                      colors: [
                        BasicColors.linearGradientSLight,
                        BasicColors.linearGradientSDark,
                      ],
                      radius: 7.65,
                    ),

                    SizedBox(height: 60.h), // مساحة إضافية لتوزيع العناصر بشكل أفضل

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BasicText(
                          text: "Don't have an account?",
                          fontSize: 14.sp,
                          color: const Color(0xff4E5052),
                          isBold: false,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: BasicText(
                            text: "Sign Up",
                            fontSize: 14.sp,
                            color: const Color(0xFF2D4373),
                            isBold: true,
                          ),
                        ),
                      ],
                    ),


                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
