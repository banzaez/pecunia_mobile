import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:pecunia/controllers/google_controller.dart';
import 'package:pecunia/provider/sql_provider.dart';
import 'package:pecunia/util/ext_datetime.dart';
import 'package:restart_app/restart_app.dart';

class BackupController extends GetxController {
  final SQLProvider _sqlProvider = Get.find();
  final GoogleController google = Get.find();

  // -----------VARIABLES-------------------------------------------------------------------------

  late final File file;
  late final String filename;
  late final int size;

  // -----------INIT-----------------------------------------------------------------------------

  @override
  void onInit() {
    super.onInit();

    file = File(_sqlProvider.databasePath);
    filename = _sqlProvider.filename;
    size = file.lengthSync() ~/ (1024);
  }

  // -----------BACKUP-----------------------------------------------------------------------------

  Future<void> archiving() async {
    await FilePicker.platform.saveFile(
      fileName: "pecunia_backup_${DateTime.now().toFormat("yyyyMMdd")}.db",
      bytes: await file.readAsBytes(),
    );
  }

  Future<void> recovery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result == null) return;

    final path = result.files.single.path!;

    final extension = path.split(".").last;

    if (extension != "db") {
      Get.snackbar("error".tr, "backup_error_msg".tr);
      return;
    }

    File backupFile = File(path);

    backupFile.copySync(_sqlProvider.databasePath);

    Restart.restartApp(
      notificationTitle: 'backup_restarting'.tr,
      notificationBody: 'backup_restarting_body'.tr,
    );
  }

  Future<void> recoveryCloud(String fileId) async {
    // Запрос на скачивание файла
    final mediaStream = await google.drive.getFileMedia(fileId);

    // Сохранение файла локально
    final localFile = File(_sqlProvider.databasePath);

    final fileSink = localFile.openWrite();
    await mediaStream.stream.pipe(fileSink);
    await fileSink.close();

    // Перезапуск приложения
    Restart.restartApp(
      notificationTitle: 'backup_restarting'.tr,
      notificationBody: 'backup_restarting_body'.tr,
    );
  }
}
