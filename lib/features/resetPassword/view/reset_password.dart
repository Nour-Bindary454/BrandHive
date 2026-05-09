import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/services/service_locator.dart';
import 'package:brand/core/sharedWidgets/backarrow.dart';
import 'package:brand/core/sharedWidgets/basic_button.dart';
import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/sharedWidgets/basic_text_field.dart';
import 'package:brand/features/passwordChanged/password_changed.dart';
import 'package:brand/features/resetPassword/viewsModel/change_pass_cubit.dart';
import 'package:brand/features/resetPassword/viewsModel/change_pass_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPassword extends StatefulWidget {
  final String email;
  const ResetPassword({super.key, required this.email});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ChangePassCubit>(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: BlocConsumer<ChangePassCubit, ChangePassState>(
              listener: (context, state) {
                if (state is ChangePassSuccess) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PasswordChanged(),
                    ),
                  );
                } else if (state is ChangePassFailure) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.error)));
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),

                    CustomBackarrow(),
                    SizedBox(height: 45.h),

                    BasicText(
                      text: 'reset_password'.tr(),
                      fontSize: 28,
                      color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
                      isBold: true,
                    ),

                    BasicText(
                      text: 'please_type_something_you_ll_remember'.tr(),
                      fontSize: 12,
                      color: const Color.fromARGB(255, 28, 28, 28),
                      isBold: false,
                    ),

                    SizedBox(height: 45.h),

                    Column(
                      children: [
                        SizedBox(width: double.infinity),

                        BasicTextField(
                          label: 'New Password',
                          hint: 'At least 8 characters',
                          controller: passwordController,
                          isPassword: true,
                        ),

                        SizedBox(height: 10.h),

                        BasicTextField(
                          label: 'Confirm Password',
                          hint: 'repeat password',
                          controller: confirmPasswordController,
                          isPassword: true,
                        ),

                        SizedBox(height: 45.h),

                        state is ChangePassLoading
                            ? const CircularProgressIndicator()
                            : BasicButton(
                                text: 'reset_password'.tr(),
                                colors: const [Color(0xFF2D4373)],
                                radius: 12.r,
                                onPressed: () {
                                  if (passwordController.text !=
                                      confirmPasswordController.text) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('passwords_don_t_match'.tr()),
                                      ),
                                    );
                                    return;
                                  }

                                  context.read<ChangePassCubit>().changePassword(
                                    email: widget.email,
                                    password: passwordController.text,
                                  );
                                },
                              ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
