import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

@Deprecated('used Md5Util.generateMd5')
class Ecrypt {
  static String generateMd5(String data) {
    final content = const Utf8Encoder().convert(data);
    final digest = md5.convert(content);
    // 这里其实就是 digest.toString()
    return hex.encode(digest.bytes);
  }
}
