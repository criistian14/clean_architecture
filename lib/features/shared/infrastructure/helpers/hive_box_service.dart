import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

class HiveBoxService {
  const HiveBoxService({
    required FlutterSecureStorage secureStorage,
    required HiveInterface hive,
  })  : _secureStorage = secureStorage,
        _hive = hive;

  final FlutterSecureStorage _secureStorage;
  final HiveInterface _hive;

  Future<Box> openBox(String boxName) async {
    await _hive.openBox(boxName);

    return _hive.box(boxName);
  }

  Future<Box> openEncryptedBox(String boxName) async {
    final key = await _getEncryptionKey();

    await _hive.openBox(
      boxName,
      encryptionCipher: HiveAesCipher(key),
    );

    return _hive.box(boxName);
  }

  Future<List<int>> _getEncryptionKey() async {
    final encryptionKey = await _secureStorage.read(key: 'key');

    if (encryptionKey == null) {
      final key = _hive.generateSecureKey();

      await _secureStorage.write(
        key: 'key',
        value: base64UrlEncode(key),
      );

      return key;
    }

    return base64Url.decode(encryptionKey);
  }
}
