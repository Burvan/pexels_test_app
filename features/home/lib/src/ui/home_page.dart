import 'package:core/constants/app_constants.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:main_page/main_page.dart';
import 'package:search_page/search_page.dart';
import 'package:settings_page/settings_page.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const <PageRouteInfo>[
        MainRoute(),
        SettingsRoute(),
        SearchRoute(),
      ],
      appBarBuilder: (_, TabsRouter tabsRouter) {
        return AppBar(
          backgroundColor: AppColors.turquoise,
          title: const Text(
            AppConstants.appName,
          ),
          centerTitle: true,
        );
      },
    );
  }
}
