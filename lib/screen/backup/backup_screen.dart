import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/generated/assets.dart';
import 'package:pecunia/screen/backup/backup_controller.dart';
import 'package:pecunia/styles/app_border_style.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/widgets/button_social.dart';
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
            _localBackup(),
            AppSpaces.v48,
            _googleBackup(),
          ],
        ),
      );

  // ----------LOCAL-BACKUP----------------------------------------------------------------------

  Widget _text(String value, String hint) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: AppTextStyle.text18w400()),
          Text(hint, style: AppTextStyle.text14w400()),
        ],
      );

  Widget _localBackup() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppSpaces.v24,
          Column(
            children: [
              _text(controller.filename, "backup_filename".tr),
              AppSpaces.v32,
              _text("${controller.size}KB", "backup_size".tr),
            ],
          ),
          AppSpaces.v24,
          SizedBox(
            width: 256,
            child: ElevatedButton(
              onPressed: controller.archiving,
              child: Text("backup_archiving".tr),
            ),
          ),
          AppSpaces.v12,
          SizedBox(
            width: 256,
            child: ElevatedButton(
              onPressed: controller.recovery,
              child: Text("backup_recovery".tr),
            ),
          ),
        ],
      );

  // ----------Google-Drive----------------------------------------------------------------------

  Widget _googleBackup() => Obx(() => Expanded(
        child: Column(
          children: [
            controller.google.isSignedIn
                ? ButtonSocial(
                    onPressed: controller.google.singOut,
                    label: "sign_out_with_google".tr,
                    icon: Assets.pngIconGoogle,
                  )
                : ButtonSocial(
                    onPressed: controller.google.singIn,
                    label: "sign_in_with_google".tr,
                    icon: Assets.pngIconGoogle,
                  ),
            Expanded(child: Obx(() => _listFiles())),
          ],
        ),
      ));

  Widget _listItem(String name, String id) => Container(
        decoration: BoxDecoration(
          borderRadius: AppBorderStyle.borderRadius,
          color: Colors.white10,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          children: [
            AppSpaces.h16,
            Text(name, style: AppTextStyle.text12w600(color: Colors.white)),
            Spacer(),
            IconButton(
              onPressed: () => _confirmDialog(
                onConfirm: () => controller.google.drive.deleteFile(id),
                title: "backup_cloud_dialog_delete".tr,
                content: "backup_cloud_dialog_delete_content".tr,
              ),
              icon: Icon(Icons.delete, color: Colors.red.shade400),
            ),
            IconButton(
              onPressed: () => _confirmDialog(
                onConfirm: () => controller.recoveryCloud(id),
                title: "backup_cloud_dialog_recovery".tr,
                content: "backup_cloud_dialog_recovery_content".tr,
              ),
              icon: Icon(Icons.download, color: Colors.blue.shade400),
            ),
          ],
        ),
      );

  Widget _listFiles() {
    if (!controller.google.isSignedIn || !controller.google.hasDrive) return SizedBox.shrink();

    final driveFiles = controller.google.drive.files;

    return Column(
      children: [
        AppSpaces.v24,
        controller.google.drive.isLoading
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: controller.google.drive.createFile,
                child: Text("backup_create_cloud_recovery".tr),
              ),
        AppSpaces.v32,
        driveFiles.isEmpty
            ? Text(
                "backup_cloud_empty".tr,
                style: AppTextStyle.text14w600(color: Colors.white30),
              )
            : Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: driveFiles.length,
                  itemBuilder: (_, index) => _listItem(
                    driveFiles[index].name!,
                    driveFiles[index].id!,
                  ),
                  separatorBuilder: (_, __) => AppSpaces.v8,
                ),
              ),
      ],
    ).paddingSymmetric(horizontal: 16);
  }

  // ----------DIALOG---------------------------------------------------------------------------

  Future<bool> _confirmDialog({
    required VoidCallback onConfirm,
    required String title,
    required String content,
  }) async =>
      await Get.defaultDialog(
        title: title,
        middleText: content,
        confirm: TextButton(
          onPressed: () {
            onConfirm();
            Get.closeAllDialogs();
          },
          child: Text(
            "yes".tr,
            style: AppTextStyle.text16w600(color: Colors.red),
          ),
        ),
        cancel: TextButton(
          onPressed: () => Get.closeAllDialogs(),
          child: Text("no".tr),
        ),
      );
}
