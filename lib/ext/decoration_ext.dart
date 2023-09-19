import 'package:flutter/material.dart';
import '../ext/screen_ext.dart';

extension DecorationDoubleExt on num {
  Decoration topLeftRightDecoration(Color color) {
    return ShapeDecoration(
        color: color,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(w), topRight: Radius.circular(w))));
  }

  Decoration leftDecoration(Color color) {
    return ShapeDecoration(
        color: color,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(w), topLeft: Radius.circular(w))));
  }

  Decoration roundedDecoration(Color color) {
    return ShapeDecoration(
        color: color, shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(w))));
  }

  BoxDecoration boxDecoration(Color bgColor, {Color borderColor = const Color(0XFFE1E1E1), double borderWidth = 0.5}) {
    return BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(w)),
        border: Border.all(color: borderColor, width: borderWidth),
        color: bgColor);
  }

  InputDecoration roundedInputDecoration(
      {String? hintText,
      TextStyle? hintStyle,
      Color borderSizeColor = Colors.transparent,
      Color? fillColor,
      EdgeInsetsGeometry? contentPadding}) {
    return InputDecoration(
      contentPadding: contentPadding,
      hintText: hintText,
      hintStyle: hintStyle,
      filled: fillColor != null,
      counterText: '',
      fillColor: fillColor ?? Colors.transparent,
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(w)), borderSide: BorderSide(color: borderSizeColor)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(w)), borderSide: BorderSide(color: borderSizeColor)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(w)), borderSide: BorderSide(color: borderSizeColor)),
    );
  }

  Decoration shadowDecoration(Color color) {
    return BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(w)),
        boxShadow: [BoxShadow(color: const Color(0x14000000), offset: Offset(0, 3.h), blurRadius: 3.0)]);
  }

  static const box = BoxDecoration(
    color: Colors.white,
    border: Border.fromBorderSide(BorderSide(color: Colors.white54, width: 1)),
    borderRadius: BorderRadius.all(Radius.circular(15)),
  );

  Decoration radiusDecoration(
      {Color? color, double? topLeft, double? topRight, double? bottomLeft, double? bottomRight}) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.only(
          topLeft: topLeft != null ? Radius.circular(topLeft) : Radius.zero,
          topRight: topRight != null ? Radius.circular(topRight) : Radius.zero,
          bottomLeft: bottomLeft != null ? Radius.circular(bottomLeft) : Radius.zero,
          bottomRight: bottomRight != null ? Radius.circular(bottomRight) : Radius.zero),
    );
  }

  Decoration bottomBorder({required Color color, double? width, Color? bgColor, bool bottom = true, bool top = false}) {
    return BoxDecoration(
        color: bgColor,
        border: Border(
          bottom: bottom ? BorderSide(color: color, width: width ?? 1.w) : BorderSide.none,
          top: top ? BorderSide(color: color, width: width ?? 1.w) : BorderSide.none,
        ));
  }
}
