///https://github.com/vandadnp/flutter-tips-and-tricks#section-titles-on-listview-in-flutter
extension Unwrap<T> on List<T?>? {
  //转非空
  List<T> unwrap() => (this ?? []).whereType<T>().toList();

  //有数据
  bool get hasElements => this != null && this!.isNotEmpty;

  //没数据
  bool get noElements => this == null || this!.isEmpty;
}

extension ListExt<T> on Iterable<T> {
  //某个数值相加的和，默认等于0
  int reduceAdd(int Function(T value, T element) combine) {
    int result = 0;
    final Iterator<T> iter = iterator;
    if (!iter.moveNext()) {
      return result;
    }
    final T value = iter.current;
    while (iter.moveNext()) {
      result += combine(value, iter.current);
    }
    return result;
  }

  T? get safeFirst {
    final Iterator<T> it = iterator;
    if (!it.moveNext()) {
      return null;
    }
    return it.current;
  }

  T? get safeLast {
    if(isEmpty){
      return null;
    }
    return last;
  }

  T? indexOfOrNull(bool Function(T element) test) => firstOrNull;
}

