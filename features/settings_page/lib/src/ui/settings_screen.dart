import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: const Text('Settings Screen'));
  }
}

