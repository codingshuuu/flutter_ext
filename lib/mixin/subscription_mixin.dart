//
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ext/ext/duration_ext.dart';

///流统一管理
mixin SubscriptionMixin<T extends StatefulWidget> on State<T> {
  final List<StreamSubscription> _streamList = [];
  final List<Timer> _timerList = [];


  void addStreamSubscription(StreamSubscription sub) {
    debugPrint('SubscriptionMixin, $this,StreamSubscription->$sub, add');
    _streamList.add(sub);
  }

  void _addTimerSubscription(Timer timer) {
    debugPrint('SubscriptionMixin, $this,StreamSubscription Timer->$timer, add');
    _timerList.add(timer);
  }

  ///延迟处理
  ///@params milliSeconds 延迟多少毫秒执行
  StreamSubscription delay<T>(int milliSeconds, ValueChanged<T> listen) {
    final stream = Stream.fromFuture(Future.delayed(milliSeconds.toMilliSeconds)).listen((event) {
      if (mounted) {
        listen(event);
      }
    });
    addStreamSubscription(stream);
    return stream;
  }

  ///定时
  ///@params milliSeconds 每多少毫秒执行回调一次
  Timer periodic(int milliSeconds, void Function(Timer timer) callback) {
    final timer = Timer.periodic(milliSeconds.toMilliSeconds, (t) {
      if (mounted) {
        callback(t);
      }
    });
    _addTimerSubscription(timer);
    return timer;
  }

  @override
  void dispose() {
    for (var element in _streamList) {
      debugPrint('SubscriptionMixin, $this,StreamSubscription->$element,cancel');
      element.cancel();
    }
    for (var element in _timerList) {
      debugPrint('SubscriptionMixin, $this,StreamSubscription Timer->$element,cancel,element.isActive=${element.isActive}');
      if (element.isActive) {
        element.cancel();
      }
    }
    super.dispose();
  }
}
