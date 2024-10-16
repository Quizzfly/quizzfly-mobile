import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

// ignore_for_file: must_be_immutable
class PrefUtils {
  PrefUtils() {
    SharedPreferences.getInstance().then((value) {
      _sharedPreferences = value;
    });
  }

  static SharedPreferences? _sharedPreferences;
  Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    print('SharedPreference Initialized');
  }

  ///will clear all the data stored in preference
  void clearPreferencesData() async {
    _sharedPreferences!.clear();
  }

  Future<void> setThemeData(String value) {
    return _sharedPreferences!.setString('themeData', value);
  }

  String getThemeData() {
    try {
      return _sharedPreferences!.getString('themeData')!;
    } catch (e) {
      return 'primary';
    }
  }

  Future<void> setAccessToken(String value) {
    return _sharedPreferences!.setString('accessToken', value);
  }

  String getAccessToken() {
    try {
      return _sharedPreferences!.getString('accessToken') ?? '';
    } catch (e) {
      return '';
    }
  }

  Future<void> setRefreshToken(String value) {
    return _sharedPreferences!.setString('refreshToken', value);
  }

  String getRefreshToken() {
    try {
      return _sharedPreferences!.getString('refreshToken') ?? '';
    } catch (e) {
      return '';
    }
  }

  Future<void> setTokenExpires(int value) {
    return _sharedPreferences!.setInt('tokenExpires', value);
  }

  int getTokenExpires() {
    try {
      return _sharedPreferences!.getInt('tokenExpires') ?? 0;
    } catch (e) {
      return 0;
    }
  }
}
