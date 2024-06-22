import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tv_series_app/features_core/local_storage/local_storage.dart';

class SharedPreferencesClientImpl implements SharedPreferencesClient {
  @override
  Future<String?> getString(String key) async {
    debugPrint('******** sharedPreferencesInstance.getString: $key');
    final SharedPreferences instance = await SharedPreferences.getInstance();
    return instance.getString(key);
  }

  @override
  Future<bool> setString(String key, String value) async {
    debugPrint('******** sharedPreferencesInstance.setString: $key, $value');
    final SharedPreferences instance = await SharedPreferences.getInstance();
    return await instance.setString(key, value);
  }
}
