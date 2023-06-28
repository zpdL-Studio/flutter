class DynamicDay {
  final int year;
  final int month;
  final int day;

  const DynamicDay(
      {required this.year, required this.month, required this.day});

  factory DynamicDay.dataTime(DateTime dataTime) => DynamicDay(
        year: dataTime.year,
        month: dataTime.month,
        day: dataTime.day,
      );

  factory DynamicDay.timeMs(int timeMs) =>
      DynamicDay.dataTime(DateTime.fromMillisecondsSinceEpoch(timeMs));

  DateTime get dateTime => DateTime(year, month, day);

  int get weekday => dateTime.weekday;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DynamicDay &&
          runtimeType == other.runtimeType &&
          year == other.year &&
          month == other.month &&
          day == other.day;

  int compareTo(DynamicDay other) {
    final yearCompare = year.compareTo(other.year);
    if (yearCompare != 0) {
      return yearCompare;
    }

    final monthCompare = month.compareTo(other.month);
    if (monthCompare != 0) {
      return monthCompare;
    }

    return day.compareTo(other.day);
  }

  bool operator >(DynamicDay other) => compareTo(other) > 0;

  bool operator <(DynamicDay other) => compareTo(other) < 0;

  bool operator >=(DynamicDay other) => compareTo(other) >= 0;

  bool operator <=(DynamicDay other) => dateTime.compareTo(other.dateTime) <= 0;

  @override
  int get hashCode => year.hashCode ^ month.hashCode ^ day.hashCode;
}

class DynamicDays<T> {
  final DynamicDay day;
  final DateTime dateTime;
  final List<T> list;

  const DynamicDays(
      {required this.day, required this.dateTime, required this.list});

  static List<DynamicDays<T>> listToDynamicDays<T>(
      Iterable<T> list, DateTime? Function(T data) dataToDateTime) {
    final results = <DynamicDays<T>>[];
    DynamicDays<T>? dynamicDays;
    for (final data in list) {
      final dataTime = dataToDateTime(data);
      if (dataTime == null) {
        continue;
      }

      final day = DynamicDay.dataTime(dataTime);
      if (dynamicDays != null && dynamicDays.day == day) {
        dynamicDays.list.add(data);
      } else {
        dynamicDays =
            DynamicDays<T>(day: day, dateTime: dataTime, list: [data]);
        results.add(dynamicDays);
      }
    }

    return results;
  }
}
