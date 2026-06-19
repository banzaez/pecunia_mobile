import 'dart:io';

Future<bool> isSqliteFile(File file) async {
  try {
    if (await file.length() < 16) return false;
    final bytes = await file.openRead(0, 16).first;
    final header = String.fromCharCodes(bytes);
    return header.startsWith('SQLite format 3');
  } catch (_) {
    return false;
  }
}
