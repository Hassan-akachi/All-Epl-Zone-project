sealed class NetworkResponse<T> {
  const NetworkResponse();
}

class NetworkSuccess<T> extends NetworkResponse<T> {
  final T data;
  final int? statusCode;

  const NetworkSuccess(this.data, {this.statusCode});
}

class NetworkFailure<T> extends NetworkResponse<T> {
  final String message;
  final int? statusCode;
  final dynamic error;

  const NetworkFailure(
      this.message, {
        this.statusCode,
        this.error,
      });
}

class NetworkException<T> extends NetworkResponse<T> {
  final String message;
  final dynamic exception;

  const NetworkException({
    required this.message,
    this.exception,
  });
}