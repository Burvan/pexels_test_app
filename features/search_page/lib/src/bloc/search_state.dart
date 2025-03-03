part of 'search_bloc.dart';

class SearchState extends Equatable {
  final List<Photo> photos;
  final bool isLoading;
  final bool isEndOfList;
  final int currentPage;
  final String? errorMessage;
  final String? query;

  const SearchState({
    required this.photos,
    required this.isLoading,
    required this.isEndOfList,
    required this.currentPage,
    this.errorMessage,
    this.query,
  });

  const SearchState.empty()
      : photos = const <Photo>[],
        isLoading = false,
        isEndOfList = false,
        currentPage = 1,
        errorMessage = null,
        query = null;

  SearchState copyWith({
    List<Photo>? photos,
    bool? isLoading,
    bool? isEndOfList,
    int? currentPage,
    String? errorMessage,
    String? query,
  }) {
    return SearchState(
      photos: photos ?? this.photos,
      isLoading: isLoading ?? this.isLoading,
      isEndOfList: isEndOfList ?? this.isEndOfList,
      currentPage: currentPage ?? this.currentPage,
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
        errorMessage,
        query,
      ];
}
