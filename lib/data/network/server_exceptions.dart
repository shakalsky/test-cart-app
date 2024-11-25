abstract class ServerException implements Exception {}

class ConnectionTimeoutException extends ServerException {}

class SendTimeoutException extends ServerException {}

class ReceiveTimeoutException extends ServerException {}

class BadCertificateException extends ServerException {}

class BadResponseException extends ServerException {
  final int statusCode;
  final String message;

  BadResponseException({
    required this.statusCode,
    required this.message,
  });

  @override
  String toString() => 'Bad response: [$statusCode] - $message';
}

class CancelException extends ServerException {}

class ConnectionErrorException extends ServerException {}

class UnknownException extends ServerException {}
