import 'package:flutter/material.dart';

class SelectedWallpaper extends StatelessWidget {
  final int id;
  final String photoPath;

  const SelectedWallpaper({
    required this.id,
    required this.photoPath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: id,
      child: Image.network(
        photoPath,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
