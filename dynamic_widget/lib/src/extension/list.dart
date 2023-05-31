extension ListExtension<T> on List<T> {
  List<T> dynamicSublist(int start, [int? end]) {
    if(end == null) {
      return sublist(start);
    }

    if(end > length) {
      return sublist(start, length);
    }

    return sublist(start, end);
  }
}
