import 'package:dynamic_model/src/dynamic_exception.dart';

enum DynamicValueExceptions {
  getValueNull,
  setValueBecauseDisposed,
  setErrorBecauseDisposed,
  ;

  String get message => switch (this) {
        DynamicValueExceptions.getValueNull => 'value is null',
        DynamicValueExceptions.setValueBecauseDisposed =>
          'value is not set because state is disposed',
        DynamicValueExceptions.setErrorBecauseDisposed =>
          'error is not set because state is disposed',
      };
}

class DynamicValueException extends DynamicException {
  final DynamicValueExceptions exception;

  DynamicValueException({required this.exception})
      : super(code: exception.name, message: exception.message);
}
