import 'dart:async';
import 'dart:io';

import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive_api;
import 'package:googleapis_auth/googleapis_auth.dart' as auth show AuthClient;
import 'package:pecunia/controllers/base_controller.dart';
import 'package:pecunia/provider/sql_provider.dart';
import 'package:pecunia/util/ext_datetime.dart';

class GoogleController extends BaseController {
  final GoogleSignIn googleSignIn = GoogleSignIn.instance;
  late Future<void> _signInInitialized;
  late StreamSubscription<GoogleSignInAuthenticationEvent> _authSubscription;

  final Rxn<GoogleSignInAccount> _currentUser = Rxn();

  bool get isSignedIn => _currentUser.value != null;

  final Rxn<GoogleDriveController> _drive = Rxn();

  GoogleDriveController get drive {
    assert(_drive.value != null);
    return _drive.value!;
  }

  final List<String> scopes = <String>[drive_api.DriveApi.driveFileScope];

  bool get hasDrive => _drive.value != null;

  @override
  void onInit() {
    super.onInit();

    _signInInitialized = googleSignIn.initialize();

    _authSubscription = googleSignIn.authenticationEvents.listen(
      (GoogleSignInAuthenticationEvent event) {
        switch (event) {
          case GoogleSignInAuthenticationEventSignIn():
            _currentUser.value = event.user;
          case GoogleSignInAuthenticationEventSignOut():
            _currentUser.value = null;
        }

        if (_currentUser.value != null) {
          _checkAuthorization();
        }
      },
      onError: (Object error) => debugPrint(error.toString()),
    );

    _signInInitialized.then((void value) => signIn());
  }

  @override
  void onClose() {
    _authSubscription.cancel();
    super.onClose();
  }

  Future<void> signIn() async =>
      googleSignIn.attemptLightweightAuthentication();

  Future<void> signOut() async {
    try {
      _drive.value = null;
      _removeDriveController();
      await GoogleSignIn.instance.signOut();
    } catch (e) {
      debugPrint("Ошибка при выходе: $e");
    }
  }

  // ------------------------------------------------------------

  void _removeDriveController() {
    if (Get.isRegistered<GoogleDriveController>()) {
      Get.delete<GoogleDriveController>(force: true);
    }
  }

  void _updateAuthorization(GoogleSignInClientAuthorization? authorization) {
    if (authorization != null) {
      _removeDriveController();
      _drive.value = Get.put(
        GoogleDriveController(client: authorization.authClient(scopes: scopes)),
      );
    }
  }

  Future<void> _checkAuthorization() async {
    final authorization = await _currentUser.value!.authorizationClient
        .authorizationForScopes(scopes);

    _updateAuthorization(authorization);
  }
}

class GoogleDriveController extends BaseController {
  GoogleDriveController({required this.client})
      : driveApi = drive_api.DriveApi(client);

  final auth.AuthClient client;
  final drive_api.DriveApi driveApi;

  final RxList<drive_api.File> files = <drive_api.File>[].obs;

  @override
  void onInit() {
    super.onInit();
    readFiles();
  }

  Future<void> readFiles() async {
    isLoading = true;
    error = null;
    try {
      final driveFiles = await driveApi.files.list(
        q: "name contains 'pecunia_backup' and trashed = false",
        orderBy: "createdTime desc",
      );
      files.value = driveFiles.files ?? [];
    } catch (e) {
      error = "Ошибка при чтении файлов: $e";
      Get.snackbar("error".tr, "drive_error_read".tr);
    } finally {
      isLoading = false;
    }
  }

  Future<void> createFile() async {
    isLoading = true;
    error = null;
    try {
      final SQLProvider sqlProvider = Get.find();
      final String backupPath = await sqlProvider.createBackupSnapshot();
      final dbFile = File(backupPath);
      final fileLength = await dbFile.length();

      final driveFile = drive_api.File();
      driveFile.name =
          "pecunia_backup_${DateTime.now().toFormat("yyyyMMdd_HHmmss")}.db";

      await driveApi.files.create(
        driveFile,
        uploadMedia: drive_api.Media(dbFile.openRead(), fileLength),
      );

      if (await dbFile.exists()) await dbFile.delete();

      await readFiles();
      Get.snackbar("success".tr, "backup_saved_success".tr);
    } catch (e) {
      error = "Ошибка при создании файла: $e";
      Get.snackbar("error".tr, "backup_error_msg".tr);
    } finally {
      isLoading = false;
    }
  }

  Future<drive_api.Media> getFileMedia(String fileId) async {
    error = null;
    try {
      final mediaStream = await driveApi.files.get(
        fileId,
        downloadOptions: drive_api.DownloadOptions.fullMedia,
      ) as drive_api.Media;
      return mediaStream;
    } catch (e) {
      error = "Ошибка при получении файла: $e";
      Get.snackbar("error".tr, "drive_error_download".tr);
      rethrow;
    }
  }

  Future<void> deleteFile(String fileId) async {
    isLoading = true;
    error = null;
    try {
      await driveApi.files.delete(fileId);
      await readFiles();
      Get.snackbar("success".tr, "backup_deleted_success".tr);
    } catch (e) {
      error = "Ошибка при удалении файла: $e";
      Get.snackbar("error".tr, "drive_error_delete".tr);
    } finally {
      isLoading = false;
    }
  }
}
