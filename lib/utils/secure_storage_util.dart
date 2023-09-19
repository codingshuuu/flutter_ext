import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// 安全存储工具类
/// 钥匙串用于 iOS
/// Android 使用 AES 加密。AES 密钥使用 RSA 加密，RSA 密钥存储在KeyStore中
/// 注意KeyStore 是在 Android 4.3（API 级别 18）中引入的。该插件不适用于早期版本。
class SecureStorageUtil {
  static final SecureStorageUtil instance = SecureStorageUtil._();

  SecureStorageUtil._();

// Create storage
  final storage = const FlutterSecureStorage();

// Read value
  Future<String?> read(String key) {
    return storage.read(key: key);
  }

// Read all values
  Future<Map<String, String>> get allValues => storage.readAll();

// Delete value
  Future<void> delete(String key) => storage.delete(key: key);

// Delete all
  Future<void> deleteAll() => storage.deleteAll();

// Write value
  Future<void> write(String key, String value) => storage.write(key: key, value: value);
}
