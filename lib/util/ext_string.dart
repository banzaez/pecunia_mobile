extension ExtString on String {
  bool get isValidName => length > 5;

  bool get isValidPassword => length > 5;

  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() =>
      replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');

  String toWithoutSpace() => replaceAll(' ', '');

  String toSortable() => toLowerCase().replaceAll(' ', '');

  String format(List<String> params) {
    String result = this;
    for (int i = 1; i <= params.length; i++) {
      result = result.replaceAll('%$i\$', params[i - 1]);
    }

    return result;
  }
}
