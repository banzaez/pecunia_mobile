import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:pecunia/util/sqlite_file.dart';

void main() {
  test('isSqliteFile returns true for valid SQLite header', () async {
    final file = File('${Directory.systemTemp.path}/test_valid.db');
    await file.writeAsBytes('SQLite format 3\u0000'.codeUnits + List.filled(8, 0));
    addTearDown(() => file.deleteSync());

    expect(await isSqliteFile(file), isTrue);
  });

  test('isSqliteFile returns false for invalid file', () async {
    final file = File('${Directory.systemTemp.path}/test_invalid.db');
    await file.writeAsString('not a database');
    addTearDown(() => file.deleteSync());

    expect(await isSqliteFile(file), isFalse);
  });

  test('isSqliteFile returns false for short file', () async {
    final file = File('${Directory.systemTemp.path}/test_short.db');
    await file.writeAsBytes([1, 2, 3]);
    addTearDown(() => file.deleteSync());

    expect(await isSqliteFile(file), isFalse);
  });
}
