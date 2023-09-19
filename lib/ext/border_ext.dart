import 'package:flutter/material.dart';
import 'screen_ext.dart';

extension BorderExt on num {
  BorderRadiusGeometry get borderRadius => BorderRadius.all(Radius.circular(w));
}
