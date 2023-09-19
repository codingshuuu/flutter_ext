import 'package:flutter/material.dart';


extension ColorExt on String {
  Color get color {
    try {
      String hexColor = this;
      if (hexColor.isEmpty) {
        return Colors.amber;
      }
      hexColor = hexColor.toUpperCase().replaceAll('#', '');
      hexColor = hexColor.replaceAll('0X', '');
      if (hexColor.length == 6) {
        hexColor = 'FF$hexColor';
      }
      return Color(int.parse(hexColor, radix: 16));
    } catch (e) {
      debugPrint('color 解析异常,异常值:$this,$e');
    }
    return Colors.amber;
  }
}
