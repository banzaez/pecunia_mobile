import 'dart:async';
import 'dart:io';

import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive_api;
import 'package:googleapis_auth/googleapis_auth.dart' as auth show AuthClient;
import 'package:pecunia/providers/sql_provider_ref.dart';
import 'package:pecunia/util/ext_datetime.dart';

part 'google_notifier.g.dart';

// ---------------------------------------------------------------------------
// Google Drive State
// ---------------------------------------------------------------------------

class GoogleDriveState {
  final List<drive_api.File> files;
  final bool isLoading;
  final String? error;

  const GoogleDriveState({
    this.files = const [],
    this.isLoading = false,
    this.error,
  });

  GoogleDriveState copyWith({
    List<drive_api.File>? files,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) =>
      GoogleDriveState(
        files: files ?? this.files,
        isLoading: isLoading ?? this.isLoading,
        error: clearError ? null : (error ?? this.error),
      );
}

// ---------------------------------------------------------------------------
// Google Auth State
// ---------------------------------------------------------------------------

class GoogleAuthState {
  final GoogleSignInAccount? currentUser;
  final auth.AuthClient? client;

  const GoogleAuthState({this.currentUser, this.client});

  bool get isSignedIn => currentUser != null;
  bool get hasDrive => client != null;

  GoogleAuthState copyWith({
    GoogleSignInAccount? currentUser,
    auth.AuthClient? client,
    bool clearUser = false,
    bool clearDrive = false,
  }) =>
      GoogleAuthState(
        currentUser: clearUser ? null : (currentUser ?? this.currentUser),
        client: clearDrive ? null : (client ?? this.client),
      );
}

// ---------------------------------------------------------------------------
// GoogleNotifier
// ---------------------------------------------------------------------------

@Riverpod(keepAlive: true, name: 'googleNotifierProvider')
class GoogleNotifier extends _$GoogleNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  final List<String> _scopes = [drive_api.DriveApi.driveFileScope];
  StreamSubscription<GoogleSignInAuthenticationEvent>? _authSubscription;

  @override
  GoogleAuthState build() {
    ref.onDispose(() => _authSubscription?.cancel());

    _googleSignIn.initialize().then((_) => _googleSignIn.attemptLightweightAuthentication());

    _authSubscription = _googleSignIn.authenticationEvents.listen(
      (event) async {
        switch (event) {
          case GoogleSignInAuthenticationEventSignIn():
            state = state.copyWith(currentUser: event.user);
            await _checkAuthorization(event.user);
          case GoogleSignInAuthenticationEventSignOut():
            state = state.copyWith(clearUser: true, clearDrive: true);
        }
      },
      onError: (Object error) => debugPrint(error.toString()),
    );

    return const GoogleAuthState();
  }

  Future<void> signIn() async => _googleSignIn.attemptLightweightAuthentication();

  Future<void> signOut() async {
    try {
      state = state.copyWith(clearDrive: true);
      await GoogleSignIn.instance.signOut();
    } catch (e) {
      debugPrint('Ошибка при выходе: $e');
    }
  }

  Future<void> _checkAuthorization(GoogleSignInAccount user) async {
    final authorization = await user.authorizationClient.authorizationForScopes(_scopes);
    if (authorization != null) {
      final client = authorization.authClient(scopes: _scopes);
      state = state.copyWith(
        client: client,
      );
    }
  }
}

// ---------------------------------------------------------------------------
// GoogleDriveNotifier (читает AuthClient из googleNotifierProvider)
// ---------------------------------------------------------------------------

@Riverpod(keepAlive: true, name: 'googleDriveNotifierProvider')
class GoogleDriveNotifier extends _$GoogleDriveNotifier {
  drive_api.DriveApi? _driveApi;

  @override
  GoogleDriveState build() {
    final googleAuth = ref.watch(googleNotifierProvider);
    if (googleAuth.client != null) {
      _driveApi = drive_api.DriveApi(googleAuth.client!);
      Future.microtask(() => readFiles());
    } else {
      _driveApi = null;
    }
    return const GoogleDriveState();
  }

  Future<void> readFiles() async {
    if (_driveApi == null) return;
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final driveFiles = await _driveApi!.files.list(
        q: "name contains 'pecunia_backup' and trashed = false",
        orderBy: "createdTime desc",
      );
      state = state.copyWith(files: driveFiles.files ?? [], isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Ошибка при чтении файлов: $e');
    }
  }

  Future<void> createFile(
    String dbPath, {
    required VoidCallback onSuccess,
    required void Function(String) onError,
  }) async {
    if (_driveApi == null) return;
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final sqlProvider = ref.read(sqlProviderProvider);
      final String backupPath = await sqlProvider.createBackupSnapshot();
      final dbFile = File(backupPath);
      final fileLength = await dbFile.length();

      final driveFile = drive_api.File();
      driveFile.name = "pecunia_backup_${DateTime.now().toFormat("yyyyMMdd_HHmmss")}.db";

      await _driveApi!.files.create(
        driveFile,
        uploadMedia: drive_api.Media(dbFile.openRead(), fileLength),
      );

      if (await dbFile.exists()) await dbFile.delete();
      await readFiles();
      onSuccess();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Ошибка при создании файла: $e');
      onError(e.toString());
    }
  }

  Future<drive_api.Media?> getFileMedia(String fileId) async {
    if (_driveApi == null) return null;
    final mediaStream = await _driveApi!.files.get(
      fileId,
      downloadOptions: drive_api.DownloadOptions.fullMedia,
    ) as drive_api.Media;
    return mediaStream;
  }

  Future<void> deleteFile(
    String fileId, {
    required VoidCallback onSuccess,
    required void Function(String) onError,
  }) async {
    if (_driveApi == null) return;
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      await _driveApi!.files.delete(fileId);
      await readFiles();
      onSuccess();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Ошибка при удалении файла: $e');
      onError(e.toString());
    }
  }
}
