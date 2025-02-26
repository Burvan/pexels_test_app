import 'package:data/data.dart';
import 'package:data/entities/photo/photo_entity.dart';
import 'package:domain/domain.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final ApiProvider _apiProvider;
  final MapperFactory mapper;

  PhotoRepositoryImpl({
    required ApiProvider apiProvider,
    required this.mapper,
  }) : _apiProvider = apiProvider;

  @override
  Future<List<Photo>> getTrendingPhotos({int page = 0}) async {
    final List<PhotoEntity> photos =
        await _apiProvider.fetchTrendingPhotos(page: page);
    return photos
        .map((PhotoEntity entity) => mapper.photoMapper.fromEntity(entity),)
        .toList();
  }
}
