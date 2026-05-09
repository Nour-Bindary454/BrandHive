import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_button.dart';
import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/sharedWidgets/basic_text_field.dart';
import 'package:brand/core/sharedWidgets/shared_stack.dart';
import 'package:brand/core/utils/toast/toast.dart';
import 'package:brand/features/signup/presentation/view_model/cubit/register_cubit.dart';
import 'package:brand/features/signup/presentation/view_model/cubit/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          Toast.showSuccessToast(
            msg: state.registerModel.message.toString(),
            context: context,
          );
          Navigator.pushReplacementNamed(
            context,
            '/verify',
            arguments: emailController.text.trim(),
          );
        }
        if (state is SignUpError) {
          Toast.showErrorToast(msg: state.message.toString(), context: context);
        }
      },
      child: BlocBuilder<RegisterCubit, RegisterStates>(
        builder: (context, state) {
          return SharedStack(
            t1: 'Create Account To',
            t2: 'Get Started',
            widget: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.width * 0.085,
              ),
              child: Column(
                children: [
                  BasicTextField(
                    label: 'Full Name',
                    hint: 'Enter your full name',
                    controller: fullNameController,
                    isPassword: false,
                  ),
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
                  BasicTextField(
                    label: 'Confirm Password',
                    hint: 'Re-enter your password',
                    controller: confirmPasswordController,
                    isPassword: true,
                  ),
                  SizedBox(height: 20.h),
                  BasicButton(
                    onPressed: () {
                      context.read<RegisterCubit>().register(
                        name: fullNameController.text.trim(),
                        email: emailController.text.trim(),
                        password: passwordController.text,
                        confirmPassword: confirmPasswordController.text,
                      );
                    },

                    text: "Create Account",
                    colors: [
                      BasicColors.linearGradientSLight,
                      BasicColors.linearGradientSDark,
                    ],
                    radius: 7.65,
                  ),

                  SizedBox(height: 40.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BasicText(
                        text: 'already_have_an_account'.tr().tr(),
                        fontSize: 14.sp,
                        isBold: false,
                        color: BasicColors.linearGradientDark,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: BasicText(
                          text: "Log In",
                          fontSize: 14.sp,

                          color: BasicColors.linearGradientDark,
                          isBold: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
