import 'package:flutter/material.dart';

extension FrameworkExt on State {
  void setStateBridge(VoidCallback fn) {
    if (!mounted) {
      return;
    }
    setState(() {
      fn.call();
    });
  }
}
