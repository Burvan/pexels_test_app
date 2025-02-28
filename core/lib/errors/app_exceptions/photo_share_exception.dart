part of errors;

class PhotoShareException extends AppException {
  @override
  final String message;

  const PhotoShareException({
    required this.message,
  }) : super(message: 'Error when trying to share a photo: $message');
}