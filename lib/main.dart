import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:pexels_test_app/app/pexels_app.dart';

Future<void> main() async{
  appDI.init();
  await dataDI.setupAppLocator();
  runApp(const PexelsApp());
}

