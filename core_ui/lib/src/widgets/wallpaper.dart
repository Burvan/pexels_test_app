import 'package:cached_network_image/cached_network_image.dart';
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
        child: CachedNetworkImage(
          imageUrl: photoPath,
          cacheKey: photoPath.split('?').first,
          fit: BoxFit.cover,
          placeholder: (context, url) => const SizedBox.shrink(),
          errorWidget: (BuildContext context, String url, Object error) {
            return Image.asset(
              'assets/images/pexels_placeholder2.jpg',
            );
          },
        ),
      ),
    );
  }
}
