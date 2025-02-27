import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class Wallpaper extends StatelessWidget {
  final String photoPath;
  final int id;

  const Wallpaper({
    required this.photoPath,
    required this.id,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: id,
      child: AspectRatio(
        aspectRatio: AppScale.scale1,
        child: Image.network(
          photoPath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
