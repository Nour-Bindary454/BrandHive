import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';

class Toast {
  static showSuccessToast({
    required String msg,
    required BuildContext context,
  }) => CherryToast.success(
    width: MediaQuery.of(context).size.width * 0.8,
    title: Text(msg, style: const TextStyle(color: BasicColors.black)),
  ).show(context);

  static showErrorToast({required String msg, required BuildContext context}) =>
      CherryToast.error(
        width: MediaQuery.of(context).size.width * 0.8,
        title: Text(msg, style: const TextStyle(color: BasicColors.black)),
      ).show(context);
}
