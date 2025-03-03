part of 'photo_actions_bloc.dart';

class PhotoActionsState extends Equatable {
  final String? errorMessage;
  final bool isPhotoSaved;

  const PhotoActionsState({
    this.errorMessage,
    this.isPhotoSaved = false,
  });

  const PhotoActionsState.empty()
      : errorMessage = null,
        isPhotoSaved = false;

  PhotoActionsState copyWith({
    String? errorMessage,
    bool? isPhotoSaved,
  }) {
    return PhotoActionsState(
      errorMessage: errorMessage ?? this.errorMessage,
      isPhotoSaved: isPhotoSaved ?? this.isPhotoSaved,
    );
  }

  @override
  List<Object?> get props => [
    errorMessage,
    isPhotoSaved,
  ];
}
