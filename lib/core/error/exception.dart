class ErrorModelException implements Exception {
  final String errorMessage;

  ErrorModelException({required this.errorMessage});

  factory ErrorModelException.fromJson(Map<String, dynamic> json) {
    return ErrorModelException(errorMessage: json['message']);
  }
}

class ServerException implements Exception {}

class ConnectionTimeoutException implements Exception {}

class UnauthorizedException implements Exception {}

class InternetException implements Exception {}
