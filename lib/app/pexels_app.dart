import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:main_page/main_page.dart';
import 'package:navigation/navigation.dart';

class PexelsApp extends StatelessWidget {
  const PexelsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: appLocator.get<AppRouter>().delegate(),
      routeInformationParser: appLocator.get<AppRouter>().defaultRouteParser(),
    );
  }
}
