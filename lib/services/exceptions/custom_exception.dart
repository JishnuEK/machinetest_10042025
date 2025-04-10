// lib/exceptions/event_exceptions.dart

// Base exception class with message field
class EventServiceException implements Exception {
  final String message;
  EventServiceException(this.message);

  @override
  String toString() => 'EventServiceException: $message';
}

// Network-specific exception
class NetworkException extends EventServiceException {
  NetworkException(String message) : super(message);
}

// API exception with status code
class ApiException extends EventServiceException {
  final int statusCode;

  ApiException(String message, this.statusCode) : super(message);

  @override
  String toString() => 'ApiException: $message (Status: $statusCode)';
}

// Specific API exceptions (400-500 range)
class BadRequestException extends ApiException {
  BadRequestException(String message) : super(message, 400);
}

class UnauthorizedException extends ApiException {
  UnauthorizedException(String message) : super(message, 401);
}

class ForbiddenException extends ApiException {
  ForbiddenException(String message) : super(message, 403);
}

class NotFoundException extends ApiException {
  NotFoundException(String message) : super(message, 404);
}

class ServerException extends ApiException {
  ServerException(String message) : super(message, 500);
}

// Data parsing exception
class DataParsingException extends EventServiceException {
  DataParsingException(String message) : super(message);
}
