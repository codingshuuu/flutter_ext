import 'dart:convert';
import 'dart:io';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:md5_file_checksum/md5_file_checksum.dart';
import 'package:uuid/uuid.dart';


class Md5Util {
  static const Uuid _uuid = Uuid();

  // md5 加密
  static String generateMd5(String data) {
    final content = const Utf8Encoder().convert(data);
    final digest = md5.convert(content);
    // 这里其实就是 digest.toString()
    return hex.encode(digest.bytes);
  }

  static String generateHeroTag(List<String> args) => generateMd5(args.toString());

  //根据json生成唯一的herotag,后面看有没有必要使用uuid
  static String jsonHero(Map map) => generateMd5(map.toString());

  static Future<String> calculateMD5SumAsyncWithCrypto(String filePath) async {
    var ret = '';
    final file = File(filePath);
    if (await file.exists()) {
      ret = hex.encode((await md5.bind(file.openRead()).first).bytes);
    } else {
      debugPrint('`$filePath` does not exits so unable to evaluate its MD5 sum.');
      return '';
    }
    debugPrint('calculateMD5SumAsyncWithCrypto = $ret');
    return ret;
  }

  ///这个计算md5会比上面原生的快4倍,视频大的时候更明显
  static Future<String> calculateMD5V2(String filePath) async {
    if(Platform.isAndroid || Platform.isIOS){
      final res = await Md5FileChecksum.getFileChecksum(filePath: filePath);
      return hex.encode(base64Decode(res));
    }
    return calculateMD5SumAsyncWithCrypto(filePath);
  }

  static String createHeroTag(String url) => generateMd5(url + _uuid.v1());

  static String createUUID() => _uuid.v1();
}
