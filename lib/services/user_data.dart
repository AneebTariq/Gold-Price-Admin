import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/response_models/user_data_model.dart';

const _USER_DATA_KEY = "USER_DATA";

class UserPersistence {
  UserPersistence(this.sharedPrefs);

  final SharedPreferences sharedPrefs;
  UserPersistenceData load() {
    final dataStr = sharedPrefs.getString(_USER_DATA_KEY);
    // No data in storage yet, use default values
    if (dataStr == null) return UserPersistenceData.defaultData();

    final dataJson = jsonDecode(dataStr);
    return UserPersistenceData.fromJson(dataJson);
  }

  void save(UserPersistenceData data) {
    final dataStr = sharedPrefs.getString(_USER_DATA_KEY);
    final newDataJson = data.toJson();
    if (dataStr != null) {
      // Old data exists, update values from new data
      final updatingDataJson = jsonDecode(dataStr);
      for (String key in newDataJson.keys) {
        if (newDataJson[key] != null) {
          updatingDataJson[key] = newDataJson[key];
        }
      }
      sharedPrefs.setString(_USER_DATA_KEY, jsonEncode(updatingDataJson));
    } else {
      // Just save normally since new
      sharedPrefs.setString(_USER_DATA_KEY, jsonEncode(newDataJson));
    }
  }

  void implicitSave(UserPersistenceData data) {
    sharedPrefs.setString(_USER_DATA_KEY, jsonEncode(data.toJson()));
  }
}
