import 'package:flutter/material.dart';
import 'package:home/home.dart';
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
    return BlocProvider(
      create: (_) => PhotoActionBloc(
        savePhotoToGalleryUseCase: appLocator.get<SavePhotoToGalleryUseCase>(),
        sharePhotoUseCase: appLocator.get<SharePhotoUseCase>(),
      ),
      child: BlocConsumer<PhotoActionBloc, PhotoActionsState>(
        listener: (BuildContext context, PhotoActionsState state) {
          if (state.snackBarMessage != AppConstants.defaultMessage) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor:
                    state.isPhotoSaved ? AppColors.turquoise : AppColors.red,
                content: Text(
                  state.snackBarMessage,
                  style: AppTextTheme.font19WhiteBold,
                  textAlign: TextAlign.center,
                ),
                duration: const Duration(seconds: 3),
              ),
            );
            context.read<PhotoActionBloc>().add(const ResetPhotoSavedEvent());
          }
        },
        builder: (context, state) {
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
                    padding: const EdgeInsets.all(AppPadding.padding10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        CustomIconButton(
                          onPressed: () async {
                            if (await Permission.storage.request().isGranted) {
                              context.read<PhotoActionBloc>().add(
                                    SavePhotoToGalleryEvent(
                                      photoUrl: photo.src.large,
                                    ),
                                  );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(AppConstants.permissionDenied),
                                ),
                              );
                            }
                          },
                          icon: Icon(Icons.save_alt),
                        ),
                        SizedBox(width: AppSize.size8),
                        CustomIconButton(
                          onPressed: () async {
                            context.read<PhotoActionBloc>().add(
                                  SharePhotoEvent(photoUrl: photo.src.large),
                                );
                          },
                          icon: Icon(Icons.share),
                        ),
                      ],
                    ),
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
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
