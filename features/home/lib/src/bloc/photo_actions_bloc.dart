import 'package:core/core.dart';
import 'package:domain/domain.dart';

part 'photo_actions_event.dart';
part 'photo_actions_state.dart';

class PhotoActionBloc extends Bloc<PhotoActionsEvent, PhotoActionsState> {
  final SavePhotoToGalleryUseCase _savePhotoToGalleryUseCase;
  final SharePhotoUseCase _sharePhotoUseCase;

  PhotoActionBloc({
    required SavePhotoToGalleryUseCase savePhotoToGalleryUseCase,
    required SharePhotoUseCase sharePhotoUseCase,
  })  : _savePhotoToGalleryUseCase = savePhotoToGalleryUseCase,
        _sharePhotoUseCase = sharePhotoUseCase,
        super(const PhotoActionsState.empty()) {
    on<SavePhotoToGalleryEvent>(_onSavePhotoToGallery);
    on<ResetPhotoSavedEvent>(_onResetPhotoSaved);
    on<SharePhotoEvent>(_onSharePhoto);
  }

  Future<void> _onSavePhotoToGallery(
    SavePhotoToGalleryEvent event,
    Emitter<PhotoActionsState> emit,
  ) async {
    try {
      await _savePhotoToGalleryUseCase.execute(event.photoUrl);
      emit(
        state.copyWith(
          isPhotoSaved: true,
          snackBarMessage: AppConstants.successfulPhotoSaving,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isPhotoSaved: false,
          snackBarMessage: AppConstants.checkInternetConnection,
        ),
      );
    }
  }

  void _onResetPhotoSaved(
    ResetPhotoSavedEvent event,
    Emitter<PhotoActionsState> emit,
  ) {
    emit(
      const PhotoActionsState.empty(),
    );
  }

  Future<void> _onSharePhoto(
    SharePhotoEvent event,
    Emitter<PhotoActionsState> emit,
  ) async {
    try {
      await _sharePhotoUseCase.execute(event.photoUrl);
    } catch (e) {
      emit(
        state.copyWith(
          snackBarMessage: AppConstants.checkInternetConnection,
        ),
      );
    }
  }
}
