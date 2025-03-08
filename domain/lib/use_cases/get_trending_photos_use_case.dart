import 'package:domain/domain.dart';

class GetTrendingPhotosUseCase
    implements FutureUseCase<List<Photo>, FetchPhotosParams> {
  final PhotoRepository _photoRepository;

  GetTrendingPhotosUseCase({
    required PhotoRepository photoRepository,
  }) : _photoRepository = photoRepository;

  @override
  Future<List<Photo>> execute(FetchPhotosParams input) async {
    return _photoRepository.getTrendingPhotos(
      FetchPhotosParams(
        page: input.page,
        query: input.query,
      ),
    );
  }
}
