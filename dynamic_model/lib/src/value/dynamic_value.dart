import 'dart:async';

import 'package:flutter/widgets.dart';

import 'dynamic_value_exception.dart';

enum DynamicValueState {
  waiting,
  active,
  disposed,
}

abstract class DynamicValueBase<T> extends ChangeNotifier {
  DynamicValueState _state;
  T? _value;
  Object? _error;

  DynamicValueBase._({T? value, DynamicValueState? state})
      : _value = value,
        _state = state ??
            (value != null
                ? DynamicValueState.active
                : DynamicValueState.waiting);

  DynamicValueState get state => _state;

  bool get hasValue => _value != null;

  bool get isWaiting => state == DynamicValueState.waiting;

  bool get isActive => state == DynamicValueState.active;

  bool get isError => _error != null;

  bool get isDisposed => state == DynamicValueState.disposed;

  Object? get error => _error;

  @override
  void dispose() {
    if (isDisposed) {
      return;
    }
    _state = DynamicValueState.disposed;
    super.dispose();
  }
}

class DynamicValue<T> extends DynamicValueBase<T> with _DynamicValueStream<T> {
  DynamicValue([T? value]) : super._(value: value);

  T get value {
    if (_value != null) {
      return _value!;
    }
    throw DynamicValueException(exception: DynamicValueExceptions.getValueNull);
  }

  T? get valueOrNull => _value;

  set value(T value) {
    if (isDisposed) {
      throw DynamicValueException(
          exception: DynamicValueExceptions.setValueBecauseDisposed);
    }
    _value = value;
    _error = null;
    _state = DynamicValueState.active;
    _addToValue(value);
    notifyListeners();
  }

  set error(Object? error) {
    if (error == null) {
      return;
    }

    if (isDisposed) {
      throw DynamicValueException(
          exception: DynamicValueExceptions.setErrorBecauseDisposed);
    }
    _error = error;
    _addToError(error);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _disposeToStream();
  }

  Stream<T> asStream() {
    late final StreamController<T> controller;
    controller = StreamController<T>.broadcast(
      onListen: () {
        _streamControllers.add(controller);
        final error = _error;
        if (error != null) {
          controller.addError(error);
          return;
        }
        final value = _value;
        if (isActive && value != null) {
          controller.add(value);
        }
      },
      onCancel: () {
        controller.close();
        _streamControllers.remove(controller);
      },
      sync: true,
    );

    return controller.stream;
  }
}

class DynamicNValue<T> extends DynamicValueBase<T>
    with _DynamicValueStream<T?> {
  DynamicNValue() : super._();

  DynamicNValue.init([T? value])
      : super._(value: value, state: DynamicValueState.active);

  T? get value => _value;

  set value(T? value) {
    if (isDisposed) {
      throw DynamicValueException(
          exception: DynamicValueExceptions.setValueBecauseDisposed);
    }
    _value = value;
    _error = null;
    _state = DynamicValueState.active;
    _addToValue(value);
    notifyListeners();
  }

  set error(Object? error) {
    if (error == null) {
      return;
    }

    if (isDisposed) {
      throw DynamicValueException(
          exception: DynamicValueExceptions.setErrorBecauseDisposed);
    }
    _error = error;
    _addToError(error);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _disposeToStream();
  }

  Stream<T?> asStream() {
    late final StreamController<T?> controller;
    controller = StreamController<T?>.broadcast(
      onListen: () {
        _streamControllers.add(controller);
        final error = _error;
        if (error != null) {
          controller.addError(error);
          return;
        }
        final value = _value;
        if (isActive) {
          controller.add(value);
        }
      },
      onCancel: () {
        controller.close();
        _streamControllers.remove(controller);
      },
      sync: true,
    );

    return controller.stream;
  }
}

mixin _DynamicValueStream<T> {
  final Set<StreamController<T>> _streamControllers = {};

  void _addToValue(T value) {
    for (final controller in _streamControllers) {
      if (controller.hasListener && !controller.isClosed) {
        controller.add(value);
      }
    }
  }

  void _addToError(Object error) {
    for (final controller in _streamControllers) {
      if (controller.hasListener && !controller.isClosed) {
        controller.addError(error);
      }
    }
  }

  void _disposeToStream() {
    for (final controller in _streamControllers) {
      if (!controller.isClosed) {
        controller.close();
      }
    }
    _streamControllers.clear();
  }
}
