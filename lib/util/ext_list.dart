extension ListExtension on List {
  /// Fills the list with integers from [start] to [stop] (inclusive) with [step].
  /// Example: fillOfRange(5, start: 1) → [1, 2, 3, 4, 5]
  /// Example: fillOfRange(55, start: 0, step: 5) → [0, 5, 10, ..., 55]
  void fillOfRange(int stop, {int start = 0, int step = 1}) {
    assert(step > 0, 'Step must be a positive integer');
    if (start > stop) return;

    final int count = (stop - start) ~/ step + 1;
    addAll(List<int>.generate(count, (i) => start + (i * step)));
  }
}
