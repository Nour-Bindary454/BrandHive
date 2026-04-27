import 'package:brand/core/services/service_locator.dart';
import 'package:brand/core/sharedWidgets/basic_button.dart';
import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/sharedWidgets/basic_text_field.dart';
import 'package:brand/core/sharedWidgets/shared_stack.dart';
import 'package:brand/features/login/presentation/views/widgets/continue_with_face.dart';
import 'package:brand/features/login/presentation/views/widgets/continue_with_google.dart';
import 'package:brand/features/login/presentation/views/widgets/remember_me.dart';
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RememberMe(),
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

                    SizedBox(height: 20.h),

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

                    SizedBox(height: 30.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100.w,
                          child: Divider(color: Color(0xff4E5052)),
                        ),
                        SizedBox(width: 10.w),
                        BasicText(
                          text: 'Or',
                          fontSize: 13.sp,
                          color: Color(0xff4E5052),
                          isBold: false,
                        ),
                        SizedBox(width: 15.w),
                        SizedBox(
                          width: 100.w,
                          child: Divider(color: Color(0xff4E5052)),
                        ),
                      ],
                    ),

                    SizedBox(height: 20.h),

                    ContinueWithGoogle(),
                    SizedBox(height: 10.h),
                    ContinueWithFace(),
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
