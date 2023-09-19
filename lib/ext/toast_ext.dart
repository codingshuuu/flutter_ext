import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension ToastExt on String {
  void toast({
    double? fontSize,
    ToastGravity? gravity,
    Color? backgroundColor,
    Color? textColor,
  }) {
    if (isEmpty) {
      return;
    }
    Fluttertoast.showToast(
      msg: this,
      gravity: gravity ?? ToastGravity.CENTER,
      backgroundColor: backgroundColor ?? Colors.black54,
      textColor: textColor ?? Colors.white,
      fontSize: fontSize ?? 16.0,
    );
  }

  ///复制到粘贴版
  Future<void> copy2Clipboard() {
    return Clipboard.setData(ClipboardData(text: this));
  }
}
