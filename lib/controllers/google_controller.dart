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

    googleSignIn.authenticationEvents
        .listen((GoogleSignInAuthenticationEvent event) {
          switch (event) {
            case GoogleSignInAuthenticationEventSignIn():
              _currentUser.value = event.user;
            case GoogleSignInAuthenticationEventSignOut():
              _currentUser.value = null;
          }

          if (_currentUser.value != null) {
            _checkAuthorization();
          }
        })
        .onError((Object error) {
          debugPrint(error.toString());
        });

    _signInInitialized.then((void value) {
      signIn();
    });
  }

  Future<void> signIn() async =>
      googleSignIn.attemptLightweightAuthentication();

  Future<void> signOut() async {
    try {
      _drive.value = null;
      await GoogleSignIn.instance.signOut();
    } catch (e) {
      debugPrint("Ошибка при выходе: $e");
    }
  }

  // ------------------------------------------------------------

  void _updateAuthorization(GoogleSignInClientAuthorization? authorization) {
    if (authorization != null) {
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
  GoogleDriveController({required this.client});

  final auth.AuthClient client;

  final RxList<drive_api.File> files = <drive_api.File>[].obs;

  @override
  void onInit() {
    super.onInit();
    readFiles();
  }

  Future<void> readFiles() async {
    isLoading = true;
    try {
      final drive_api.DriveApi drive = drive_api.DriveApi(client);
      final driveFiles = await drive.files.list();
      files.value = driveFiles.files ?? [];
    } catch (e) {
      debugPrint("Ошибка при чтении файлов: $e");
    } finally {
      isLoading = false;
    }
  }

  Future<void> createFile() async {
    isLoading = true;
    try {
      final SQLProvider sqlProvider = Get.find();
      final dbFile = File(sqlProvider.databasePath);

      if (!dbFile.existsSync()) {
        debugPrint("Файл базы данных не найден.");
        return;
      }

      final drive_api.DriveApi drive = drive_api.DriveApi(client);
      final driveFile = drive_api.File();
      driveFile.name =
          "penunia_backup_${DateTime.now().toFormat("yyyyMMdd_HHmmss")}.db";

      await drive.files.create(
        driveFile,
        uploadMedia: drive_api.Media(dbFile.openRead(), dbFile.lengthSync()),
      );

      await readFiles();
    } catch (e) {
      debugPrint("Ошибка при создании файла: $e");
    } finally {
      isLoading = false;
    }
  }

  Future<drive_api.Media> getFileMedia(String fileId) async {
    try {
      final drive_api.DriveApi drive = drive_api.DriveApi(client);
      final mediaStream =
          await drive.files.get(
                fileId,
                downloadOptions: drive_api.DownloadOptions.fullMedia,
              )
              as drive_api.Media;
      return mediaStream;
    } catch (e) {
      debugPrint("Ошибка при получении файла: $e");
      rethrow;
    }
  }

  Future<void> deleteFile(String fileId) async {
    isLoading = true;
    try {
      final drive_api.DriveApi drive = drive_api.DriveApi(client);
      await drive.files.delete(fileId);
      await readFiles();
    } catch (e) {
      debugPrint("Ошибка при удалении файла: $e");
    } finally {
      isLoading = false;
    }
  }
}
