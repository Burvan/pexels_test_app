import 'package:core/services/photo_service.dart';
import 'package:data/data.dart';
import 'package:data/entities/photo/photo_entity.dart';
import 'package:domain/domain.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final ApiProvider _apiProvider;
  final MapperFactory mapper;
  final PhotoService _photoService;

  PhotoRepositoryImpl({
    required ApiProvider apiProvider,
    required PhotoService photoService,
    required this.mapper,
  })  : _apiProvider = apiProvider,
        _photoService = photoService;

  @override
  Future<List<Photo>> getTrendingPhotos({int page = 0}) async {
    final List<PhotoEntity> photos =
        await _apiProvider.fetchTrendingPhotos(page: page);
    return photos
        .map(
          (PhotoEntity entity) => mapper.photoMapper.fromEntity(entity),
        )
        .toList();
  }

  @override
  Future<void> saveToGallery(String photoUrl) async {
    await _photoService.savePhotoToGallery(photoUrl);
  }

  @override
  Future<void> sharePhoto(String photoUrl) async {
    await _photoService.sharePhoto(photoUrl);
  }
}
