import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pecunia/provider/sql_provider.dart';

part 'sql_provider_ref.g.dart';

/// Глобальный провайдер SQLProvider.
/// Переопределяется в main() через ProviderScope overrides.
@Riverpod(keepAlive: true)
SQLProvider sqlProvider(Ref ref) {
  throw UnimplementedError('Initialize SQLProvider before use');
}
