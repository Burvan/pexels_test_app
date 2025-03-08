import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:settings_page/settings_page.dart';

class PexelsApp extends StatelessWidget {
  const PexelsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsBloc(
        getThemeUseCase: appLocator.get<GetThemeUseCase>(),
        setThemeUseCase: appLocator.get<SetThemeUseCase>(),
      ),
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (BuildContext context, SettingsState state) {
          return MaterialApp.router(
            routerDelegate: appLocator.get<AppRouter>().delegate(),
            routeInformationParser:
                appLocator.get<AppRouter>().defaultRouteParser(),
            theme: state.isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
          );
        },
      ),
    );
  }
}
