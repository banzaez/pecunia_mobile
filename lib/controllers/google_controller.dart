import 'dart:io';

import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive_api;
import 'package:googleapis_auth/googleapis_auth.dart' as auth show AuthClient;
import 'package:pecunia/controllers/base_controller.dart';
import 'package:pecunia/provider/sql_provider.dart';
import 'package:pecunia/util/ext_datetime.dart';

class GoogleController extends BaseController {
  late final GoogleSignIn _googleSignIn;
  final Rxn<GoogleSignInAccount> _currentUser = Rxn();
  bool get isSignedIn => _currentUser.value != null;

  final Rxn<GoogleDriveController> _drive = Rxn();
  GoogleDriveController get drive {
    assert(_drive.value != null);
    return _drive.value!;
  }

  bool get hasDrive => _drive.value != null;

  @override
  void onInit() {
    super.onInit();

    _googleSignIn = GoogleSignIn(
      scopes: <String>[
        drive_api.DriveApi.driveFileScope,
      ],
    );

    _googleSignIn.onCurrentUserChanged.listen(onCurrentUserChanged);

    // Проверка авторизации
    _googleSignIn.signInSilently();
  }

  Future<void> singIn() async => await _googleSignIn.signIn();

  Future<void> singOut() async {
    _drive.value = null;
    await _googleSignIn.signOut();
  }

  Future<void> onCurrentUserChanged(currentUser) async {
    _currentUser.value = currentUser;

    if (_currentUser.value == null) return;

    final client = await _googleSignIn.authenticatedClient();

    if (client == null) return;

    _drive.value = Get.put(GoogleDriveController(client: client));
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
    final drive_api.DriveApi drive = drive_api.DriveApi(client);
    final driveFiles = await drive.files.list();

    files.value = driveFiles.files ?? [];
    isLoading = false;
  }

  Future<void> createFile() async {
    isLoading = true;
    final drive_api.DriveApi drive = drive_api.DriveApi(client);

    // Получаем путь к файлу базы данных
    final SQLProvider sqlProvider = Get.find();
    final dbFile = File(sqlProvider.databasesPath);

    // Загружаем файл
    final driveFile = drive_api.File();
    driveFile.name = "penunia_backup_${DateTime.now().toFormat("yyyyMMdd_HHmmss")}.db";

    await drive.files.create(
      driveFile,
      uploadMedia: drive_api.Media(dbFile.openRead(), dbFile.lengthSync()),
    );

    await readFiles();
    isLoading = false;
  }

  Future<drive_api.Media> getFileMedia(String fileId) async {
    final drive_api.DriveApi drive = drive_api.DriveApi(client);
    final mediaStream = await drive.files.get(
      fileId,
      downloadOptions: drive_api.DownloadOptions.fullMedia,
    ) as drive_api.Media;
    return mediaStream;
  }

  Future<void> deleteFile(String fileId) async {
    isLoading = true;
    final drive_api.DriveApi drive = drive_api.DriveApi(client);
    await drive.files.delete(fileId);

    await readFiles();
    isLoading = false;
  }
}
