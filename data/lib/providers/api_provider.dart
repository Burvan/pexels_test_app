import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:data/entities/photo/photo_entity.dart';

class ApiProvider {
  final MapperFactory mapper;
  final DioErrorHandler _errorHandler;
  final String key = AppConstants.key;

  ApiProvider({
    required this.mapper,
    required DioErrorHandler errorHandler,
  }) : _errorHandler = errorHandler;

  Future<List<PhotoEntity>> fetchTrendingPhotos({int page = 0}) async {
    try {
      const String baseurl = AppConstants.baseUrl;

      final Uri uri = Uri.parse('$baseurl/curated?page=$page&per_page=40');

      final Response<Map<String, dynamic>> response = await Dio().get(
        uri.toString(),
        options: Options(
          headers: {
            'Authorization': key,
          },
        ),
      );
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data!;

        if(data.containsKey('photos')) {
          final List<dynamic> results = data['photos'];

          final List<PhotoEntity> photos = results
              .map((json) {
            return PhotoEntity.fromJson(json as Map<String, dynamic>);
          })
              .toList();

          return photos;
        } else {
          throw ApiException(
            message: 'Key "photos" not found in response',
            statusCode: response.statusCode,
          );
        }
      } else {
        throw ApiException(
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
}
