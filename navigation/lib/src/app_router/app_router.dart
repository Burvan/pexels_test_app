import 'package:auto_route/auto_route.dart';
import 'package:home/home.dart';
import 'package:main_page/main_page.dart';
import 'package:search_page/search_page.dart';
import 'package:settings_page/settings_page.dart';

class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[
    AutoRoute(
        page: HomeRoute.page,
      path: '/',
      children: <AutoRoute>[
        AutoRoute(page: MainRoute.page, initial: true),
        AutoRoute(page: SearchRoute.page),
        AutoRoute(page: SettingsRoute.page),
      ],
    ),
    AutoRoute(page: DetailedPhotoRoute.page),
  ];

}