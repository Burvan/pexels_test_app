import 'package:flutter/material.dart';

enum BottomNavigationTabs {
  photos(Icons.photo_camera_outlined, 'Photos'),
  search(Icons.search, 'Search'),
  settings(Icons.settings, 'Settings');

  final IconData icon;
  final String tabName;

  const BottomNavigationTabs(
    this.icon,
    this.tabName,
  );
}
