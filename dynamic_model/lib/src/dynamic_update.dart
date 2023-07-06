import 'package:flutter/foundation.dart';

base class DynamicUpdate<T> {
  T _value;

  T get value => _value;

  set value(T v) {
    if (_value != v) {
      _value = v;
      onUpdate();
    }
  }

  final VoidCallback onUpdate;

  DynamicUpdate(T value, this.onUpdate) : _value = value;
}
