class AppException implements Exception {
  final String? message;
  final String? prefix;
  final String? url;

  AppException([this.message, this.prefix, this.url]);
}

class NoInternetConnectionException extends AppException {
  NoInternetConnectionException() : super('No Internet connection');
}

class BadRequestException extends AppException {
  BadRequestException([String? message, String? url])
      : super(message, 'Bad Request', url);
}

class UnauthorizedException extends AppException {
  UnauthorizedException([String? message, String? url])
      : super(message, 'Unauthorized Request', url);
}

class ApiNotRespondingException extends AppException {
  ApiNotRespondingException([String? message, String? url])
      : super(message, 'Api not responding', url);
}

class FetchDataException extends AppException {
  FetchDataException([String? message, String? url])
      : super(message, 'Unable to process', url);
}

class DataNotFoundException extends AppException {
  DataNotFoundException([String? message, String? url])
      : super(message, 'Data not found', url);
}
