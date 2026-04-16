import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomKeyboard extends StatelessWidget {
  final Function(String) onKeypadPressed;

  const CustomKeyboard({super.key, required this.onKeypadPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 15.h,
        left: 10.w,
        right: 10.w,
        bottom: MediaQuery.of(context).padding.bottom + 15.h,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF2D4373),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildKeyboardRow(['1', '2', '3'], ['', 'ABC', 'DEF']),
          SizedBox(height: 10.h),
          _buildKeyboardRow(['4', '5', '6'], ['GHI', 'JKL', 'MNO']),
          SizedBox(height: 10.h),
          _buildKeyboardRow(['7', '8', '9'], ['PQRS', 'TUV', 'WXYZ']),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildEmptyKey(),
              _buildKey('0', ''),
              _buildBackspaceKey(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKeyboardRow(List<String> numbers, List<String> letters) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(3, (index) {
        return _buildKey(numbers[index], letters[index]);
      }),
    );
  }

  Widget _buildKey(String number, String letters) {
    return GestureDetector(
      onTap: () => onKeypadPressed(number),
      child: Container(
        width: 100.w,
        height: 48.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              number,
              style: TextStyle(
                fontSize: 22.sp,
                color: Colors.black,
                fontWeight: FontWeight.w400,
                height: 1.0,
              ),
            ),
            if (letters.isNotEmpty)
              Text(
                letters,
                style: TextStyle(
                  fontSize: 8.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyKey() {
    return SizedBox(
      width: 100.w,
      height: 48.h,
    );
  }

  Widget _buildBackspaceKey() {
    return GestureDetector(
      onTap: () => onKeypadPressed('backspace'),
      child: Container(
        width: 100.w,
        height: 48.h,
        color: Colors.transparent,
        child: const Center(
          child: Icon(
            Icons.backspace_outlined,
            color: Color(0xFF0F172A),
          ),
        ),
      ),
    );
  }
}
