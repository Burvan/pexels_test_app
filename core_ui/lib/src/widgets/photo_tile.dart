import 'package:flutter/material.dart';
import 'package:domain/domain.dart';
import 'package:core_ui/core_ui.dart';

class PhotoTile extends StatelessWidget {
  final Photo photo;
  final VoidCallback onTap;

  const PhotoTile({
    super.key,
    required this.photo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
          child: Card(
            elevation: AppSize.size4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppBorderRadius.borderRadius8,
              ),
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      AppBorderRadius.borderRadius8,
                    ),
                    child: Wallpaper(
                      photoPath: photo.src.large,
                      id: photo.id,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Material(
          color: AppColors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(
              AppBorderRadius.borderRadius8,
            ),
            onTap: onTap,
          ),
        )
      ],
    );
  }
}
