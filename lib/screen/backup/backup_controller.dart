import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:pecunia/controllers/google_controller.dart';
import 'package:pecunia/controllers/transaction_controller.dart';
import 'package:pecunia/controllers/wallet_controller.dart';
import 'package:pecunia/provider/sql_provider.dart';
import 'package:pecunia/util/ext_datetime.dart';

class BackupController extends GetxController {
  final SQLProvider _sqlProvider = Get.find();
  final GoogleController google = Get.find();

  // -----------VARIABLES-------------------------------------------------------------------------

  late final File file;
  late final String filename;
  final RxInt size = 0.obs;

  // -----------INIT-----------------------------------------------------------------------------

  @override
  void onInit() {
    super.onInit();

    file = File(_sqlProvider.databasePath);
    filename = _sqlProvider.filename;
    _loadSize();
  }

  Future<void> _loadSize() async {
    size.value = (await file.length()) ~/ 1024;
  }

  // -----------BACKUP-----------------------------------------------------------------------------

  Future<void> archiving() async {
    try {
      final String backupPath = await _sqlProvider.createBackupSnapshot();
      final backupFile = File(backupPath);

      await FilePicker.saveFile(
        fileName: "pecunia_backup_${DateTime.now().toFormat("yyyyMMdd")}.db",
        bytes: await backupFile.readAsBytes(),
      );

      if (await backupFile.exists()) await backupFile.delete();
      Get.snackbar("success".tr, "backup_saved_success".tr);
    } catch (e) {
      Get.snackbar("error".tr, "backup_error_msg".tr);
    }
  }

  Future<void> recovery() async {
    FilePickerResult? result = await FilePicker.pickFiles();

    if (result == null) return;

    final path = result.files.single.path!;
    final backupFile = File(path);

    if (!await _isSqliteFile(backupFile)) {
      await Future.delayed(const Duration(milliseconds: 300));
      Get.snackbar("error".tr, "backup_error_msg".tr);
      return;
    }

    try {
      // Закрываем БД перед заменой файла
      await _sqlProvider.close();

      await backupFile.copy(_sqlProvider.databasePath);

      await _sqlProvider.init();
      await Get.find<WalletController>().refreshWallets();
      await Get.find<TransactionController>().refreshTransactions();

      Get.offAllNamed('/');
      Get.snackbar("success".tr, "backup_restored_success".tr);
      _loadSize();
    } catch (e) {
      Get.snackbar("error".tr, "backup_error_msg".tr);
      // Пытаемся переинициализировать БД, если что-то пошло не так
      await _sqlProvider.init();
    }
  }

  Future<bool> _isSqliteFile(File file) async {
    try {
      if (await file.length() < 16) return false;
      final bytes = await file.openRead(0, 16).first;
      final header = String.fromCharCodes(bytes);
      return header.startsWith("SQLite format 3");
    } catch (e) {
      return false;
    }
  }

  Future<void> recoveryCloud(String fileId) async {
    final mediaStream = await google.drive.getFileMedia(fileId);

    // Закрываем БД перед заменой файла
    await _sqlProvider.close();

    final localFile = File(_sqlProvider.databasePath);

    final fileSink = localFile.openWrite();
    await mediaStream.stream.pipe(fileSink);
    await fileSink.close();

    await _sqlProvider.init();
    await Get.find<WalletController>().refreshWallets();
    await Get.find<TransactionController>().refreshTransactions();

    Get.offAllNamed('/');
    Get.snackbar("success".tr, "backup_restored_success".tr);
    _loadSize();
  }
}
