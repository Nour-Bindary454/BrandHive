import 'package:flutter/material.dart';

class OtpInputs extends StatelessWidget {
  final String otpCode;

  const OtpInputs({super.key, required this.otpCode});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (index) {
        return Container(
          width: 50,
          height: 55,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              index < otpCode.length ? otpCode[index] : '',
              style: const TextStyle(fontSize: 22),
            ),
          ),
        );
      }),
    );
  }
}
