import 'package:flutter/material.dart';

import 'screen_ext.dart';

extension StyleExt on int {
  TextStyle textStyle(
    Color color, {
    bool bold = false,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
  }) {
    return TextStyle(
      color: color,
      fontSize: sp,
      fontWeight: fontWeight ?? (bold ? FontWeight.bold : FontWeight.normal),
      letterSpacing: letterSpacing,
      height: height,
      decoration: TextDecoration.none,
    );
  }
}
