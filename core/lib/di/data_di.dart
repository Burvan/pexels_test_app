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

    ///Adapters
    appLocator.registerLazySingleton<SearchRequestEntityAdapter>(
          () => SearchRequestEntityAdapter(),
    );

    ///Hive
    await Hive.initFlutter();

    Hive.registerAdapter(
      appLocator.get<SearchRequestEntityAdapter>(),
    );

    ///Providers
    appLocator.registerLazySingleton<ApiProvider>(
      () => ApiProvider(
        mapper: appLocator.get<MapperFactory>(),
        errorHandler: appLocator.get<DioErrorHandler>(),
      ),
    );

    appLocator.registerLazySingleton<HiveProvider>(
      () => HiveProvider(),
    );

    ///Repositories
    appLocator.registerLazySingleton<PhotoRepository>(
      () => PhotoRepositoryImpl(
        apiProvider: appLocator.get<ApiProvider>(),
        mapper: appLocator.get<MapperFactory>(),
        photoService: appLocator.get<PhotoService>(),
      ),
    );

    appLocator.registerLazySingleton<SearchHistoryRepository>(
      () => SearchHistoryRepositoryImpl(
        mapper: appLocator.get<MapperFactory>(),
        hiveProvider: appLocator.get<HiveProvider>(),
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

    appLocator.registerLazySingleton<AddRequestToHistoryUseCase>(
      () => AddRequestToHistoryUseCase(
        searchHistoryRepository: appLocator.get<SearchHistoryRepository>(),
      ),
    );

    appLocator.registerLazySingleton<GetSearchHistoryUseCase>(
      () => GetSearchHistoryUseCase(
        searchHistoryRepository: appLocator.get<SearchHistoryRepository>(),
      ),
    );

    appLocator.registerLazySingleton<ClearSearchHistoryUseCase>(
      () => ClearSearchHistoryUseCase(
        searchHistoryRepository: appLocator.get<SearchHistoryRepository>(),
      ),
    );
  }
}
