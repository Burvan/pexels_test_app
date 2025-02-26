part of errors;

class NetworkException extends AppException {
  @override
  final String message;

  const NetworkException({
    required this.message,
  }) : super(message: 'Network error: $message');
}