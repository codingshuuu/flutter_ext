import 'package:flutter/material.dart';
import 'package:flutter_ext/ext/screen_ext.dart';


class BackToTop extends StatefulWidget {
  final ScrollController controller;

  ///传入距离底部的距离
  final double bottom;

  final double size;

  ///滑动多大距离显示箭头
  final double? scrollHeight;

  const BackToTop(this.controller, {Key? key, this.bottom = 40.0, this.size = 40, this.scrollHeight}) : super(key: key);

  @override
  State createState() => _BackToTopState();
}

class _BackToTopState extends State<BackToTop> {
  bool shown = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(isScroll);
  }

  //外层用controller。dispose即可，不然会报错。
  // @override
  // void dispose() {
  //   super.dispose();
  //   widget.controller.removeListener(isScroll);
  // }

  void isScroll() {
    if (!mounted) {
      return;
    }
    final bool toShow = (widget.controller.offset) > (widget.scrollHeight ?? MediaQuery.of(context).size.height / 2);
    if (toShow ^ shown) {
      setState(() {
        shown = toShow;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size;
    return Positioned(
        bottom: MediaQuery.of(context).padding.bottom + (widget.bottom),
        right: 20.w,
        child: Offstage(
          offstage: !shown,
          child: GestureDetector(
            onTap: () {
              widget.controller.animateTo(0, duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
            },
            child: Container(
                height: size,
                width: size,
                alignment: const Alignment(0, 0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(size / 2)),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0xFF000000).withOpacity(0.1), blurRadius: size / 10, spreadRadius: 0),
                    ]),
                child: Icon(
                  Icons.vertical_align_top,
                  size: size / 2,
                  color: Colors.black38,
                )),
          ),
        ));
  }
}
