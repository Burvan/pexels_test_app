import 'package:core/core.dart';
import 'package:core/services/photo_service.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';

final DataDI dataDI = DataDI();

class DataDI {
  Future<void> setupAppLocator() async {
    appLocator.registerLazySingleton<MapperFactory>(
      () => MapperFactory(),
    );

    appLocator.registerLazySingleton<Dio>(
          () => Dio(),
    );

    appLocator.registerLazySingleton<DioErrorHandler>(
      () => DioErrorHandler(),
    );

    appLocator.registerLazySingleton<PhotoService>(
      () => PhotoService(
        dio: appLocator.get<Dio>(),
        errorHandler: appLocator.get<DioErrorHandler>(),
      ),
    );

    ///Providers
    appLocator.registerLazySingleton<ApiProvider>(
      () => ApiProvider(
        mapper: appLocator.get<MapperFactory>(),
        errorHandler: appLocator.get<DioErrorHandler>(),
      ),
    );

    ///Repositories
    appLocator.registerLazySingleton<PhotoRepository>(
      () => PhotoRepositoryImpl(
        apiProvider: appLocator.get<ApiProvider>(),
        mapper: appLocator.get<MapperFactory>(),
        photoService: appLocator.get<PhotoService>(),
      ),
    );

    ///UseCases
    appLocator.registerLazySingleton<GetTrendingPhotosUseCase>(
      () => GetTrendingPhotosUseCase(
        photoRepository: appLocator.get<PhotoRepository>(),
      ),
    );

    appLocator.registerLazySingleton<SavePhotoToGalleryUseCase>(
      () => SavePhotoToGalleryUseCase(
        photoRepository: appLocator.get<PhotoRepository>(),
      ),
    );

    appLocator.registerLazySingleton<SharePhotoUseCase>(
      () => SharePhotoUseCase(
        photoRepository: appLocator.get<PhotoRepository>(),
      ),
    );
  }
}
