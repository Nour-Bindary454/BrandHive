import 'package:flutter/material.dart';

class BasicTextField extends StatefulWidget {
  BasicTextField({super.key,required this.label,required this.hint,required this.controller,required this.isPassword});
final String label;
final String hint;
final TextEditingController controller;
final bool isPassword;
  @override
  State<BasicTextField> createState() => _BasicTextFieldState();
}

class _BasicTextFieldState extends State<BasicTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF5B5B5C), // لون رمادي هادي زي الصورة
          ),
        ),
        SizedBox(height: 8),
       SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        height: 44,
        
        
         child: TextField(
          obscureText: widget.isPassword,
          controller: widget.controller,
          decoration: InputDecoration(
           hintText: widget.hint,
            hintStyle: const TextStyle(color: Color(0xFF8E8E8E), fontSize: 14, fontFamily: 'Poppins'),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            // شكل الحدود وهي مش متداس عليها
            enabledBorder: OutlineInputBorder(

              borderRadius: BorderRadius.circular(8), // الحواف الدائرية
              borderSide: const BorderSide(color: Color(0xFFD1D1D1)), // لون الحدود الرمادي
             
            ),
            
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFD1D1D1), width: 2), 
            ),
            filled: true,
            fillColor: Colors.white,
          ),
               ),
       ),
      SizedBox(height: 16),
    ],);
  }
}