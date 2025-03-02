import 'package:domain/domain.dart';
import 'package:domain/models/params/fetchPhotosParams.dart';

abstract interface class PhotoRepository {
  Future<List<Photo>> getTrendingPhotos(FetchPhotosParams params);
  Future<void> saveToGallery(String photoUrl);
  Future<void> sharePhoto(String photoUrl);
}