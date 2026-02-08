import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:flutter/material.dart';

class RememberMe extends StatefulWidget {
  const RememberMe({super.key});

  @override
  State<RememberMe> createState() => _RememberMeState();
}

class _RememberMeState extends State<RememberMe> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 155,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.check_box_outline_blank_rounded,
              color: Color(0xff2C3F52),
              size: 20,
            ),
          ),
          BasicText(
            text: 'Remember Me',
            fontSize: 13,
            isBold: true,
            color: Color(0xff2C3F52),
          ),
        ],
      ),
    );
  }
}
