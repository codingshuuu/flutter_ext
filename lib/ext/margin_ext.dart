import 'package:flutter/material.dart';

import 'screen_ext.dart';

extension MarginIntExt on num {
  EdgeInsetsGeometry marginHorizontal() {
    return EdgeInsets.symmetric(horizontal: w);
  }

  EdgeInsets marginVertical() {
    return EdgeInsets.symmetric(vertical: h);
  }

  EdgeInsets marginLeft() {
    return EdgeInsets.only(left: w);
  }

  EdgeInsets marginRight() {
    return EdgeInsets.only(right: w);
  }

  EdgeInsets marginTop() {
    return EdgeInsets.only(top: h);
  }

  EdgeInsets marginBottom() {
    return EdgeInsets.only(bottom: h);
  }

  EdgeInsets marginAll() {
    return EdgeInsets.all(h);
  }

  EdgeInsets marginHV(int vertical) {
    return EdgeInsets.symmetric(horizontal: h, vertical: vertical.h);
  }
}
