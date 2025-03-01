import 'package:domain/domain.dart';

abstract interface class PhotoRepository {
  Future<List<Photo>> getTrendingPhotos({int page = 0});
  Future<void> saveToGallery(String photoUrl);
  Future<void> sharePhoto(String photoUrl);
}