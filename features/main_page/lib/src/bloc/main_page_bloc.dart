import 'dart:async';

import 'package:core/core.dart';
import 'package:domain/domain.dart';

part 'main_page_state.dart';
part 'main_page_event.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final GetTrendingPhotosUseCase _getTrendingPhotosUseCase;
  final InternetConnectionService _internetConnectionService;
  StreamSubscription<bool>? _internetSubscription;

  MainPageBloc(
      {required GetTrendingPhotosUseCase getTrendingPhotosUseCase,
      required InternetConnectionService internetConnectionService})
      : _getTrendingPhotosUseCase = getTrendingPhotosUseCase,
        _internetConnectionService = internetConnectionService,
        super(const MainPageState.empty()) {
    on<InitEvent>(_onInit);
    on<GetTrendingPhotosNextPageEvent>(_onGetTrendingPhotos);
    on<InternetStatusChangedEvent>(_onInternetStatusChanged);

    _internetSubscription =
        _internetConnectionService.onInternetStatusChanged.listen(
      (bool isInternet) {
        add(
          InternetStatusChangedEvent(isInternet: isInternet),
        );
      },
    );

    add(const InitEvent());
  }

  void _onInit(
    InitEvent event,
    Emitter<MainPageState> emit,
  ) async {
    final bool isInternet =
        await _internetConnectionService.isInternetConnection();

    emit(state.copyWith(isInternet: isInternet));

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
    } on ApiException catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: e.message,
        ),
      );
    } on CachedDataIsEmptyException catch (e) {
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
          errorMessage: 'An unexpected error occurred',
        ),
      );
    }
  }

  void _onInternetStatusChanged(
    InternetStatusChangedEvent event,
    Emitter<MainPageState> emit,
  ) {
    emit(
      state.copyWith(
        isInternet: event.isInternet,
      ),
    );
  }

  @override
  Future<void> close() {
    _internetSubscription?.cancel();
    return super.close();
  }
}
