import 'package:core/core.dart';
import 'package:domain/domain.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetTrendingPhotosUseCase _getTrendingPhotosUseCase;
  final AddRequestToHistoryUseCase _addRequestToHistoryUseCase;
  final GetSearchHistoryUseCase _getSearchHistoryUseCase;
  final ClearSearchHistoryUseCase _clearSearchHistoryUseCase;
  final CheckInternetConnectionUseCase _checkInternetConnectionUseCase;

  SearchBloc({
    required GetTrendingPhotosUseCase getTrendingPhotosUseCase,
    required AddRequestToHistoryUseCase addRequestToHistoryUseCase,
    required GetSearchHistoryUseCase getSearchHistoryUseCase,
    required ClearSearchHistoryUseCase clearSearchHistoryUseCase,
    required CheckInternetConnectionUseCase checkInternetConnectionUseCase,
  })  : _getTrendingPhotosUseCase = getTrendingPhotosUseCase,
        _addRequestToHistoryUseCase = addRequestToHistoryUseCase,
        _getSearchHistoryUseCase = getSearchHistoryUseCase,
        _clearSearchHistoryUseCase = clearSearchHistoryUseCase,
        _checkInternetConnectionUseCase = checkInternetConnectionUseCase,
        super(const SearchState.empty()) {
    on<SearchPhotosEvent>(_onSearchPhotos);
    on<LoadSearchHistoryEvent>(_onLoadSearchHistory);
    on<ClearHistoryEvent>(_onClearHistory);
  }

  Future<void> _onSearchPhotos(
    SearchPhotosEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(state.copyWith(errorMessage: null));

    if (event.query != state.query) {
      await _addRequestToHistoryUseCase.execute(event.query);

      emit(
        state.copyWith(
          photos: <Photo>[],
          query: event.query,
          currentPage: 1,
          isLoading: true,
          isEndOfList: false,
          errorMessage: null,
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
      final bool isInternetConnection =
      await _checkInternetConnectionUseCase.execute(
        NoParams(),
      );

      if (!isInternetConnection) {
        emit(
          state.copyWith(
            isLoading: false,
            photos: <Photo>[],
            errorMessage: AppConstants.noInternetConnection,
          ),
        );
        return;
      }

      List<Photo> photos = await _getTrendingPhotosUseCase.execute(
        FetchPhotosParams(
          page: state.currentPage,
          query: event.query,
        ),
      );

      if (photos.isEmpty && !state.isEndOfList) {
        emit(
          state.copyWith(
            isLoading: false,
            photos: <Photo>[],
            errorMessage: AppConstants.noResultsFound,
          ),
        );
      }

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
    } on ApiException catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: AppConstants.unexpectedError,
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
