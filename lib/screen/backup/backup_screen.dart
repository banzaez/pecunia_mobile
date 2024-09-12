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
          children: [
            AppSpaces.v16,
            Text(controller.filename, style: AppTextStyle.text16w400()),
            Text("backup_filename".tr, style: AppTextStyle.text12w400()),
            AppSpaces.v16,
            Text("${controller.size}KB"),
            Text("backup_size".tr, style: AppTextStyle.text12w400()),
            const Spacer(),
            ElevatedButton(
              onPressed: controller.archiving,
              child: Text("backup_archiving".tr),
            ),
            AppSpaces.v16,
            ElevatedButton(
              onPressed: controller.recovery,
              child: Text("backup_recovery".tr),
            ),
            AppSpaces.v64,
          ],
        ),
      );
}
