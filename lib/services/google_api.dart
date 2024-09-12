import 'dart:io';

import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;
import 'package:pecunia/util/app_constants.dart';

class GoogleApi {
  Future<void> authenticate(String localFilePath) async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: AppConstants.clientId,
      scopes: [drive.DriveApi.driveAppdataScope],
    );

    final GoogleSignInAccount? us = await googleSignIn.signIn();

    final client = await googleSignIn.authenticatedClient();

    // await clientViaUserConsent(clientId, scopes, (url) {
    //   launchUrlString(url);
    // }).then((authClient) async {
    //   var api = drive.DriveApi(authClient);
    //   await uploadToAppDataFolder(api, localFilePath);
    // });
  }

  Future<void> uploadToAppDataFolder(drive.DriveApi api, String localFilePath) async {
    try {
      // Создание метаданных файла
      var fileMetadata = drive.File();
      fileMetadata.name = "backup.db"; // Имя файла на Google Диске
      fileMetadata.parents = ["appDataFolder"]; // Загружаем в папку appDataFolder

      // Чтение файла с локального устройства
      var file = File(localFilePath);
      var fileStream = http.ByteStream(file.openRead());
      var fileLength = await file.length();

      // Загрузка файла
      var uploadedFile = await api.files.create(
        fileMetadata,
        uploadMedia: drive.Media(fileStream, fileLength),
      );

      print("Файл загружен в папку appDataFolder: ${uploadedFile.name}");
    } catch (e) {
      print("Ошибка при загрузке файла: $e");
    }
  }

  Future<void> downloadFromAppDataFolder(
      drive.DriveApi api, String fileName, String saveToPath) async {
    try {
      // Ищем файл по его имени в appDataFolder
      var fileList = await api.files.list(
        spaces: 'appDataFolder', // Ограничиваем поиск до appDataFolder
        q: "name = '$fileName'",
        $fields: 'files(id, name)', // Получаем id и имя файла
      );

      if (fileList.files?.isEmpty ?? false) {
        print("Файл с именем $fileName не найден в appDataFolder.");
        return;
      }

      // Получаем идентификатор файла для его загрузки
      var fileId = fileList.files!.first.id;

      // Скачиваем файл
      var media = await api.files.get(fileId!, downloadOptions: drive.DownloadOptions.fullMedia);

      // Открываем поток для записи файла локально
      var file = File(saveToPath);
      var fileSink = file.openWrite();

      // // Чтение данных из ответа и запись в файл
      // media.stream.listen((data) {
      //   fileSink.add(data);
      // }, onDone: () async {
      //   await fileSink.flush();
      //   await fileSink.close();
      //   print("Файл $fileName успешно загружен и сохранён в $saveToPath.");
      // }, onError: (e) {
      //   print("Ошибка при скачивании файла: $e");
      // });
    } catch (e) {
      print("Ошибка при скачивании файла: $e");
    }
  }
}
