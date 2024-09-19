import 'package:equatable/equatable.dart';

class ApiResult<T> extends Equatable {
  final Status status;
  final T? data;
  final String? message;
  final ErrorType? errorType;

  const ApiResult._(
      {required this.status, this.data, this.message, this.errorType});

  const ApiResult.error(this.message,
      {this.status = Status.error,
      this.errorType = ErrorType.generic,
      this.data});

  const ApiResult.loading(
      {this.status = Status.loading, this.data, this.message, this.errorType});
  const ApiResult.success(this.data,
      {this.status = Status.success, this.message, this.errorType});
  const ApiResult.deleteSuccess(this.message,
      {this.data, this.status = Status.success, this.errorType});
  const ApiResult.connectionFailed(
      {this.data,
      this.status = Status.error,
      this.message = "Connection Failed",
      this.errorType = ErrorType.connectionFailed});

  const ApiResult.invalidUsernamePassword(
      {this.data,
      this.status = Status.error,
      this.message = "Invalid Username or password",
      this.errorType = ErrorType.invalidUsernamePassword});

  const ApiResult.usernamePasswordNotSupported(
      {this.data,
      this.message = "Username or Password is not Supported",
      this.status = Status.error,
      this.errorType = ErrorType.usernamePasswordNotSupported});
  const ApiResult.sessionExpired(
      {this.status = Status.error,
      this.data,
      this.message = "Please login to continue",
      this.errorType = ErrorType.sessionExpired});

  const ApiResult.noInternet({
    this.status = Status.error,
    this.message = "No Internet Connection",
    this.data,
    this.errorType = ErrorType.noInternet,
  });

  @override
  List<Object?> get props => [status, data, message, errorType];
}

enum Status { loading, success, error, saved, initial }

enum ErrorType {
  noInternet,
  serverDown,
  sessionExpired,
  noSession,
  serverNotSupported,
  invalidUsernamePassword,
  usernamePasswordNotSupported,
  generic,
  connectionFailed,
  emptyData,
}
