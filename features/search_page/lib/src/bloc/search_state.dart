part of 'search_bloc.dart';

class SearchState extends Equatable {
  final List<Photo> photos;
  final bool isLoading;
  final bool isEndOfList;
  final int currentPage;
  final List<SearchRequest> searchHistory;
  final String? errorMessage;
  final String? query;

  const SearchState({
    required this.photos,
    required this.isLoading,
    required this.isEndOfList,
    required this.currentPage,
    required this.searchHistory,
    this.errorMessage,
    this.query,
  });

  const SearchState.empty()
      : photos = const <Photo>[],
        isLoading = false,
        isEndOfList = false,
        currentPage = 1,
        searchHistory = const <SearchRequest>[],
        errorMessage = null,
        query = null;

  SearchState copyWith({
    List<Photo>? photos,
    bool? isLoading,
    bool? isEndOfList,
    int? currentPage,
    List<SearchRequest>? searchHistory,
    String? errorMessage,
    String? query,
  }) {
    return SearchState(
      photos: photos ?? this.photos,
      isLoading: isLoading ?? this.isLoading,
      isEndOfList: isEndOfList ?? this.isEndOfList,
      currentPage: currentPage ?? this.currentPage,
      searchHistory: searchHistory ?? this.searchHistory,
      errorMessage: errorMessage ?? this.errorMessage,
      query: query ?? this.query,
    );
  }

  @override
  List<Object?> get props => [
        photos,
        isLoading,
        isEndOfList,
        currentPage,
        searchHistory,
        errorMessage,
        query,
      ];
}
