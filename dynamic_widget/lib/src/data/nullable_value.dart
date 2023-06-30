class NullableValue<T> {
  final T? value;

  const NullableValue(this.value);

  @override
  String toString() {
    return 'NullableValue{value: $value}';
  }
}
