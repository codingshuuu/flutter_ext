import 'package:flutter/widgets.dart';

extension KeyExt on GlobalKey {
  ///获取当前view距离顶部的高度
  double get marginTop {
    final RenderBox? renderBox = currentContext?.findRenderObject() as RenderBox?;
    final Offset? offset = renderBox?.localToGlobal(Offset(0.0, renderBox.hasSize ? renderBox.size.height : 0.0));
    return offset?.dy ?? 0.0;
  }

  ///获得控件正下方的坐标：
  Offset? get location {
    final RenderBox? renderBox = currentContext?.findRenderObject() as RenderBox?;
    // final Offset? offset = renderBox?.localToGlobal(Offset.zero);
    final Offset? offset = renderBox?.localToGlobal(Offset(0.0, renderBox.size.height));
    return offset;
  }

  ///判断控件的位置是否在当前控件里面
  bool includeWidget(GlobalKey otherGlobalKey) {
    RenderBox otherRenderBox = otherGlobalKey.currentContext?.findRenderObject() as RenderBox;

    final Offset otherOffset =
        otherRenderBox.localToGlobal(Offset(otherRenderBox.size.height / 2, otherRenderBox.size.height / 2));

    final RenderBox renderBox = currentContext?.findRenderObject() as RenderBox;
    // final Offset? offset = renderBox?.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    if (otherOffset.dx > offset.dx &&
        otherOffset.dx < offset.dx + size.width &&
        otherOffset.dy > offset.dy &&
        otherOffset.dy < offset.dy + size.height) {
      debugPrint('otherOffset ${otherOffset.dy}');
      return true;
    }

    return false;
  }

  bool includeGlobalKey(GlobalKey otherGlobalKey) {
    RenderBox otherRenderBox = otherGlobalKey.currentContext?.findRenderObject() as RenderBox;

    final Offset otherOffset =
        otherRenderBox.localToGlobal(Offset(otherRenderBox.size.height / 2, otherRenderBox.size.height / 2));

    final RenderBox renderBox = currentContext?.findRenderObject() as RenderBox;
    // final Offset? offset = renderBox?.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    if (otherOffset.dx > offset.dx &&
        otherOffset.dx < offset.dx + size.width &&
        otherOffset.dy > offset.dy &&
        otherOffset.dy < offset.dy + size.height) {
      return true;
    }

    return false;
  }

  ///判断位置是否在当前控件里面
  bool includeOffset(Offset otherOffset) {
    final RenderBox renderBox = currentContext?.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    if (otherOffset.dx > offset.dx &&
        otherOffset.dx < offset.dx + size.width &&
        otherOffset.dy > offset.dy &&
        otherOffset.dy < offset.dy + size.height) {
      return true;
    }
    return false;
  }

  bool includeLocalPosition(Offset otherOffset) {
    final RenderBox? renderBox = currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) {
      return false;
    }
    // final Offset? offset = renderBox?.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    if (otherOffset.dx > offset.dx &&
        otherOffset.dx < offset.dx + size.width &&
        otherOffset.dy > offset.dy &&
        otherOffset.dy < offset.dy + size.height) {
      return true;
    }

    return false;
  }

}
