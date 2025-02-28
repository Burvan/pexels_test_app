part of 'main_page_bloc.dart';

abstract class MainPageEvent {
  const MainPageEvent();
}

class InitEvent extends MainPageEvent {
  const InitEvent();
}

class GetTrendingPhotosNextPageEvent extends MainPageEvent {
  const GetTrendingPhotosNextPageEvent();
}

class SavePhotoToGalleryEvent extends MainPageEvent {
  final String photoUrl;

  SavePhotoToGalleryEvent({required this.photoUrl});
}

class ResetPhotoSavedEvent extends MainPageEvent {
  const ResetPhotoSavedEvent();
}

class SharePhotoEvent extends MainPageEvent {
  final String photoUrl;

  SharePhotoEvent({required this.photoUrl});
}