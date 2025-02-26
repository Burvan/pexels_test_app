part of errors;

class DioErrorHandler {
  AppException handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return const NetworkTimeoutException();
      case DioExceptionType.badResponse:
        return ApiException(
          message: error.response?.statusMessage ?? 'No message',
          statusCode: error.response?.statusCode,
        );
      case DioExceptionType.cancel:
        return const RequestCanceledException();
      case DioExceptionType.unknown:
        return NetworkException(message: error.message ?? 'Unknown error');
      default:
        return UnknownException(message: error.message ?? 'Unknown error');
    }
  }
}