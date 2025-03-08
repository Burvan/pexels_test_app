import 'package:data/data.dart';
import 'package:domain/domain.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final HiveProvider _hiveProvider;

  SettingsRepositoryImpl({
    required HiveProvider hiveProvider,
  }) : _hiveProvider = hiveProvider;

  @override
  Future<bool> getTheme() async {
    return _hiveProvider.getTheme();
  }

  @override
  Future<void> setTheme(bool isDark) async {
    await _hiveProvider.setTheme(isDark);
  }
}
