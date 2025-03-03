import 'package:core/core.dart';
import 'package:domain/domain.dart';

part 'main_page_state.dart';
part 'main_page_event.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final GetTrendingPhotosUseCase _getTrendingPhotosUseCase;

  MainPageBloc({
    required GetTrendingPhotosUseCase getTrendingPhotosUseCase,
  })  : _getTrendingPhotosUseCase = getTrendingPhotosUseCase,
        super(const MainPageState.empty()) {
    on<InitEvent>(_onInit);
    on<GetTrendingPhotosNextPageEvent>(_onGetTrendingPhotos);

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
      List<Photo> photos = await _getTrendingPhotosUseCase.execute(
        FetchPhotosParams(
          page: state.currentPage,
        ),
      );

      final Set<int> uniqueIds = state.photos.map((photo) => photo.id).toSet();
      final List<Photo> newPhotos =
          photos.where((photo) => !uniqueIds.contains(photo.id)).toList();

      emit(
        state.copyWith(
          photos: List.of(state.photos)..addAll(newPhotos),
          isLoading: false,
          currentPage: state.currentPage + 1,
          isEndOfList: photos.isEmpty,
        ),
      );

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
}
