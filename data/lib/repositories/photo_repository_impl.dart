import 'package:core/core.dart';
import 'package:core/services/photo_service.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final ApiProvider _apiProvider;
  final HiveProvider _hiveProvider;
  final MapperFactory mapper;
  final PhotoService _photoService;
  final InternetConnectionService _internetConnectionService;
  bool _isCacheCleared = false;

  PhotoRepositoryImpl({
    required ApiProvider apiProvider,
    required HiveProvider hiveProvider,
    required PhotoService photoService,
    required InternetConnectionService internetConnectionService,
    required this.mapper,
  })  : _apiProvider = apiProvider,
        _hiveProvider = hiveProvider,
        _photoService = photoService,
        _internetConnectionService = internetConnectionService;

  @override
  Future<List<Photo>> getTrendingPhotos(FetchPhotosParams params) async {
    final bool isInternetConnection =
        await _internetConnectionService.isInternetConnection();

    if (isInternetConnection) {
      if (!_isCacheCleared) {
        await _hiveProvider.clearCache();
        _isCacheCleared = true;
      }

      final List<PhotoEntity> photos =
          await _apiProvider.fetchTrendingPhotos(params);

      await _hiveProvider.savePhotosToCache(photos);

      return photos
          .map(
            (PhotoEntity entity) => mapper.photoMapper.fromEntity(entity),
          )
          .toList();
    } else {
      final List<PhotoEntity> photos = await _hiveProvider.getPhotosFromCache();

      return photos
          .map((PhotoEntity entity) => mapper.photoMapper.fromEntity(entity))
          .toList();
    }
  }

  @override
  Future<void> saveToGallery(String photoUrl) async {
    await _photoService.savePhotoToGallery(photoUrl);
  }

  @override
  Future<void> sharePhoto(String photoUrl) async {
    await _photoService.sharePhoto(photoUrl);
  }

  @override
  Future<bool> checkInternetConnection() async {
    return _internetConnectionService.isInternetConnection();
  }
}
