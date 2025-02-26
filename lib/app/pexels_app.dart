import 'package:flutter/material.dart';
import 'package:main_page/main_page.dart';

class PexelsApp extends StatelessWidget {
  const PexelsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainScreen(),
    );
  }
}
