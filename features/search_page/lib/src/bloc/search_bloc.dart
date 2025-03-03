import 'package:core/core.dart';
import 'package:domain/domain.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetTrendingPhotosUseCase _getTrendingPhotosUseCase;
  SearchBloc({
    required GetTrendingPhotosUseCase getTrendingPhotosUseCase,
  })  : _getTrendingPhotosUseCase = getTrendingPhotosUseCase,
        super(const SearchState.empty()) {
    on<SearchPhotosEvent>(_onSearchPhotos);
  }

  Future<void> _onSearchPhotos(
    SearchPhotosEvent event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query != state.query) {
      emit(
        state.copyWith(
          photos: <Photo>[],
          query: event.query,
          currentPage: 1,
          isLoading: true,
          isEndOfList: false,
        ),
      );
    } else if (state.isEndOfList || state.isLoading) {
      return;
    } else {
      emit(
        state.copyWith(
          isLoading: true,
        ),
      );
    }

    try {
      List<Photo> photos = await _getTrendingPhotosUseCase.execute(
        FetchPhotosParams(
          page: state.currentPage,
          query: event.query,
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
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'No such photos',
        ),
      );
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
