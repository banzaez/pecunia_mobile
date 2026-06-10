// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sql_provider_ref.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Глобальный провайдер SQLProvider.
/// Переопределяется в main() через ProviderScope overrides.

@ProviderFor(sqlProvider)
final sqlProviderProvider = SqlProviderProvider._();

/// Глобальный провайдер SQLProvider.
/// Переопределяется в main() через ProviderScope overrides.

final class SqlProviderProvider
    extends $FunctionalProvider<SQLProvider, SQLProvider, SQLProvider>
    with $Provider<SQLProvider> {
  /// Глобальный провайдер SQLProvider.
  /// Переопределяется в main() через ProviderScope overrides.
  SqlProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sqlProviderProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sqlProviderHash();

  @$internal
  @override
  $ProviderElement<SQLProvider> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SQLProvider create(Ref ref) {
    return sqlProvider(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SQLProvider value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SQLProvider>(value),
    );
  }
}

String _$sqlProviderHash() => r'aacea356c689347b384cc43afeb0434d62899696';
