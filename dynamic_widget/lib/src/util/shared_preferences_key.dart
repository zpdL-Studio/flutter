import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

interface class SharedPreferencesKey {
  final String key;

  const SharedPreferencesKey(this.key);
}

extension SharedPreferencesKeyExtension on SharedPreferencesKey {
  Future<bool> set(dynamic value) async => switch (value) {
        int() =>
          await (await SharedPreferences.getInstance()).setInt(key, value),
        double() =>
          await (await SharedPreferences.getInstance()).setDouble(key, value),
        String() =>
          await (await SharedPreferences.getInstance()).setString(key, value),
        bool() =>
          await (await SharedPreferences.getInstance()).setBool(key, value),
        Map() => await (await SharedPreferences.getInstance())
            .setString(key, json.encode(value)),
        List<String>() => await (await SharedPreferences.getInstance())
            .setStringList(key, value),
        _ => false
      };

  Future<T> getOrDefault<T>(T value) async {
    return (await get<T>()) ?? value;
  }

  Future<T?> get<T>() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic value = prefs.get(key);
    if (value == null) {
      return null;
    }
    try {
      switch (T) {
        case int:
        case double:
        case String:
        case bool:
        case List:
          return value as T;
        case Map:
          final String? mapString = value is String ? value : null;
          if (mapString != null) {
            final map = json.decode(mapString);
            if (map is Map) {
              return map as T;
            }
          }
          return null;
      }
    } catch (_) {}

    return null;
  }

  Future<bool> remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.remove(key);
  }
}
