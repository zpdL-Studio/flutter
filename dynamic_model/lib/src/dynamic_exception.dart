

class DynamicException implements Exception {
  final String? code;
  final String? message;

  const DynamicException({this.code, this.message});

  @override
  String toString() {
    return message ?? 'DynamicException{code: $code, message: $message}';
  }
}
