part of errors;

class ApiException extends AppException {
  final int? statusCode;
  @override
  final String message;

  const ApiException({
    this.statusCode,
    required this.message,
  }) : super(
    message:
    'API error (Status code: ${statusCode ?? "Unknown"}): $message',
  );
}