import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:pecunia/provider/sql_provider.dart';
import 'package:restart_app/restart_app.dart';

class BackupController extends GetxController {
  final SQLProvider _sqlProvider = Get.find();

  late final File file;
  late final String filename;
  late final int size;

  // -----------INIT-----------------------------------------------------------------------------

  @override
  void onInit() {
    super.onInit();

    file = File(_sqlProvider.databasesPath);
    filename = _sqlProvider.filename;
    size = file.lengthSync() ~/ (1024);
  }

  // -----------BACKUP-----------------------------------------------------------------------------

  Future<void> archiving() async {
    FilePicker.platform.saveFile(
      fileName: filename,
      bytes: file.readAsBytesSync(),
    );
  }

  Future<void> recovery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result == null) return;

    File backupFile = File(result.files.single.path!);
    backupFile.copySync(_sqlProvider.databasesPath);

    Restart.restartApp(
      notificationTitle: 'backup_restarting'.tr,
      notificationBody: 'backup_restarting_body'.tr,
    );
  }
}
