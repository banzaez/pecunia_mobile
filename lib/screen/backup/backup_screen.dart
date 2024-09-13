import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/screen/backup/backup_controller.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/widgets/custom_app_bar.dart';

class BackupScreen extends GetView<BackupController> {
  const BackupScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CustomAppBar(title: "backup_title".tr),
        body: _body(),
      );

  // --------------------------------------------------------------------------------------------

  Widget _body() => Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                _text(controller.filename, "backup_filename".tr),
                AppSpaces.v32,
                _text("${controller.size}KB", "backup_size".tr),
              ],
            ),
            _buttons(),
          ],
        ),
      );

  // --------------------------------------------------------------------------------------------

  Widget _text(String value, String hint) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: AppTextStyle.text18w400()),
          Text(hint, style: AppTextStyle.text14w400()),
        ],
      );

  Widget _buttons() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 256,
            child: ElevatedButton(
              onPressed: controller.archiving,
              child: Text("backup_archiving".tr),
            ),
          ),
          AppSpaces.v32,
          SizedBox(
            width: 256,
            child: ElevatedButton(
              onPressed: controller.recovery,
              child: Text("backup_recovery".tr),
            ),
          ),
        ],
      );
}
