import 'package:easy_localization/easy_localization.dart';
import 'dart:async';

import 'package:brand/core/sharedWidgets/basic_button.dart';
import 'package:brand/core/services/api_services.dart';
import 'package:brand/core/services/end_points.dart';
import 'package:brand/core/services/service_locator.dart';
import 'package:brand/core/utils/toast/toast.dart';
import 'package:brand/features/forgetPassword/presentaion/viewsModel/verify_reset_code_cubit.dart';
import 'package:brand/features/verify/presentation/view_model/cubit/confirm_email_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyButtonSection extends StatefulWidget {
  final String otpCode;
  final String email;
  final bool isForgetPassword;

  const VerifyButtonSection({
    super.key,
    required this.otpCode,
    required this.email,
    this.isForgetPassword = false,
  });

  @override
  State<VerifyButtonSection> createState() => _VerifyButtonSectionState();
}

class _VerifyButtonSectionState extends State<VerifyButtonSection> {
  int seconds = 20;
  late Timer timer;
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (seconds == 0) {
        t.cancel();
      } else {
        setState(() {
          seconds--;
        });
      }
    });
  }

  void resetTimer() {
    setState(() {
      seconds = 20;
    });
    startTimer();
  }

  void _resendCode() async {
    final apiService = sl<ApiService>();
    try {
      if (widget.isForgetPassword) {
        await apiService.postData(
          endPoint: EndPoints.forgetPassword,
          data: {"email": widget.email},
        );
      } else {
        await apiService.postData(
          endPoint: EndPoints.resendOtp,
          data: {"email": widget.email},
        );
      }
      if (mounted) {
        Toast.showSuccessToast(msg: "Code sent successfully", context: context);
      }
      resetTimer();
    } catch (e) {
      if (mounted) {
        Toast.showErrorToast(msg: "Failed to send code", context: context);
      }
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BasicButton(
          text: 'verify'.tr().tr(),
          colors: const [Color(0xFF2D4373)],
          radius: 12,
          onPressed: () {
            if (widget.otpCode.length < 6) return;

            if (widget.isForgetPassword) {
              context.read<VerifyResetCodeCubit>().verifyResetCode(
                email: widget.email,
                otp: widget.otpCode,
              );
            } else {
              context.read<ConfirmEmailCubit>().confirmEmail(
                email: widget.email,
                otp: widget.otpCode,
              );
            }
          },
        ),

        const SizedBox(height: 20),

        TextButton(
          onPressed: seconds == 0 ? _resendCode : null,
          child: Text(
            seconds == 0
                ? "Resend code"
                : "Send code again 00:${seconds.toString().padLeft(2, '0')}",
            style: TextStyle(
              color: seconds == 0 ? Colors.black : Colors.grey,
              fontSize: 14,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ],
    );
  }
}
