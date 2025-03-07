import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class PhotoService {
  final Dio _dio;
  final DioErrorHandler _errorHandler;

  PhotoService({required Dio dio, required DioErrorHandler errorHandler})
      : _dio = dio,
        _errorHandler = errorHandler;

  Future<void> savePhotoToGallery(String photoUrl) async {
    try {
      final response = await _dio.get(
        photoUrl,
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );

      if (response.statusCode == 200) {
        final result = await ImageGallerySaverPlus.saveImage(
          Uint8List.fromList(response.data! as List<int>),
          quality: 100,
          name: "photo_${DateTime.now().millisecondsSinceEpoch}",
        );
        if (result['isSuccess'] == true) {
          print('Photo saved to gallery');
        } else {
          throw PhotoSaveException();
        }
      } else {
        throw PhotoDownloadException(
          message: response.statusMessage ?? 'No message',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      throw _errorHandler.handleDioError(e);
    } catch (e) {
      throw UnknownException(message: e.toString());
    }
  }

  Future<void> sharePhoto(String photoUrl) async {
    try {
      final response = await _dio.get(
        photoUrl,
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );

      if(response.statusCode == 200) {
        final directory = await getTemporaryDirectory();
        final file = File('${directory.path}/photo.jpg');

        await file.writeAsBytes(response.data as List<int>);
        await Share.shareXFiles([XFile(file.path)]);
      } else {
        throw PhotoDownloadException(
          message: response.statusMessage ?? 'No message',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      throw _errorHandler.handleDioError(e);
    } catch (e) {
      throw PhotoShareException(message: '$e');
    }
  }
}
