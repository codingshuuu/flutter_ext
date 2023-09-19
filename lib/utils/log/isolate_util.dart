import 'dart:io';
import 'dart:isolate';

import 'package:flustars_flutter3/flustars_flutter3.dart';
import 'package:flutter/foundation.dart';

import 'log_file_util.dart';


/// 描述：多线程 操作
/// https://drift.simonbinder.eu/docs/advanced-features/isolates/

class IsolateUtil {
  static final ReceivePort mainReceivePort = ReceivePort();

  ///main isolate 的sendPort：日志的 SendPort port2
  SendPort? logSendPost;

  static final instance = IsolateUtil._();

  IsolateUtil._() {
    mainReceivePort.listen((message) {
      LogUtil.d('mainReceivePort  listen===${message[0]}');
      if (message[0] == 0) {
        logSendPost = message[1];
      }
    });
    intIsolate();
  }

  void sendLog(dynamic message) {
    logSendPost?.send(message);
  }

  Future<void> intIsolate() async {
    await Isolate.spawn(doWorkLog, IsolateUtil.mainReceivePort.sendPort);
  }

  // 新的isolate中可以处理耗时任务
  static void doWorkLog(SendPort port1) {
    ReceivePort logReceivePost = ReceivePort();
    SendPort port2 = logReceivePost.sendPort;
    logReceivePost.listen((message) {
      File file = message[0] as File;
      String text = message[1] as String;
      bool append = message[2] as bool;
      LogFileUtil.listenLog(file, text, append);
    });
    // 将新isolate中创建的SendPort发送到main isolate中用于通信
    // print("port1--new isolate发送消息");
    port1.send([0, port2]);
  }

  ///(方法，参数)
  ///方法是顶级的方法
  static Future<R> async<Q, R>(ComputeCallback<Q, R> callback, Q message, {String? debugLabel}) {
    return compute(callback, message, debugLabel: debugLabel);
  }
}
