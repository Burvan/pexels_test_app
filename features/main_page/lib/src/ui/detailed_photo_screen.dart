import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:domain/domain.dart';
import 'package:core_ui/core_ui.dart';
import 'package:core/core.dart';

@RoutePage()
class DetailedPhotoScreen extends StatelessWidget {
  final Photo photo;

  const DetailedPhotoScreen({
    super.key,
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            '${AppConstants.photoBy}${photo.photographer ?? AppConstants.unknownPhotographer}',
            style: AppTextTheme.font19Bold,
          ),
          backgroundColor: AppColors.turquoise,
        ),
        body: Stack(
          children: <Widget>[
            SelectedWallpaper(
              id: photo.id,
              photoPath: photo.src.large,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: AppPadding.padding5,
                horizontal: AppPadding.padding20,
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  photo.alt ?? AppConstants.noDescription,
                  style: AppTextTheme.font16TurquoiseBold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Column(
// children: <Widget>[
// SelectedWallpaper(
// photoPath: photo.src.large,
// id: photo.id,
// ),
// Padding(
// padding: EdgeInsets.all(
// AppPadding.padding10,
// ),
// child: Column(
// children: <Widget>[
// if (photo.alt != null && photo.alt!.isNotEmpty)
// Text(photo.alt!)
// ],
// ),
// ),
// ],
// ),
