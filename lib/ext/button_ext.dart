import 'package:flutter/material.dart';
import 'package:flutter_ext/ext/decoration_ext.dart';
import 'package:flutter_ext/ext/screen_ext.dart';
import 'package:flutter_ext/ext/style_ext.dart';
import 'package:flutter_ext/ext/margin_ext.dart';

extension ButtonExt on String {
  ///填充主题色, 按钮文字为白色
  ///[backgroundColor] 背景填充色，没有则用主题色
  Widget buttonElev(void Function() onPressed,
      {double? width,
      double? height,
      int? textSize,
      Color? textColor,
      Color? backgroundColor,
      double? radius,
      VoidCallback? onLongPress,
      bool removeShadow = false}) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 46.h,
      child: ElevatedButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        style: ButtonStyle(
          shadowColor: MaterialStateProperty.all(removeShadow ? Colors.transparent : Colors.black),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
          backgroundColor: backgroundColor == null ? null : MaterialStateProperty.all(backgroundColor),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 6.h))),
        ),
        child: Text(
          this,
          style: (textSize ?? 14).textStyle(textColor ?? Colors.white),
        ),
      ),
    );
  }

  /// 渐变色按钮
  Widget buttonGradient(
    Gradient gradient,
    VoidCallback? onPressed, {
    double? width,
    double? height,
    double? textSize,
    double? radius,
    Color textColor = Colors.white,
    VoidCallback? onLongPress,
    Widget? child,
  }) {
    radius ??= 12;
    textSize ??= 16;
    return Container(
      decoration: BoxDecoration(
        gradient: onPressed == null ? null : gradient, // 渐变色
        borderRadius: BorderRadius.circular(radius),
        color: onPressed == null ? Colors.white.withOpacity(0.2) : null,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shadowColor: MaterialStateProperty.all(Colors.transparent),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius))),
        ),
        child: Container(
          alignment: Alignment.center,
          height: height ?? 50,
          child: child ??
              Text(
                this,
                style: TextStyle(
                    color: onPressed == null ? Colors.white.withOpacity(0.2) : Colors.white, fontSize: textSize),
              ),
        ),
      ),
    );
  }

  ///镂空按钮
  Widget buttonOut(
    void Function() onPressed, {
    double? width,
    double? height,
    int? textSize,
    Color textColor = const Color(0xFF333333),
  }) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 46.h,
      child: OutlinedButton(
        onPressed: onPressed,
        child: Text(
          this,
          style: (textSize ?? 16).textStyle(textColor),
        ),
      ),
    );
  }

  ///镂空按钮 圆角
  Widget buttonOutRound(
    void Function() onPressed, {
    double? width,
    double? height,
    int? textSize,
    double? borderWidth,
    double? borderRadius,
    Color? borderColor,
    Color textColor = Colors.white,
    Color bgColor = Colors.transparent,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: 16.marginHV(4),
        decoration: 18.boxDecoration(bgColor,borderWidth: borderWidth ?? 2),
        child: Center(child: Text(this, style: TextStyle(fontSize: 14.sp, color: textColor))),
      ),
    );
  }

  Widget buildBtnFD(
      {required bool isAvailable,
      required BoxDecoration decoration,
      required BorderRadius borderRadius,
      Color textColor = Colors.white,
      GestureTapCallback? onTap}) {
    return Material(
      color: Colors.transparent,
      child: Ink(
          decoration: decoration,
          child: InkWell(
            onTap: isAvailable
                ? () {
                    onTap?.call();
                  }
                : null,
            borderRadius: borderRadius,
            child: Container(
              alignment: Alignment.center,
              height: 50.h,
              width: double.infinity,
              child: Text(
                this,
                style: TextStyle(fontSize: 16.sp, color: textColor, fontWeight: FontWeight.bold),
              ),
            ),
          )),
    );
  }

  Widget buildSelectItem(
      {required BoxDecoration decoration,
      double? height,
      bool isSelected = false,
      Color textColor = Colors.white,
      double? textSize,
      GestureTapCallback? onTap,
      EdgeInsetsGeometry? padding}) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: decoration,
        child: InkWell(
          onTap: () => onTap?.call(),
          child: Container(
            height: height ?? 32.h,
            padding: padding ?? EdgeInsets.symmetric(horizontal: 32.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 100.w),
                  child: Text(this,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: textSize ?? 14.sp, color: textColor)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension WidgetBtnExt on bool {
  Widget buildBtn(
      {Key? key,
      required Widget child,
      EdgeInsetsGeometry? margin,
      BoxDecoration? boxDecoration,
      Color? bgColor,
      GestureTapCallback? onTap}) {
    return Material(
      key: key,
      color: Colors.transparent,
      child: Container(
        margin: margin ?? const EdgeInsets.only(),
        child: Ink(
            decoration: boxDecoration ??
                BoxDecoration(borderRadius: BorderRadius.circular(0.h), color: bgColor ?? Colors.white),
            child: InkWell(
              onTap: this
                  ? () {
                      onTap?.call();
                    }
                  : null,
              borderRadius: (boxDecoration?.borderRadius ?? BorderRadius.circular(0.h)) as BorderRadius,
              child: child,
            )),
      ),
    );
  }
}
