sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T data;

  const Success(this.data);
}

class Failure<T> extends Result<T> {
  final AppError error;

  const Failure(this.error);
}

sealed class AppError {
  const AppError();
}

class NetworkError extends AppError {
  final String message;

  const NetworkError(this.message);
}

class NotFoundError extends AppError {
  final String resource;

  const NotFoundError(this.resource);
}

class UnauthorizedError extends AppError {
  const UnauthorizedError();
}

class ValidationError extends AppError {
  final Map<String, String> fields;

  const ValidationError(this.fields);
}
