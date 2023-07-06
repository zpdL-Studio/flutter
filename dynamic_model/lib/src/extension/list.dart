extension ListExtension<E> on List<E> {
  List<E> dynamicSublist(int start, [int? end]) {
    if (end == null) {
      return sublist(start);
    }

    if (end > length) {
      return sublist(start, length);
    }

    return sublist(start, end);
  }

  List<E> dynamicRemoveWhere(bool Function(E element) test) {
    return toList()..removeWhere(test);
  }

  E? dynamicGet(int? index) {
    if (index == null) {
      return null;
    }

    if (index >= 0 && index < length) {
      return this[index];
    }
    return null;
  }

  List<E> dynamicAddSeparator(E separator) {
    List<E> results = <E>[];

    for (int i = 0; i < length; i++) {
      if (i > 0 && i < length) {
        results.add(separator);
      }
      results.add(this[i]);
    }
    return results;
  }
}
