import 'package:flutter/material.dart';
import 'package:main_page/src/bloc/main_page_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:domain/domain.dart';
import 'package:core_ui/core_ui.dart';
import 'package:core/core.dart';

@RoutePage()
class DetailedPhotoScreen extends StatelessWidget {
  final Photo photo;
  final MainPageBloc bloc;

  const DetailedPhotoScreen({
    super.key,
    required this.bloc,
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocListener<MainPageBloc, MainPageState>(
        listener: (BuildContext context, MainPageState state) {
          if (state.isPhotoSaved) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: AppColors.turquoise,
                content: Text(
                  textAlign: TextAlign.center,
                  AppConstants.successfulPhotoSaving,
                  style: AppTextTheme.font19WhiteBold,
                ),
                duration: Duration(seconds: 3),
              ),
            );
            bloc.add(const ResetPhotoSavedEvent());
          }
        },
        child: SafeArea(
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
                  padding: const EdgeInsets.all(
                    AppPadding.padding10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      CustomIconButton(
                        onPressed: () async {
                          if (await Permission.storage.request().isGranted) {
                            bloc.add(
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
                          bloc.add(
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
        ),
      ),
    );
  }
}
