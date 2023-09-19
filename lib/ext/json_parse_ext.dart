import 'dart:convert';

import 'package:flutter/material.dart';

extension MapExt on Map {
  //单字段解析
  String asString(String key) {
    final value = this[key];
    if (value == null) {
      return '';
    }
    if (value is String) {
      return value;
    }
    return value.toString();
  }

  //多字段解析
  String asStrings(List<String> keys) {
    for (final String key in keys) {
      final value = this[key];
      if (value == null) {
        continue;
      }
      if (value is String) {
        return value;
      }
    }
    return '';
  }

  double asDouble(String key, {double def = 0}) {
    final value = this[key];
    if (value == null) {
      return def;
    }
    if (value is double) {
      return value;
    }
    try {
      String value0 = value.toString();
      if (value0.isEmpty) {
        return 0;
      }
      final double result = double.parse(value0);
      return result;
    } catch (e) {
      _print('json 解析异常,异常值,期望double值:"$key":$value');
    }
    return 0.0;
  }

  double asDoubles(List<String> keys) {
    for (final String key in keys) {
      final value = this[key];
      if (value == null) {
        continue;
      }
      if (value is double) {
        return value;
      }
      try {
        String value0 = value.toString();
        if (value0.isEmpty) {
          return 0;
        }
        final result = double.parse(value0);
        return result;
      } catch (e) {
        _print('json 解析异常,异常值,期望double值:"$key":$value');
      }
    }
    return 0.0;
  }

  int asInt(String key, {int defaultNum = 0}) {
    final Object? value = this[key];
    if (value == null) {
      return defaultNum;
    }
    if (value is int) {
      return value;
    }
    if (value is double) {
      return value.toInt();
    }
    try {
      String value0 = value.toString();
      if (value0.isEmpty) {
        return defaultNum;
      }
      final int result = int.parse(value0);
      return result;
    } catch (e) {
      _print('json 解析异常,异常值,期望int值:"$key":$value');
    }
    return 0;
  }

  bool asBool(String key) {
    final value = this[key];
    if (value == null) {
      return false;
    }
    if (value is bool) {
      return value;
    }
    if (value == 'true') {
      return true;
    }
    if (value == 'false') {
      return false;
    }
    _print('json 解析异常,异常值:"$key":$value');
    return false;
  }

  Map<String, dynamic>? asMap(String key) {
    final value = this[key];
    if (value == null) {
      return null;
    }
    if (value is Map<String, dynamic>) {
      return value;
    }
    return null;
  }

  int asInts(List<String> keys) {
    for (final String key in keys) {
      final value = this[key];
      if (value == null) {
        return 0;
      }
      if (value is int) {
        return value;
      }
      try {
        String value0 = value.toString();
        if (value0.isEmpty) {
          return 0;
        }
        final int result = int.parse(value0.toString());
        return result;
      } catch (e) {
        _print('json 解析异常,异常值,期望int值:"$key":$value');
      }
    }
    return 0;
  }

  num asNum(String key) {
    final value = this[key];
    if (value == null) {
      return 0;
    }
    if (value is int) {
      return value;
    }
    if (value is double) {
      return value;
    }
    try {
      if (value is String) {
        if (value.contains('.')) {
          return double.parse(value);
        } else {
          return int.parse(value);
        }
      }
    } catch (e) {
      _print('json 解析异常,异常值:"$key":$value');
    }
    return 0;
  }

  Color? asColor(String key) {
    final value = this[key];
    if (value == null) {
      return null;
    }
    if (value is String) {
      try {
        String hexColor = value;
        if (hexColor.isEmpty) return Colors.amber;
        hexColor = hexColor.toUpperCase().replaceAll('#', '');
        hexColor = hexColor.replaceAll('0X', '');
        if (hexColor.length == 6) {
          hexColor = 'FF$hexColor';
        }
        return Color(int.parse(hexColor, radix: 16));
      } catch (e) {
        _print('json 解析异常,异常值:"$key":$value');
      }
    }
    return Colors.amber;
  }

  List<T> asList<T>(String key, [T Function(Map<String, dynamic> json)? toBean, bool decode = false]) {
    try {
      if (toBean != null && this[key] != null) {
        if (decode && this[key] != 'null') {
          return (json.decode(this[key]) as List).map((v) => toBean(v)).toList().cast<T>();
        }

        return (this[key] as List).map((v) => toBean(v)).toList().cast<T>();
      } else if (this[key] != null) {
        if (T.toString() == 'double') {
          return (this[key] as List).map((v) => double.tryParse(v.toString())).toList().cast<T>();
        }
        return List<T>.from(this[key]);
      }
    } catch (e) {
      _print('json 解析异常,异常值11:"$key":${this[key]},$this');
    }
    return <T>[];
  }

  List? asLists<T>(List<String> keys, [Function(Map<String, dynamic> json)? toBean]) {
    for (final String key in keys) {
      try {
        if (this[key] != null) {
          if (toBean != null && this[key] != null) {
            return (this[key] as List).map((v) => toBean(v)).toList().cast<T>();
          } else {
            if (T.toString() == 'double') {
              return (this[key] as List).map((v) => double.tryParse(v.toString())).toList().cast<T>();
            }
            return List<T>.from(this[key]);
          }
        }
      } catch (e) {
        _print('json 解析异常,异常值:"$key":${this[key]}');
      }
    }

    return null;
  }

  T? asBeans<T>(List<String> keys, Function(Map<String, dynamic> json) toBean) {
    for (final String key in keys) {
      try {
        if (this[key] != null && _isClassBean(this[key])) {
          return toBean(this[key]);
        }
      } catch (e) {
        _print('json 解析异常,异常值:"$key":${this[key]}');
      }
    }

    return null;
  }

  T? asBean<T>(String key, Function(Map<String, dynamic> json) toBean, {bool decode = false}) {
    try {
      if (decode && this[key] != null && this[key] != 'null') {
        return toBean(json.decode(this[key]));
      }
      if (this[key] != null && _isClassBean(this[key])) {
        return toBean(this[key]);
      }
    } catch (e) {
      _print('json 解析异常,异常值:"$key":${this[key]}');
    }
    return null;
  }

  bool _isClassBean(Object obj) {
    bool isClassBean = true;
    if (obj is String || obj is num || obj is bool) {
      isClassBean = false;
    } else if (obj is Map && obj.isEmpty) {
      isClassBean = false;
    }
    return isClassBean;
  }

  void _print(String msg) {
    debugPrint(msg);
  }

  Map put(String key, Object? value) {
    if (value is String && value.isNotEmpty) {
      this[key] = value;
    } else if (value != null) {
      this[key] = value;
    }
    return this;
  }
}
