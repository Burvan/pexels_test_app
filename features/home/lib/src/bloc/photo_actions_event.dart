part of 'photo_actions_bloc.dart';

abstract class PhotoActionsEvent {
  const PhotoActionsEvent();
}

class SavePhotoToGalleryEvent extends PhotoActionsEvent {
  final String photoUrl;

  SavePhotoToGalleryEvent({required this.photoUrl});
}

class ResetPhotoSavedEvent extends PhotoActionsEvent {
  const ResetPhotoSavedEvent();
}

class SharePhotoEvent extends PhotoActionsEvent {
  final String photoUrl;

  SharePhotoEvent({required this.photoUrl});
}