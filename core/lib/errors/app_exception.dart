part of errors;

abstract class AppException implements Exception {
  final String? message;

  const AppException({required this.message});
}