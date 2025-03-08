import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:settings_page/src/bloc/settings_bloc.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsBloc bloc = BlocProvider.of<SettingsBloc>(context);

    return BlocBuilder<SettingsBloc, SettingsState>(
        builder: (_, SettingsState state) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(AppPadding.padding10),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.padding15,
                vertical: AppPadding.padding10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    AppConstants.darkTheme,
                    style: AppTextTheme.font21Bold,
                  ),
                  Switch(
                    value: state.isDark,
                    onChanged: (bool value) {
                      bloc.add(
                        SetThemeEvent(isDark: value),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
