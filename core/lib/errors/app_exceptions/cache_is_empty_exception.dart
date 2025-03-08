part of errors;

class CachedDataIsEmptyException extends AppException {
  const CachedDataIsEmptyException() : super(message: 'Cached data is empty');
}