import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class FileUtils {
  static Future<Directory> getAppDirectory() async {
    Directory? tempDir;
    //web 居然isMacos为true
    if (Platform.isIOS || Platform.isMacOS) {
      tempDir = await getApplicationDocumentsDirectory();
    } else {
      tempDir = await getExternalStorageDirectory();
    }
    final String tempPath = '${tempDir?.path}/';
    final Directory file = Directory(tempPath);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    return file;
  }

  static Future<Directory> getAppApkDirectory() async {
    Directory? tempDir;
    if (Platform.isIOS) {
      tempDir = await getApplicationDocumentsDirectory();
    } else {
      tempDir = await getExternalStorageDirectory();
    }
    final String tempPath = '${tempDir?.path}/apk';
    final Directory file = Directory(tempPath);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    return file;
  }

  static Future<File> getImageFileFromAssets(ByteData byteData) async {
    final file = File(
      '${(await getAppDirectory()).path}${DateTime.now().millisecond}.jpg',
    );
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  static Future<String> getCacheDirectory() async {
    return getTemporaryDir('cache');
  }

  static Future<String> getImageTemporaryDirectory() async {
    return getTemporaryDir('image');
  }

  static Future<String> getVoiceTemporaryDirectory() async {
    return getTemporaryDir('voice');
  }

  static Future<String> getVideoTemporaryDirectory() async {
    return getTemporaryDir('video');
  }

  static Future<String> getLogTemporaryDirectory() async {
    return getTemporaryDir('log');
  }

  static Future<String> getTemporaryDir(String dir) async {
    final Directory tempDirectory = await getTemporaryDirectory();
    final String dirPath = '${tempDirectory.path}/$dir';
    final Directory file = Directory(dirPath);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    return dirPath;
  }

  ///android /android/data/xxx.xxx.package/files/log（subDir）
  static Future<Directory> getPackageDirectory({String subDir = 'log'}) async {
    final directory = Platform.isIOS ? await getLibraryDirectory() : await getExternalStorageDirectory();
    final file = Directory('${directory!.path}/$subDir');
    final bool exists = file.existsSync();
    if (exists == false) {
      if (!file.existsSync()) {
        file.createSync(recursive: true);
      }
    }
    return file;
  }

  static Future<void> clearCacheDir() async {
    final temDir = await getTemporaryDirectory();
    _clearDir(temDir);
    final docDir = await getApplicationDocumentsDirectory();
    _clearDir(docDir);
  }

  static void _clearDir(Directory dir) {
    final listSync = dir.listSync();
    for (var element in listSync) {
      if (!element.path.endsWith('.db')) {
        element.deleteSync(recursive: true);
      }
    }
  }

  static Future<int> cacheDirSize() async {
    String _dir = (await getTemporaryDirectory()).path;
    String _docDir = (await getApplicationDocumentsDirectory()).path;
    return dirSize(_dir) + dirSize(_docDir);
  }

  static int dirSize(String dirPath) {
    int totalSize = 0;
    var dir = Directory(dirPath);
    try {
      if (dir.existsSync()) {
        dir.listSync(recursive: true, followLinks: false).forEach((FileSystemEntity entity) {
          if (entity is File) {
            totalSize += entity.lengthSync();
          }
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return totalSize;
  }

  Future<File> getFileFromAssets(String path) async {
    String tempPath = await getTemporaryDir('assets');
    var filePath = "$tempPath/$path";
    var file = File(filePath);
    if (file.existsSync()) {
      return file;
    } else {
      final byteData = await rootBundle.load(path);
      final buffer = byteData.buffer;
      await (await file.create(recursive: true))
          .writeAsBytes(buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
      return file;
    }
  }
}
