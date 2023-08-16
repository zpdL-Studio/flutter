
extension EnumByName<T extends Enum> on Iterable<T> {
  T? tryByName(dynamic name) {
    if(name is String) {
      try {
        return byName(name);
      } catch(_) {}
    }

    return null;
  }

  List<T> trySetToList(Set<T>? set) {
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

  T? tryByNames(Iterable<String>? names) {
    if (names == null) {
      return null;
    }

    final set = names.toSet();
    for (final e in this) {
      if (set.contains(e.name)) {
        return e;
      }
    }

    return null;
  }

  List<T> tryByNamesToList(Iterable<String>? names) {
    if (names == null) {
      return [];
    }

    final set = names.toSet();
    final results = <T>[];
    for (final e in this) {
      if (set.contains(e.name)) {
        results.add(e);
      }
    }

    return results;
  }
}
