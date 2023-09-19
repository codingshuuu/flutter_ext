import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

extension FocusNodeExt on FocusNode {
  void showKeyboard() {
    if (context == null) {
      return;
    }
    if (hasFocus) {
      _showKeyboard();
    } else {
      FocusScope.of(context!).requestFocus(this);
    }
  }

  _showKeyboard() {
    SystemChannels.textInput.invokeMethod<void>('TextInput.show').whenComplete(() {});
  }

  void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide'); //收起键盘，但输入框焦点不会失去
  }
}
