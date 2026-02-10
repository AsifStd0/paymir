class AppException implements Exception{
  final String? Message;
  final String? _prefix;

  AppException([this.Message, this._prefix]);

 String toString(){
    return "$Message $_prefix";
 }
}

class FetchDataException extends AppException{
  FetchDataException([String? message]): super(message, 'Error During Communication');
}

class BadRequestException extends AppException{
  BadRequestException([String? message]) : super(message , 'Invalid Request');
}

class UnauthorisedException extends AppException {
  UnauthorisedException([String? message])
      : super(message, 'Unauthorised request');
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, 'Invalid Inpit');
}