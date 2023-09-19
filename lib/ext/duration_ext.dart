import 'dart:async';

extension DurationExt on int {
  Duration get toSecond {
    return Duration(seconds: this);
  }

  Duration get toDays {
    return Duration(days: this);
  }

  Duration get toMinutes {
    return Duration(minutes: this);
  }

  Duration get toHour {
    return Duration(hours: this);
  }

  Duration get toMilliSeconds {
    return Duration(milliseconds: this);
  }

  String get timeFormat{
    final int second = (this % 60).toInt();
    final int minute = this ~/ 60;
    final String sSecond = second.toString().padLeft(2,'0');
    final String sMinute = minute.toString().padLeft(2,'0');
    return '$sMinute:$sSecond';
  }

}

extension FutureDurationExt on Duration {
  Future delayed<T>(FutureOr<T> Function() computation) {
    return Future.delayed(this, () => computation());
  }
}
