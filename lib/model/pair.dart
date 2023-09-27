/// Pair class data structure
class Pair<T> {
  T first;
  T second;

  Pair(this.first, this.second);

  @override
  String toString() {
    return 'Pair{first: $first, second: $second}';
  }
}

class PairDiff<T, R> {
  T first;
  R second;

  PairDiff(this.first, this.second);

  @override
  String toString() {
    return 'PairDiff{first: $first, second: $second}';
  }
}

class PairDiff3<T, M, R> {
  T first;
  M second;
  R third;

  PairDiff3(this.first, this.second, this.third);

  @override
  String toString() {
    return 'PairDiff3{first: $first, second: $second, third: $third}';
  }
}
