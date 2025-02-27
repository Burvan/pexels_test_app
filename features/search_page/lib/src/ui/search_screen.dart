import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

@RoutePage()
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: const Text('Search Screen'));
  }
}
