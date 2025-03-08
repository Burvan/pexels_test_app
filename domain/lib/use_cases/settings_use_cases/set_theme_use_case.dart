import 'package:domain/domain.dart';

class SetThemeUseCase implements FutureUseCase<void, bool> {
  final SettingsRepository _settingsRepository;

  SetThemeUseCase({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  @override
  Future<void> execute(bool isDark) async {
    await _settingsRepository.setTheme(isDark);
  }
}