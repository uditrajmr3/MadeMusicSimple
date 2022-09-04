import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ToastClass {
  void successToast(BuildContext context, String text) {
    VxToast.show(context,
        msg: text,
        bgColor: Colors.green.shade100,
        textColor: Colors.green.shade500,
        textSize: 14,
        position: VxToastPosition.center);
  }

  void failureToast(BuildContext context, String e) {
    VxToast.show(context,
        msg: "Error: $e",
        bgColor: Colors.red.shade100,
        textColor: Colors.red.shade500,
        textSize: 14,
        position: VxToastPosition.center);
  }
}
