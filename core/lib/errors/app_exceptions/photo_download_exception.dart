part of errors;

class PhotoDownloadException extends AppException {
  final int? statusCode;
  @override
  final String message;

  const PhotoDownloadException({
    this.statusCode,
    required this.message,
  }) : super(
    message:
    'Downloading error (Status code: ${statusCode ?? "Unknown"}): $message',
  );
}