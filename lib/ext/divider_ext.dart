import 'package:flutter/material.dart';

import 'screen_ext.dart';

extension DividerExt on num {
  Widget dividerH({Color color = const Color(0XFFE1E1E1)}) {
    return Divider(
      height: h,
      color: color,
    );
  }

  Divider get indentDivider {
    return Divider(
      height: 1,
      indent: w,
      endIndent: w,
      color: const Color(0xffe8e8f0),
    );
  }

  Divider divider({Color color = const Color(0xfff0f0f0), double indent = 0, double endIndent = 0}) {
    return Divider(
      height: 1,
      indent: indent.w,
      endIndent: endIndent.w,
      color: color,
    );
  }

  Widget verticalDivider({Color color = const Color(0xfff0f0f0), double? height}) {
    return Container(
      height: height ?? double.infinity,
      width: toDouble(),
      color: color,
    );
  }
}
