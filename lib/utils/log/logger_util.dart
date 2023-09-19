import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart' as clog;

import 'log_file_util.dart';

///
/// 描述：Logger库 日志打印工具
/// [d] 只打印基本信息,不存文件
/// 其他方法会打印并且存到本地文件中
///
class LoggerUtil {
  static void d(String message) {
    cLogDebug(message);
  }

  static void w(String message) {
    cLogWarning(message);
    LogFileUtil.addLogFile(message);
  }

  static void e(String message) {
    cLogError(message);
    LogFileUtil.addLogFile(message);
  }

  static void i(String message) {
    cLogInfo(message);
    LogFileUtil.addLogFile(message);
  }

  static void v(String message) {
    cLogVerbose(message);
    LogFileUtil.addLogFile(message);
  }
}

var logger = clog.Logger(
    output: _COutPut(),
    printer: clog.PrettyPrinter(
      stackTraceBeginIndex: 0,
      methodCount: 0,
      printEmojis: false,
    ));

var methodLogger = clog.Logger(
  printer: clog.PrettyPrinter(
    stackTraceBeginIndex: 2,
    methodCount: 8,
    printEmojis: false,
  ),
  output: _COutPut(),
);

class _COutPut extends clog.LogOutput {
  @override
  void output(clog.OutputEvent event) {
    for (final e in event.lines) {
      assert(() {
        debugPrint(e);
        return true;
      }());
    }
  }
}

void cLogDebug(dynamic message, {String? error, bool showMethod = false}) {
  final Function func = (showMethod ? methodLogger : logger).d;
  _checkLongStr(message, func, error: error);
}

void cLogWarning(dynamic message, {String? error, bool showMethod = false}) {
  final Function func = (showMethod ? methodLogger : logger).w;
  _checkLongStr(message, func, error: error);
}

void cLogError(dynamic message, {String? error, bool showMethod = true}) {
  final Function func = (showMethod ? methodLogger : logger).e;
  _checkLongStr(message, func, error: error);
}

void cLogInfo(dynamic message, {String? error, bool showMethod = false}) {
  final Function func = (showMethod ? methodLogger : logger).i;
  _checkLongStr(message, func, error: error);
}

void cLogVerbose(dynamic message, {String? error, bool showMethod = false}) {
  final Function func = (showMethod ? methodLogger : logger).t;
  _checkLongStr(message, func, error: error);
}

void _checkLongStr(dynamic message, Function func, {String? error}) {
  assert(() {
    var content = message.toString();
    if (content.length < 800) {
      func(message, error);
    } else {
      var i = 0;
      var title = '╔ $i ╗ ';
      while (content.length >= 800) {
        final str0 = title + content.substring(0, 800);
        func(str0, error);
        content = content.substring(800, content.length);
        i += 1;
        title = '║ $i ║ ';
      }
      if (content.isNotEmpty) {
        final str = '╚ $i ╝: $content';
        func(str, error);
      }
    }
    return true;
  }());
}
