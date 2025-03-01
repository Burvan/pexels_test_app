import 'package:flutter/material.dart';
import 'package:main_page/main_page.dart';
import 'package:main_page/src/bloc/main_page_bloc.dart';
import 'package:main_page/src/ui/detailed_photo_screen.dart';
import 'package:navigation/navigation.dart';
import 'package:domain/domain.dart';

part 'main_page_router.gr.dart';

@AutoRouterConfig()
class MainPageRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[];
}