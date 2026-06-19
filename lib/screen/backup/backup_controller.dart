import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pecunia/providers/google_notifier.dart';
import 'package:pecunia/providers/sql_provider_ref.dart';
import 'package:pecunia/providers/transaction_notifier.dart';
import 'package:pecunia/providers/wallet_notifier.dart';
import 'package:pecunia/util/ext_datetime.dart';
import 'package:pecunia/util/sqlite_file.dart';

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

class BackupState {
  final String filename;
  final int sizeKb;
  final bool isLoading;
  final String? snackMessage;
  final bool isError;

  const BackupState({
    this.filename = '',
    this.sizeKb = 0,
    this.isLoading = false,
    this.snackMessage,
    this.isError = false,
  });

  BackupState copyWith({
    String? filename,
    int? sizeKb,
    bool? isLoading,
    String? snackMessage,
    bool? isError,
    bool clearSnack = false,
  }) =>
      BackupState(
        filename: filename ?? this.filename,
        sizeKb: sizeKb ?? this.sizeKb,
        isLoading: isLoading ?? this.isLoading,
        snackMessage: clearSnack ? null : (snackMessage ?? this.snackMessage),
        isError: isError ?? this.isError,
      );
}

// ---------------------------------------------------------------------------
// BackupNotifier
// ---------------------------------------------------------------------------

class BackupNotifier extends Notifier<BackupState> {
  @override
  BackupState build() {
    final sqlProvider = ref.read(sqlProviderProvider);
    Future.microtask(() async {
      final file = File(sqlProvider.databasePath);
      final sizeKb = (await file.length()) ~/ 1024;
      state = state.copyWith(filename: sqlProvider.filename, sizeKb: sizeKb);
    });
    return const BackupState();
  }

  Future<void> _refreshSize() async {
    final file = File(ref.read(sqlProviderProvider).databasePath);
    final sizeKb = (await file.length()) ~/ 1024;
    state = state.copyWith(sizeKb: sizeKb);
  }

  Future<void> _refreshAll() async {
    await ref.read(walletNotifierProvider.notifier).refreshWallets();
    await ref.read(transactionNotifierProvider.notifier).refreshAll();
  }

  // -----------BACKUP---------------------------------------------------------------------------

  Future<void> archiving() async {
    state = state.copyWith(isLoading: true, clearSnack: true);
    try {
      final sqlProvider = ref.read(sqlProviderProvider);
      final backupPath = await sqlProvider.createBackupSnapshot();
      final backupFile = File(backupPath);

      await FilePicker.saveFile(
        fileName: "pecunia_backup_${DateTime.now().toFormat("yyyyMMdd")}.db",
        bytes: await backupFile.readAsBytes(),
      );

      if (await backupFile.exists()) await backupFile.delete();
      state = state.copyWith(isLoading: false, snackMessage: '__saved__', isError: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, snackMessage: '__error__', isError: true);
    }
  }

  Future<bool> recovery() async {
    final result = await FilePicker.pickFiles();
    if (result == null) return false;

    final path = result.files.single.path!;
    final backupFile = File(path);

    if (!await isSqliteFile(backupFile)) {
      state = state.copyWith(snackMessage: '__format_error__', isError: true);
      return false;
    }

    state = state.copyWith(isLoading: true, clearSnack: true);
    try {
      final sqlProvider = ref.read(sqlProviderProvider);
      await sqlProvider.close();
      await backupFile.copy(sqlProvider.databasePath);
      await sqlProvider.init();
      await _refreshAll();
      await _refreshSize();
      state = state.copyWith(isLoading: false, snackMessage: '__restored__', isError: false);
      return true;
    } catch (e) {
      final sqlProvider = ref.read(sqlProviderProvider);
      await sqlProvider.init();
      state = state.copyWith(isLoading: false, snackMessage: '__error__', isError: true);
      return false;
    }
  }

  Future<void> recoveryCloud(String fileId) async {
    final googleState = ref.read(googleNotifierProvider);
    if (!googleState.hasDrive || googleState.client == null) return;

    state = state.copyWith(isLoading: true, clearSnack: true);
    final sqlProvider = ref.read(sqlProviderProvider);
    File? tempFile;

    try {
      final driveNotifier = ref.read(googleDriveNotifierProvider.notifier);
      final mediaStream = await driveNotifier.getFileMedia(fileId);
      if (mediaStream == null) throw Exception('Файл не найден');

      final tempDir = await Directory.systemTemp.createTemp('pecunia_cloud_restore');
      tempFile = File('${tempDir.path}/restore.db');
      final fileSink = tempFile.openWrite();
      await mediaStream.stream.pipe(fileSink);
      await fileSink.close();

      if (!await isSqliteFile(tempFile)) {
        state = state.copyWith(
          isLoading: false,
          snackMessage: '__format_error__',
          isError: true,
        );
        return;
      }

      await sqlProvider.close();
      await tempFile.copy(sqlProvider.databasePath);
      await sqlProvider.init();
      await _refreshAll();
      await _refreshSize();
      state = state.copyWith(isLoading: false, snackMessage: '__restored__', isError: false);
    } catch (e) {
      await sqlProvider.init();
      state = state.copyWith(isLoading: false, snackMessage: '__error__', isError: true);
    } finally {
      if (tempFile != null && await tempFile.exists()) {
        await tempFile.delete();
      }
    }
  }

  void clearSnack() => state = state.copyWith(clearSnack: true);

  Future<void> createCloudBackup() async {
    final googleState = ref.read(googleNotifierProvider);
    if (!googleState.hasDrive || googleState.client == null) return;
    final sqlProvider = ref.read(sqlProviderProvider);

    final driveNotifier = ref.read(googleDriveNotifierProvider.notifier);
    await driveNotifier.createFile(
      sqlProvider.databasePath,
      onSuccess: () =>
          state = state.copyWith(snackMessage: '__saved__', isError: false),
      onError: (e) =>
          state = state.copyWith(snackMessage: '__error__', isError: true),
    );
  }
}

final backupNotifierProvider = NotifierProvider<BackupNotifier, BackupState>(
  BackupNotifier.new,
);
