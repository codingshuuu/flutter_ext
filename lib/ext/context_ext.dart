import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  //屏幕宽度
  double get screenWidth => MediaQuery.of(this).size.width;

  //屏幕高度
  double get screenHeight => MediaQuery.of(this).size.height;

  //获取系统状态栏高度
  double get statusHeight => MediaQuery.of(this).padding.top;

  //系统颜色
  Color get themeColor => Theme.of(this).primaryColor;

  //导航栏高度,AppBarHeight
  double get appBarHeight => kToolbarHeight;
  
  
  void hideKeyboard() {
    final mediaQuery = MediaQuery.of(this);
    if (mediaQuery.viewInsets.bottom > 0) {
      FocusScope.of(this).unfocus();
    }
  }
  
}
