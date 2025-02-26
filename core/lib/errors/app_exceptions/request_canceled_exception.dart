part of errors;

class RequestCanceledException extends AppException {
  const RequestCanceledException() : super(message: 'Request cancelled');
}