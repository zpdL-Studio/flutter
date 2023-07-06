
extension EnumByName<T extends Enum> on Iterable<T> {
  T? tryByName(dynamic name) {
    if(name is String) {
      try {
        return byName(name);
      } catch(_) {}
    }

    return null;
  }

  List<T> setToList(Set<T>? set) {
    if(set == null) {
      return [];
    }

    final results = <T>[];
    for(final e in this) {
      if(set.contains(e)) {
        results.add(e);
      }
    }
    return results;
  }
}
