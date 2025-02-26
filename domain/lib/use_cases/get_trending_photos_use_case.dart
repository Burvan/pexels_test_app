import 'package:domain/domain.dart';

class GetTrendingPhotosUseCase implements FutureUseCase<List<Photo>, int> {
  final PhotoRepository _photoRepository;

  GetTrendingPhotosUseCase({
    required PhotoRepository photoRepository,
  }) : _photoRepository = photoRepository;

  @override
  Future<List<Photo>> execute(int input) {
    return _photoRepository.getTrendingPhotos(page: input);
  }
}
