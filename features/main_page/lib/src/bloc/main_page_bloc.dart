import 'package:core/core.dart';
import 'package:domain/domain.dart';

part 'main_page_state.dart';
part 'main_page_event.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final GetTrendingPhotosUseCase _getTrendingPhotosUseCase;
  final SavePhotoToGalleryUseCase _savePhotoToGalleryUseCase;
  final SharePhotoUseCase _sharePhotoUseCase;

  MainPageBloc({
    required GetTrendingPhotosUseCase getTrendingPhotosUseCase,
    required SavePhotoToGalleryUseCase savePhotoToGalleryUseCase,
    required SharePhotoUseCase sharePhotoUseCase,
  })  : _getTrendingPhotosUseCase = getTrendingPhotosUseCase,
        _savePhotoToGalleryUseCase = savePhotoToGalleryUseCase,
        _sharePhotoUseCase = sharePhotoUseCase,
        super(const MainPageState.empty()) {
    on<InitEvent>(_onInit);
    on<GetTrendingPhotosNextPageEvent>(_onGetTrendingPhotos);
    on<SavePhotoToGalleryEvent>(_onSavePhotoToGallery);
    on<ResetPhotoSavedEvent>(_onResetPhotoSaved);
    on<SharePhotoEvent>(_onSharePhoto);

    add(const InitEvent());
  }

  void _onInit(
    InitEvent event,
    Emitter<MainPageState> emit,
  ) {
    add(const GetTrendingPhotosNextPageEvent());
  }

  Future<void> _onGetTrendingPhotos(
    GetTrendingPhotosNextPageEvent event,
    Emitter<MainPageState> emit,
  ) async {
    if (state.isEndOfList || state.isLoading) return;
    emit(state.copyWith(isLoading: true));

    try {
      List<Photo> photos =
          await _getTrendingPhotosUseCase.execute(state.currentPage);

      final Set<int> uniqueIds = state.photos.map((photo) => photo.id).toSet();
      final List<Photo> newPhotos =
          photos.where((photo) => !uniqueIds.contains(photo.id)).toList();

      emit(state.copyWith(
        photos: List.of(state.photos)..addAll(newPhotos),
        isLoading: false,
        currentPage: state.currentPage + 1,
        isEndOfList: photos.isEmpty,
      ));
    } on ApiException catch (_) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'No such photos',
      ));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'An unexpected error occurred',
        ),
      );
    }
  }

  Future<void> _onSavePhotoToGallery(
    SavePhotoToGalleryEvent event,
    Emitter<MainPageState> emit,
  ) async {
    try {
      await _savePhotoToGalleryUseCase.execute(event.photoUrl);
      emit(
        state.copyWith(isPhotoSaved: true),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: 'Failed to save photo: $e',
          isPhotoSaved: false,
        ),
      );
    }
  }

  void _onResetPhotoSaved(
    ResetPhotoSavedEvent event,
    Emitter<MainPageState> emit,
  ) {
    emit(state.copyWith(isPhotoSaved: false));
  }

  Future<void> _onSharePhoto(
    SharePhotoEvent event,
    Emitter<MainPageState> emit,
  ) async {
    try {
      await _sharePhotoUseCase.execute(event.photoUrl);
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: 'Failed to share photo: $e',
        ),
      );
    }
  }
}
