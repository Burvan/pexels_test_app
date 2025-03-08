import 'package:domain/domain.dart';

class GetThemeUseCase implements FutureUseCase<bool, NoParams> {
  final SettingsRepository _settingsRepository;

  GetThemeUseCase({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  @override
  Future<bool> execute(NoParams input) async {
    return _settingsRepository.getTheme();
  }
}