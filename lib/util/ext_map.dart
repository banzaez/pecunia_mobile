extension ExtensionMap on Map {
  String get toStats {
    var str = "";
    for (String key in keys) {
      str = "$str${str.isEmpty ? "" : "\n"}$key ${this[key]}";
    }
    return str;
  }
}
