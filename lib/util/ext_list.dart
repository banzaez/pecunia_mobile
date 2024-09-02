extension ListExtension on List {
  void fillOfRange(int stop, {int start = 0, int step = 1}) {
    if (step == 0) throw Exception("Step cannot be 0");

    final list = start <= stop == step > 0
        ? List<int>.generate(((start - (stop + 1)) / step).abs().ceil(), (int i) => start + (i * step))
        : [];

    addAll(list);
  }
}
