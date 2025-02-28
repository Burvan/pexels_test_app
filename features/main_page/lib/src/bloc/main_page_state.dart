part of 'main_page_bloc.dart';

class MainPageState extends Equatable {
  final List<Photo> photos;
  final int currentPage;
  final bool isLoading;
  final bool isEndOfList;
  final String? errorMessage;
  final bool isPhotoSaved;

  const MainPageState({
    required this.photos,
    required this.currentPage,
    required this.isLoading,
    required this.isEndOfList,
    this.errorMessage,
    this.isPhotoSaved = false,
  });

  const MainPageState.empty()
      : photos = const <Photo>[],
        currentPage = 1,
        isLoading = false,
        isEndOfList = false,
        errorMessage = null,
        isPhotoSaved = false;

  MainPageState copyWith({
    List<Photo>? photos,
    int? currentPage,
    bool? isLoading,
    bool? isEndOfList,
    String? errorMessage,
    bool? isPhotoSaved,
  }) {
    return MainPageState(
      photos: photos ?? this.photos,
      currentPage: currentPage ?? this.currentPage,
      isLoading: isLoading ?? this.isLoading,
      isEndOfList: isEndOfList ?? this.isEndOfList,
      errorMessage: errorMessage ?? this.errorMessage,
      isPhotoSaved: isPhotoSaved ?? this.isPhotoSaved,
    );
  }

  @override
  List<Object?> get props => [
        photos,
        currentPage,
        isLoading,
        isEndOfList,
        errorMessage,
        isPhotoSaved,
      ];
}
