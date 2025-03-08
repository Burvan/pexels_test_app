import 'package:domain/domain.dart';

abstract interface class PhotoRepository {
  Future<List<Photo>> getTrendingPhotos(FetchPhotosParams params);
  Future<void> saveToGallery(String photoUrl);
  Future<void> sharePhoto(String photoUrl);
  Future<bool> checkInternetConnection();
}