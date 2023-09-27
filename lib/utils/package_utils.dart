import 'dart:io';
import 'dart:math';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sp_util/sp_util.dart';
import 'package:uuid/uuid.dart';

import 'md5_utils.dart';

class PackageUtils {
  late final Uuid _uuid = const Uuid();
  static final PackageUtils instance = PackageUtils();
  static const String _imei = 'IMEI';
  String os = '';
  String osVersion = '';
  String systemVersion = '';
  String version = '';
  String boundId = '';
  String versionCode = '';
  String deviceName = '';
  String deviceType = '';
  String imeiId = '';

  Future<String> getVersionName() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  Future<PackageInfo> getPackageInfo() async {
    return await PackageInfo.fromPlatform();
  }

  Future<void> init() async {
    if (kIsWeb) {
      //web 不支持
      String data = DateTime.now().millisecondsSinceEpoch.toString();
      data += Random().nextInt(10000).toString();
      data = Md5Util.generateMd5(data);
      SpUtil.putString(_imei, data);
      os = 'web';
      return;
    }
    final PackageInfo info = await PackageUtils.instance.getPackageInfo();
    version = info.version;
    boundId = info.packageName;
    versionCode = '${info.version}(${info.buildNumber})';

    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceName = Uri.encodeComponent(iosInfo.name);
      os = 'iOS';

      osVersion = '${double.tryParse(iosInfo.systemVersion)?.toInt() ?? '0'}';
      systemVersion = iosInfo.systemName;

      osVersion = iosInfo.systemVersion;
      deviceName = iosInfo.name;
    } else if (Platform.isAndroid) {
      final AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      deviceName =
          Uri.encodeComponent('${androidDeviceInfo.brand}${androidDeviceInfo.model} ${androidDeviceInfo.device}');
      os = 'Android';

      osVersion = '${androidDeviceInfo.version.sdkInt}';
      systemVersion = androidDeviceInfo.version.release;
      deviceName = androidDeviceInfo.model;
      deviceType = androidDeviceInfo.brand;
    } else if (Platform.isMacOS) {
      final MacOsDeviceInfo macOsInfo = await deviceInfo.macOsInfo;
      deviceName = Uri.encodeComponent(macOsInfo.computerName);
      os = 'MACOS';
      osVersion = macOsInfo.osRelease;
      systemVersion = macOsInfo.kernelVersion;
    }
    final imei = await _getImei(deviceInfo);
    imeiId = imei;
    debugPrint(toString());
  }

  Future<String> _getImei(DeviceInfoPlugin deviceInfo) async {
    if (!(Platform.isIOS || Platform.isAndroid)) {
      var imei = DateTime.now().millisecondsSinceEpoch.toString();
      imei += Random().nextInt(10000).toString();
      return Md5Util.generateMd5(imei);
    }

    const storage = FlutterSecureStorage();
    final String value = await storage.read(key: _imei) ?? '';

    String data = SpUtil.getString(_imei, defValue: value) ?? value;

    if (data.isEmpty) {
      //Android也用随机数，androidId新政策需要申明非广告id，在隐私协议中申明并符合相关规定，这里直接用随机值
      data = Md5Util.generateMd5(getUniqueID());
      SpUtil.putString(_imei, data);
      await storage.write(key: _imei, value: data);
    }
    return data;
  }

  ///获取唯一值
  String getUniqueID() {
    //Uuid().v1() 反馈还是有重复的
    String uuid = _uuid.v1().toString();
    //追加当前时间戳
    uuid += DateTime.now().millisecondsSinceEpoch.toString();
    //追加1w的随机数
    uuid += Random().nextInt(10000).toString();
    uuid = Md5Util.generateMd5(uuid);
    return uuid;
  }

  @override
  String toString() {
    return 'PackageUtils{os: $os, osVersion: $osVersion, systemVersion: $systemVersion, version: $version, boundId: $boundId, versionCode: $versionCode, deviceName: $deviceName, deviceType: $deviceType, imeiId: $imeiId}';
  }
}
