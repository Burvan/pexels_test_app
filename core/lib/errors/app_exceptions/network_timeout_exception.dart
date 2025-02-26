part of errors;

class NetworkTimeoutException extends AppException {
  const NetworkTimeoutException() : super(message: 'Network timeout exceeded');
}