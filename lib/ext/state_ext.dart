import 'dart:ui';

import 'package:flutter/cupertino.dart';

extension StateExt on State {
  void addPostFrameCallback(FrameCallback f) {
    WidgetsBinding.instance.addPostFrameCallback(f);
  }
}
