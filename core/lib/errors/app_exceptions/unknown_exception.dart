part of errors;

class UnknownException extends AppException {
  @override
  final String message;

  const UnknownException({
    required this.message,
  }) : super(message: 'Unknown error: $message');
}