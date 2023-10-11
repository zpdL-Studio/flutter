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

  void setValue(T v, [bool forceUpdate = false]) {
    if (forceUpdate || _value != v) {
      _value = v;
      onUpdate();
    }
  }

  final VoidCallback onUpdate;

  DynamicUpdate(T value, this.onUpdate) : _value = value;
}

base class DynamicUpdateInitialize<T> {
  bool _initialized = false;

  bool get initialized => _initialized;

  T? _value;

  T get value => _value as T;

  set value(T v) {
    if (!_initialized || _value != v) {
      _initialized = true;
      _value = v;
      onUpdate();
    }
  }

  void setValue(T v, [bool forceUpdate = false]) {
    if (forceUpdate || !_initialized || _value != v) {
      _initialized = true;
      _value = v;
      onUpdate();
    }
  }

  final VoidCallback onUpdate;

  DynamicUpdateInitialize(this.onUpdate);
}
