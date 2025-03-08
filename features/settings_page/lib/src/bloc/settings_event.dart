part of 'settings_bloc.dart';

abstract class SettingsEvent {
  const SettingsEvent();
}

class InitSettingsEvent extends SettingsEvent {
  const InitSettingsEvent();
}

class SetThemeEvent extends SettingsEvent {
  final bool isDark;

  SetThemeEvent({required this.isDark});
}