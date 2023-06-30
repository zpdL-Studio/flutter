import 'package:flutter/cupertino.dart';

base class UpdateValue<T> {
  T _value;

  T get value => _value;

  set value(T v) {
    if (_value != v) {
      _value = v;
      onUpdate();
    }
  }

  final VoidCallback onUpdate;

  UpdateValue(T value, this.onUpdate) : _value = value;
}
