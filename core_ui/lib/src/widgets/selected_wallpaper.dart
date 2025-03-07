
import 'package:cached_network_image/cached_network_image.dart';
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
      child: CachedNetworkImage(
        imageUrl: photoPath,
        cacheKey: photoPath.split('?').first,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        errorWidget: (BuildContext context, String url, Object error) {
          return Image.asset(
            'assets/images/pexels_placeholder2.jpg',
          );
        },
      ),
    );
  }
}