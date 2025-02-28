part of errors;

class PhotoSaveException extends AppException {
  const PhotoSaveException() : super(message: 'Photo saving error');
}
