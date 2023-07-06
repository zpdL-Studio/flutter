class DynamicNullable<T> {
  final T? value;

  const DynamicNullable(this.value);

  @override
  String toString() {
    return 'DynamicNullable{value: $value}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DynamicNullable &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}
