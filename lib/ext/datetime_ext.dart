import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  DateTime applied(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }

  ///获取剩余时间
  ///时分秒： 12:03:01
  String hourMinSec(int time) {
    final residueTime = time.abs();
    final hour = residueTime / 60 ~/ 60;
    final min = ((residueTime / 60) % 60).toInt();
    final second = residueTime % 60;
    final h = hour.toString().padLeft(2, '0');
    final m = min.toString().padLeft(2, '0');
    final s = second.toString().padLeft(2, '0');
    return time > 0 ? '$h:$m:$s' : '-$h:$m:$s';
  }

  /// yy-MM-dd hh:mm:ss
  ///@param time 秒级
  String format(int time, {String format = 'yy-MM-dd hh:mm:ss'}) {
    final DateTime date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    final formatter = DateFormat(format);
    return formatter.format(date);
  }
}
