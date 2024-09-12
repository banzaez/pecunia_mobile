import 'package:get/get.dart';
import 'package:pecunia/screen/backup/backup_controller.dart';

class BackupBinding implements Binding {
  @override
  List<Bind> dependencies() => [
        Bind.put(BackupController()),
      ];
}
