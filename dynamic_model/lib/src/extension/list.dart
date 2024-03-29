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

  Map<K, E> dynamicToMap<K>(K Function(E element) valueToKey) {
    final map = <K, E>{};
    for (final element in this) {
      map[valueToKey(element)] = element;
    }
    return map;
  }
}

class DynamicMapList<K, V> {
  Map<K, V>? _map;
  final List<V> list;
  final K Function(V element) valueToKey;

  DynamicMapList({required this.list, required this.valueToKey});

  Map<K, V> get map {
    _map ??= list.dynamicToMap(valueToKey);
    return _map!;
  }

  int get length => list.length;

  void updatedList() {
    _map = null;
  }

  V getByIndex(int index) {
    return list[index];
  }

  V? getByKey(K k) {
    return map[k];
  }

  void add(V item) {
    updatedList();
    list.add(item);
  }

  void addAll(Iterable<V> iterable) {
    updatedList();
    list.addAll(iterable);
  }

  bool remove(Object? value) {
    updatedList();
    return list.remove(value);
  }

  V removeAt(int index) {
    updatedList();
    return list.removeAt(index);
  }

  bool containsKey(K key) {
    return map.containsKey(key);
  }
}
