import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'isolate_util.dart';


/// 描述：添加写文件在本地，仅保留7天内的日志

class LogFileUtil {
  static Future<void> addLogFile(String text, {String subDir = 'log', bool append = true}) async {
    final File file = await _getSameDayFile(subDir: subDir);
    final DateTime date = DateTime.now();
    String log = '';
    log += '\n';
    log += '${date.toString()}\n';
    log += text;
    log += '\n\n';
    IsolateUtil.instance.sendLog([file, log, append]);
  }

  static void addCurl(String curl) async {
    final File file = await _getSameDayFile();
    final DateTime date = DateTime.now();
    String log = '';
    log += '${DateTime.now().millisecondsSinceEpoch.toString()}-';
    log += '${date.hour.toString()}:${date.minute.toString()}:${date.second.toString()} ';
    log += '\n';
    log += curl;
    log += '\n';
    IsolateUtil.instance.sendLog([file, log, true]);
  }

  ///获取当天的日志文件
  static Future<File> _getSameDayFile({String subDir = 'log', DateTime? dateTime}) async {
    final DateTime date = dateTime ?? DateTime.now();
    // String dayFile = date.formattedDate(format: 'yyyy_MM_dd');
    String dayFile = date.toString().substring(0, 10);
    final Directory tempDir = await getAppDirectory(subDir: subDir);
    String tempPath = tempDir.path;
    dayFile = '$tempPath/$dayFile.log';
    File file = File(dayFile);
    if (!await file.exists()) {
      file = await file.create(recursive: true);
    }
    return file;
  }

  ///android /android/data/xxx.xxx.package/files/log（subDir）
  static Future<Directory> getAppDirectory({String subDir = 'log'}) async {
    final directory = Platform.isIOS ? await getApplicationDocumentsDirectory() : await getExternalStorageDirectory();
    final file = Directory('${directory!.path}/$subDir');
    final bool exists = file.existsSync();
    if (exists == false) {
      if (!file.existsSync()) {
        file.createSync(recursive: true);
      }
    }
    return file;
  }

  static Future<void> initLogger() async {
    //删除过期的日志文件
    Directory directory = await getAppDirectory();
    Stream<FileSystemEntity> fileList = directory.list();
    //删除7天前的
    int time = DateTime.now().millisecondsSinceEpoch - 7 * 24 * 60 * 60 * 1000;
    await for (FileSystemEntity fileSystemEntity in fileList) {
      final name = fileSystemEntity.path
          .substring(fileSystemEntity.path.lastIndexOf('/') + 1, fileSystemEntity.path.lastIndexOf('.'));
      List<String> split = name.split('_');
      if (split.length == 3) {
        DateTime dateTime = DateTime(int.parse(split[0]), int.parse(split[1]), int.parse(split[2]));
        if (dateTime.millisecondsSinceEpoch < time) {
          fileSystemEntity.delete();
        }
      }
    }
  }

  static void listenLog(File file, String text, bool append) async {
    file.writeAsString(text, mode: append ? FileMode.append : FileMode.write);
  }
}
