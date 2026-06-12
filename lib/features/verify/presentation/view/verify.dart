import 'package:brand/core/utils/toast/toast.dart';
import 'package:brand/features/verify/presentation/view/widgets/custom_keyboard.dart';
import 'package:brand/features/verify/presentation/view/widgets/otp_inputs.dart';
import 'package:brand/features/verify/presentation/view/widgets/verify_button_section.dart';
import 'package:brand/features/verify/presentation/view/widgets/verify_header.dart';
import 'package:brand/features/verify/presentation/view_model/cubit/confirm_email_cubit.dart';
import 'package:brand/features/forgetPassword/presentaion/viewsModel/verify_reset_code_cubit.dart';
import 'package:brand/features/forgetPassword/presentaion/viewsModel/verify_reset_code_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Verify extends StatefulWidget {
  const Verify({super.key});

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  String otpCode = '';

  void _onKeypadPressed(String value) {
    setState(() {
      if (value == 'backspace') {
        if (otpCode.isNotEmpty) {
          otpCode = otpCode.substring(0, otpCode.length - 1);
        }
      } else {
        if (otpCode.length < 6) {
          otpCode += value;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    String email = '';
    bool isForgetPassword = false;

    if (args is String) {
      email = args;
    } else if (args is Map) {
      email = args['email'] as String;
      isForgetPassword = args['isForgetPassword'] as bool? ?? false;
    }

    return MultiBlocListener(
      listeners: [
        BlocListener<ConfirmEmailCubit, ConfirmEmailState>(
          listener: (context, state) {
            if (state is ConfirmEmailLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) =>
                    const Center(child: CircularProgressIndicator()),
              );
            }

            if (state is ConfirmEmailSuccess) {
              Navigator.pop(context);
              Toast.showSuccessToast(
                msg: "Email verified successfully! Please log in.",
                context: context,
              );
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false,
              );
            }

            if (state is ConfirmEmailError) {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }

              Toast.showErrorToast(msg: state.message, context: context);
            }
          },
        ),
        BlocListener<VerifyResetCodeCubit, VerifyResetCodeStates>(
          listener: (context, state) {
            if (state is VerifyResetCodeLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) =>
                    const Center(child: CircularProgressIndicator()),
              );
            }

            if (state is VerifyResetCodeSuccess) {
              Navigator.pop(context);

              Navigator.pushReplacementNamed(
                context,
                '/resetPassword',
                arguments: email,
              );
            }

            if (state is VerifyResetCodeError) {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }

              Toast.showErrorToast(msg: state.message, context: context);
            }
          },
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      VerifyHeader(email: email),
                      const SizedBox(height: 40),
                      OtpInputs(otpCode: otpCode),
                      const SizedBox(height: 40),

                      VerifyButtonSection(
                        otpCode: otpCode,
                        email: email,
                        isForgetPassword: isForgetPassword,
                      ),
                    ],
                  ),
                ),
              ),

              CustomKeyboard(onKeypadPressed: _onKeypadPressed),
            ],
          ),
        ),
      ),
    );
  }
}
