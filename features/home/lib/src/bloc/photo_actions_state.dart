part of 'photo_actions_bloc.dart';

class PhotoActionsState extends Equatable {
  final String snackBarMessage;
  final bool isPhotoSaved;

  const PhotoActionsState({
    required this.snackBarMessage,
    this.isPhotoSaved = false,
  });

  const PhotoActionsState.empty()
      : snackBarMessage = AppConstants.defaultMessage,
        isPhotoSaved = false;

  PhotoActionsState copyWith({
    String? snackBarMessage,
    bool? isPhotoSaved,
  }) {
    return PhotoActionsState(
      snackBarMessage: snackBarMessage ?? this.snackBarMessage,
      isPhotoSaved: isPhotoSaved ?? this.isPhotoSaved,
    );
  }

  @override
  List<Object?> get props => [
    snackBarMessage,
    isPhotoSaved,
  ];
}
