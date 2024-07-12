import 'package:flutter/foundation.dart';

extension DynamicMapExtension on Map {
  T? get<T>(dynamic key,
      {T? Function(Map map)? converter, bool debug = false}) {
    if (debug) {
      debugPrint(
          'MAP EXTENSION key : $key, value ${this[key]}, T : $T, Type : ${this[key]?.runtimeType}');
    }

    switch (T) {
      case const (int):
        return (dynamicToInt(this[key]) as T?);
      case const (double):
        return (dynamicToDouble(this[key]) as T?);
      case const (String):
        return (dynamicToString(this[key]) as T?);
      case const (bool):
        return (dynamicToBool(this[key]) as T?);
      case const (Map):
        return this[key] is Map ? this[key] : null;
      default:
        final value = this[key];
        if (value is Map && converter != null) {
          return converter(value);
        }
        return value is T ? value : null;
    }
  }

  T notNull<T>(dynamic key, {T? Function(Map map)? converter, Object? exception}) {
    dynamic value;
    switch (T) {
      case const (int):
        value = dynamicToInt(this[key]);
        break;
      case const (double):
        value = dynamicToDouble(this[key]);
        break;
      case const (String):
        value = dynamicToString(this[key]);
        break;
      case const (bool):
        value = dynamicToBool(this[key]);
        break;
      case const (Map):
        value = this[key] is Map ? this[key] : null;
        break;
      default:
        final map = this[key];
        if (map is Map && converter != null) {
          value = converter(map);
        } else {
          value = map;
        }
        break;
    }

    if (value is T) {
      return value;
    }
    throw exception ?? DynamicMapException(
        'key : $key, value ${this[key]}, T : $T, Type : ${this[key]?.runtimeType}');
  }

  List<T> getList<T>(dynamic key, [T? Function(Map map)? converter]) {
    final results = <T>[];

    final list = this[key];
    if (list is List) {
      for (final obj in list) {
        T? value;
        try {
          switch (T) {
            case const (int):
              value = dynamicToInt(obj) as T?;
              break;
            case const (double):
              value = dynamicToDouble(obj) as T?;
              break;
            case const (String):
              value = dynamicToString(obj) as T?;
              break;
            case const (bool):
              value = dynamicToBool(obj) as T?;
              break;
            case const (Map):
              value = obj is Map ? obj as T : null;
              break;
            default:
              if (obj is Map && converter != null) {
                value = converter(obj);
              }
              break;
          }
        } catch (_) {
          debugPrint('MAP EXTENSION getList key : $key, T : $T, $_');
        }

        if (value != null) {
          results.add(value);
        }
      }
    }

    return results;
  }

  bool? getBool(dynamic key) {
    final value = this[key];
    if (value is bool) {
      return value;
    }
    return null;
  }

  int? getInt(dynamic key) {
    final value = this[key];
    if (value is int) {
      return value;
    }
    return null;
  }

  double? getDouble(dynamic key) {
    final value = this[key];
    if (value is double) {
      return value;
    }
    return null;
  }

  String? getString(dynamic key) {
    final value = this[key];
    if (value is String) {
      return value;
    }
    return null;
  }

  void removeNull() => removeWhere((key, value) => value == null);
}

bool? dynamicToBool(dynamic value) {
  if (value is bool) {
    return value;
  } else {
    return null;
  }
}

int? dynamicToInt(dynamic value) {
  if (value is int) {
    return value;
  } else if (value is double) {
    return value.toInt();
  } else if (value is String) {
    return int.tryParse(value);
  } else {
    return null;
  }
}

double? dynamicToDouble(dynamic value) {
  if (value is double) {
    return value;
  } else if (value is int) {
    return value.toDouble();
  } else if (value is String) {
    return double.tryParse(value);
  } else {
    return null;
  }
}

String? dynamicToString(dynamic value) {
  if (value is String) {
    return value;
  } else {
    return value?.toString();
  }
}

class DynamicMapException implements Exception {
  final String message;

  const DynamicMapException(this.message);

  @override
  String toString() {
    return 'DynamicMapException{message: $message}';
  }
}
