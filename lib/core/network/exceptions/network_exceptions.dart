import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_exceptions.freezed.dart';

/// Custom exception class to handle various network-related errors
@freezed
class NetworkExceptions with _$NetworkExceptions {
  const factory NetworkExceptions.requestCancelled() = RequestCancelled;

  const factory NetworkExceptions.unauthorizedRequest() = UnauthorizedRequest;

  const factory NetworkExceptions.badRequest() = BadRequest;

  const factory NetworkExceptions.forbidden() = Forbidden;

  const factory NetworkExceptions.forbiddenRequest() = ForbiddenRequest;

  const factory NetworkExceptions.notFound() = NotFound;

  const factory NetworkExceptions.methodNotAllowed() = MethodNotAllowed;

  const factory NetworkExceptions.notAcceptable() = NotAcceptable;

  const factory NetworkExceptions.requestTimeout() = RequestTimeout;

  const factory NetworkExceptions.receiveTimeout() = ReceiveTimeout;

  const factory NetworkExceptions.sendTimeout() = SendTimeout;

  const factory NetworkExceptions.conflict() = Conflict;

  const factory NetworkExceptions.internalServerError() = InternalServerError;

  const factory NetworkExceptions.notImplemented() = NotImplemented;

  const factory NetworkExceptions.serviceUnavailable() = ServiceUnavailable;

  const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;

  const factory NetworkExceptions.formatException() = FormatException;

  const factory NetworkExceptions.unableToProcess() = UnableToProcess;

  const factory NetworkExceptions.defaultError(String error) = DefaultError;

  const factory NetworkExceptions.unexpectedError() = UnexpectedError;

  const factory NetworkExceptions.badCertificate() = BadCertificate;

  /// Returns a message associated with the exception type
  static String getErrorMessage(NetworkExceptions networkExceptions) {
    var errorMessage = "";

    networkExceptions.when(
      requestCancelled: () {
        errorMessage = "requestCancelled";
      },
      unauthorizedRequest: () {
        errorMessage = "unauthorizedRequest";
      },
      badRequest: () {
        errorMessage = "badRequest";
      },
      forbidden: () {
        errorMessage = "forbidden";
      },
      forbiddenRequest: () {
        errorMessage = "forbiddenRequest";
      },
      notFound: () {
        errorMessage = "notFound";
      },
      methodNotAllowed: () {
        errorMessage = "methodNotAllowed";
      },
      notAcceptable: () {
        errorMessage = "notAcceptable";
      },
      requestTimeout: () {
        errorMessage = "requestTimeout";
      },
      receiveTimeout: () {
        errorMessage = "receiveTimeout";
      },
      sendTimeout: () {
        errorMessage = "sendTimeout";
      },
      conflict: () {
        errorMessage = "conflict";
      },
      internalServerError: () {
        errorMessage = "internalServerError";
      },
      notImplemented: () {
        errorMessage = "notImplemented";
      },
      serviceUnavailable: () {
        errorMessage = "serviceUnavailable";
      },
      noInternetConnection: () {
        errorMessage = "noInternetConnection";
      },
      formatException: () {
        errorMessage = "formatException";
      },
      unableToProcess: () {
        errorMessage = "unableToProcess";
      },
      defaultError: (String error) {
        errorMessage = "defaultError";
      },
      unexpectedError: () {
        errorMessage = "unexpectedError";
      },
      badCertificate: () {
        errorMessage = "badCertificate";
      },
    );

    return errorMessage;
  }
}
