// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GoogleNotifier)
final googleNotifierProvider = GoogleNotifierProvider._();

final class GoogleNotifierProvider
    extends $NotifierProvider<GoogleNotifier, GoogleAuthState> {
  GoogleNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'googleNotifierProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$googleNotifierHash();

  @$internal
  @override
  GoogleNotifier create() => GoogleNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoogleAuthState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoogleAuthState>(value),
    );
  }
}

String _$googleNotifierHash() => r'63911b50151ee2e2257558360eba5c53e6dac771';

abstract class _$GoogleNotifier extends $Notifier<GoogleAuthState> {
  GoogleAuthState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<GoogleAuthState, GoogleAuthState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GoogleAuthState, GoogleAuthState>,
              GoogleAuthState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(GoogleDriveNotifier)
final googleDriveNotifierProvider = GoogleDriveNotifierProvider._();

final class GoogleDriveNotifierProvider
    extends $NotifierProvider<GoogleDriveNotifier, GoogleDriveState> {
  GoogleDriveNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'googleDriveNotifierProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$googleDriveNotifierHash();

  @$internal
  @override
  GoogleDriveNotifier create() => GoogleDriveNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoogleDriveState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoogleDriveState>(value),
    );
  }
}

String _$googleDriveNotifierHash() =>
    r'f2c13164c25bdedd93266ab656b7818f88fda1d0';

abstract class _$GoogleDriveNotifier extends $Notifier<GoogleDriveState> {
  GoogleDriveState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<GoogleDriveState, GoogleDriveState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GoogleDriveState, GoogleDriveState>,
              GoogleDriveState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
