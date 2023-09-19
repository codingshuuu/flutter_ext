import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastExt {
  static void toast(
    String? msg,
    double? fontSize,
    ToastGravity? gravity,
    Color? backgroundColor,
    Color? textColor,
  ) {
    if (null == msg || msg.isEmpty) {
      return;
    }
    Fluttertoast.showToast(
        msg: msg, fontSize: fontSize, gravity: gravity, backgroundColor: backgroundColor, textColor: textColor);
  }
}

extension MToastExt on String {
  void toast() {
    if (isNotEmpty) {
      Fluttertoast.showToast(msg: this);
    }
  }

  ///复制到粘贴版
  void copy2Clipboard() {
    debugPrint('copy=>$this');
    Clipboard.setData(ClipboardData(text: this));
  }
}
