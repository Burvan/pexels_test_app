part of 'main_page_bloc.dart';

class MainPageState extends Equatable {
  final List<Photo> photos;
  final int currentPage;
  final bool isLoading;
  final bool isEndOfList;
  final bool isInternet;
  final String? errorMessage;

  const MainPageState({
    required this.photos,
    required this.currentPage,
    required this.isLoading,
    required this.isEndOfList,
    required this.isInternet,
    this.errorMessage,
  });

  const MainPageState.empty()
      : photos = const <Photo>[],
        currentPage = 1,
        isLoading = false,
        isEndOfList = false,
        isInternet = true,
        errorMessage = null;

  MainPageState copyWith({
    List<Photo>? photos,
    int? currentPage,
    bool? isLoading,
    bool? isEndOfList,
    bool? isInternet,
    String? errorMessage,
  }) {
    return MainPageState(
      photos: photos ?? this.photos,
      currentPage: currentPage ?? this.currentPage,
      isLoading: isLoading ?? this.isLoading,
      isEndOfList: isEndOfList ?? this.isEndOfList,
      isInternet: isInternet ?? this.isInternet,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        photos,
        currentPage,
        isLoading,
        isEndOfList,
        isInternet,
        errorMessage,
      ];
}
