import 'package:flutter/widgets.dart';

extension ScrollControllerExt on ScrollController {
  animateToBottom({int milliseconds = 300}) {
    final maxScrollExtent = position.maxScrollExtent;
    animateTo(
      maxScrollExtent,
      curve: Curves.linear,
      duration: Duration(milliseconds: milliseconds),
    );
  }
}
