import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';

final DataDI dataDI = DataDI();

class DataDI {
  Future<void> setupAppLocator() async {
    appLocator.registerLazySingleton<MapperFactory>(
      () => MapperFactory(),
    );

    appLocator.registerLazySingleton<DioErrorHandler>(
      () => DioErrorHandler(),
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
      ),
    );

    ///UseCases
    appLocator.registerLazySingleton<GetTrendingPhotosUseCase>(
      () => GetTrendingPhotosUseCase(
        photoRepository: appLocator.get<PhotoRepository>(),
      ),
    );
  }
}
