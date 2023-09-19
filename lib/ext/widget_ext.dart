import 'dart:ui';

import 'package:flutter/cupertino.dart';
import '../ext/screen_ext.dart';

extension WidgetExt on Widget {
  addPostFrameCallback(FrameCallback frameCallback) {
    WidgetsBinding.instance.addPostFrameCallback(frameCallback);
  }
}

extension WidgetNumExt on num {
  Widget toLine(Color color, {double? width}) {
    return Container(
      color: color,
      height: w,
      width: width ?? double.infinity,
    );
  }

  Widget toLineW(Color color, {double? height}) {
    return Container(
      color: color,
      width: w,
      height: height ?? double.infinity,
    );
  }
}
