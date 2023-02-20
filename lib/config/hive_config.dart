import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tvmaze_challenge/data/models/series_details.dart';
import 'package:tvmaze_challenge/data/models/series_image.dart';
import 'package:tvmaze_challenge/data/models/series_schedule.dart';

const int seriesDetailsId = 1;
const int seriesImageId = 2;
const int seriesScheduleId = 3;

const String favoriteSeriesBoxId = 'favoriteSeriesBox';
const String pinBoxId = 'pinBox';
const String useFingerprintAuthBoxId = 'useFingerprintAuthBox';

const String userPin = 'userPin';

class HiveConfig {
  static Future<void> init() async {
    await Hive.initFlutter().then((_) {
      Hive
        ..registerAdapter(SeriesDetailsAdapter())
        ..registerAdapter(SeriesImageAdapter())
        ..registerAdapter(SeriesScheduleAdapter());
    });
  }

  static Future<Box<SeriesDetails>> getFavoriteSeriesBox() async {
    return await Hive.openBox(favoriteSeriesBoxId);
  }

  static Future<Box<int>?> getUserPinBox() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    String? key = await secureStorage.read(key: 'encryptionKey');
    if (key == null) {
      return null;
    }
    List<int> encryptionKey = base64Url.decode(key);
    return await Hive.openBox(
      pinBoxId,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );
  }

  static Future<int?> getUserPin() async {
    Box<int>? box = await getUserPinBox();
    return box?.get(userPin);
  }

  static Future<void> saveUserPin(int newPin) async {
    Box<int>? box = await getUserPinBox();
    await box?.put(userPin, newPin);
  }

  static Future<Box<bool>> getUseFingerprintAuthBox() async {
    return await Hive.openBox(useFingerprintAuthBoxId);
  }

  static Future<bool> getUseFingerprintAuth() async {
    Box<bool> box = await getUseFingerprintAuthBox();
    return box.get(useFingerprintAuthBoxId) ?? false;
  }

  static Future<void> saveUseFingerprintAuth(bool value) async {
    Box<bool> box = await getUseFingerprintAuthBox();
    await box.put(useFingerprintAuthBoxId, value);
  }
}
