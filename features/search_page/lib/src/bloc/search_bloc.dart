import 'package:core/core.dart';
import 'package:domain/domain.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetTrendingPhotosUseCase _getTrendingPhotosUseCase;
  final AddRequestToHistoryUseCase _addRequestToHistoryUseCase;
  final GetSearchHistoryUseCase _getSearchHistoryUseCase;
  final ClearSearchHistoryUseCase _clearSearchHistoryUseCase;

  SearchBloc({
    required GetTrendingPhotosUseCase getTrendingPhotosUseCase,
    required AddRequestToHistoryUseCase addRequestToHistoryUseCase,
    required GetSearchHistoryUseCase getSearchHistoryUseCase,
    required ClearSearchHistoryUseCase clearSearchHistoryUseCase,
  })  : _getTrendingPhotosUseCase = getTrendingPhotosUseCase,
        _addRequestToHistoryUseCase = addRequestToHistoryUseCase,
        _getSearchHistoryUseCase = getSearchHistoryUseCase,
        _clearSearchHistoryUseCase = clearSearchHistoryUseCase,
        super(const SearchState.empty()) {
    on<SearchPhotosEvent>(_onSearchPhotos);
    on<LoadSearchHistoryEvent>(_onLoadSearchHistory);
    on<ClearHistoryEvent>(_onClearHistory);
  }

  Future<void> _onSearchPhotos(
    SearchPhotosEvent event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query != state.query) {
      await _addRequestToHistoryUseCase.execute(event.query);

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
      print(state.photos.length);
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

  Future<void> _onLoadSearchHistory(
    LoadSearchHistoryEvent event,
    Emitter<SearchState> emit,
  ) async {
    final List<SearchRequest> searchHistory =
        await _getSearchHistoryUseCase.execute(const NoParams());

    emit(
      state.copyWith(searchHistory: searchHistory),
    );
  }

  Future<void> _onClearHistory(
      ClearHistoryEvent event,
      Emitter<SearchState> emit,
      ) async {
    await _clearSearchHistoryUseCase.execute(const NoParams());

    emit(
      state.copyWith(searchHistory: <SearchRequest>[]),
    );
  }
}
