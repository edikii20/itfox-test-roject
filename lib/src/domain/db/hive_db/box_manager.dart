import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:itfox_test_project/src/domain/entities/user.dart';

class BoxManager {
  static final instance = BoxManager._();
  final _secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  BoxManager._();

  Future<Box<User>> openUsersBox() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserAdapter());
    }
    final secureKey = base64Url
        .decode(await _getEncryptedBoxKey(boxKeyName: 'usersBoxSecureKey'));
    return Hive.openBox<User>(
      'users',
      encryptionCipher: HiveAesCipher(secureKey),
    );
  }

  Future<Box<String>> openSessionsBox() async {
    final secureKey = base64Url
        .decode(await _getEncryptedBoxKey(boxKeyName: 'sessionsBoxSecureKey'));
    return Hive.openBox<String>(
      'sessions',
      encryptionCipher: HiveAesCipher(secureKey),
    );
  }

  Future<Box<String>> openWeathersBox() async {
    return Hive.openBox<String>('weathers');
  }

  Future<String> _getEncryptedBoxKey({required String boxKeyName}) async {
    final secureKey = await _secureStorage.read(key: boxKeyName);
    if (secureKey != null) {
      return secureKey;
    } else {
      final key = base64UrlEncode(Hive.generateSecureKey());
      await _secureStorage.write(
        key: boxKeyName,
        value: key,
      );
      return key;
    }
  }

  Future<void> closeBox(Box box) async {
    await box.compact();
    await box.close();
  }
}
